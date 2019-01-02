//
//  FCBaseModel.h
//  FriendChat
//
//  Created by ios2 on 2018/3/5.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCBaseModel : NSObject<NSCoding>

@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *testAAA;

//初始化
-(instancetype)initWithDictionary:(NSDictionary *)dic;

-(NSData *)ecode;

+(instancetype)decodeWithData:(NSData *)data;


@end
