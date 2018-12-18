//
//  JokeModels.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/18.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "JokeModels.h"
@implementation JokeModel

//主键映射属性
+ (NSDictionary *)modelCustomPropertyMapper {
	return @{
			 @"Id": @"id"
			 };
}

@end

@implementation JokeModels

 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"jsokes" : [JokeModel class]
 };
 }

@end
