//
//  ObjcMethod.m
//  ForkingDogDemo
//
//  Created by mc on 2019/1/2.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import "ObjcMethod.h"

@implementation ObjcMethod
+(BOOL)changeMethodWithClass:(Class)aClass andSel:(SEL)aSel andOtherSel:(SEL)otherSel
{
	if (aClass) {
		Method m1 = class_getInstanceMethod(aClass, aSel);
		Method m2 = class_getInstanceMethod(aClass, aSel);
		if (m1 && m2) {
			method_exchangeImplementations(m1, m2);
			return YES;
		}
	}
	return NO;
}

+(BOOL)metaChangeMethodWithClass:(Class)aClass andSel:(SEL)aSel andOtherSel:(SEL)otherSel
{
	Class metaClass = object_getClass(aClass);
	return [self changeMethodWithClass:metaClass andSel:aSel andOtherSel:otherSel];
}

+(NSArray *)getPropertyListWithClass:(Class)aClass
{
	NSMutableArray *propertyList = [NSMutableArray array];
	if (aClass != nil) {
		Class currentClass = aClass;
		NSString *className = [NSString stringWithFormat:@"%@",currentClass];
			while (![className isEqualToString:@"NSObject"]) {
				unsigned int count;
				objc_property_t *propertys = class_copyPropertyList(currentClass, &count);
				for (int i = 0; i< count; i++) {
					objc_property_t p = propertys[i];
				    const char *cname = property_getAttributes(p);
					NSString *attrs = @(property_getAttributes(p));
					NSUInteger dotLoc = [attrs rangeOfString:@","].location;
					NSString *code = nil;
					NSUInteger loc = 3;
					if (dotLoc == NSNotFound) { // 没有,
						code = [attrs substringFromIndex:loc];
					} else {
						code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc-1)];
					}
					const char *cName = property_getName(p);
					// 转换为Objective C 字符串
					NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
					
					if (!code) {
						NSString *aName = [NSString stringWithCString:cname encoding:NSUTF8StringEncoding];
						NSArray *tNames = [aName componentsSeparatedByString:@","];
						if (tNames&&tNames.count>0) {
							NSString *typeName = tNames.firstObject;
							if ([typeName isEqualToString:@"Td"]) {
								//double
								code = @"double";
							}else if ([typeName isEqualToString:@"Ti"]){
								//int
								code = @"int";
							}else if ([typeName isEqualToString:@"Tf"]){
								//float
								code = @"float";
							}else if ([typeName isEqualToString:@"Tq"]){
								//NSInteger
								code = @"NSInteger";
							}else if ([typeName isEqualToString:@"T*"]){
								code = @"char";
							}
						}
					}
					[propertyList addObject:@{@"name":name,@"type":code}];
				}
				free(propertys);
				//重新赋值当前类型
			    NSObject *obj = [[currentClass alloc]init];
				currentClass = obj.superclass;
				className = [NSString stringWithFormat:@"%@",currentClass];
			}
	}
	return propertyList;
}




@end
