//
//  ObjcMethod.h
//  ForkingDogDemo
//
//  Created by mc on 2019/1/2.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcMethod : NSObject

/** 对象方法交换
 * aClass   要交换的类型
 * aSel     要交换的A方法
 * otherSel 要交换的B方法
 * return 是否成功
 */
+(BOOL)changeMethodWithClass:(Class)aClass andSel:(SEL)aSel andOtherSel:(SEL)otherSel;

/** 类交换方法
 * aClass   要交换的类型
 * aSel     要交换的A方法
 * otherSel 要交换的B方法
 * return 是否成功
 */
+(BOOL)metaChangeMethodWithClass:(Class)aClass andSel:(SEL)aSel andOtherSel:(SEL)otherSel;

/** 获取一个类的属性 以及类型
 * 基本数据类型 字符形式 ‘int,double,float,char,NSInteger,BOOL’
 * 其他类型都以 class 的String 类型表示
 */
+(NSArray *)getPropertyListWithClass:(Class)aClass;

@end
