//
//  NSObject+LgObserver.h
//  ScrollTableDemo
//
//  Created by ios2 on 2018/12/13.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * lgMsgKey = @"obserVerkey";

@interface LgOberver : NSObject

@property (nonatomic,strong)NSMutableArray *keyCacheArray;

//信息发生修改
@property (nonatomic,copy)void(^didChageMsg)(id msg);

//修改被观察者
/** 默认被观察者是对象自己
 * 修改被观察者将重置所有的监听之前的监听将不存在
 * 方法监听回调方法也将不存在
 */
-(LgOberver*(^)(id))changeObserved;

-(LgOberver *(^)(NSString *))addObserverKey;

-(LgOberver *(^)(NSString *))removeObserverKey;

@end

@interface NSObject (LgObserver)

@property (nonatomic,strong)LgOberver *lgOberVer;

@end


