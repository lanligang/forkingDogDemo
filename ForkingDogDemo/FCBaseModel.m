//
//  FCBaseModel.m
//  FriendChat
//
//  Created by ios2 on 2018/3/5.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "FCBaseModel.h"
#import <YYModel.h>


@implementation FCBaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self yy_modelSetWithDictionary:dic];
    }
    return self;
}
//对象序列化
-(NSData *)ecode
{
   return   [NSKeyedArchiver archivedDataWithRootObject:self];
}

//对象反对象序列化  
+(instancetype)decodeWithData:(NSData *)data
{
    if (data) {
         return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else{
       return  nil;
    }
}

/*
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"commentaries" : [PlObjct class]
 };
 }
 //主键映射属性
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"name"  : @"n",
 @"page"  : @"p",
 @"desc"  : @"ext.desc",
 @"bookID": @[@"id", @"ID", @"book_id"]
 };
 }
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
