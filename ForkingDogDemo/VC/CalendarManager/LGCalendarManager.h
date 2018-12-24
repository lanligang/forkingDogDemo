//
//  LGCalendarManager.h
//  app
//
//  Created by ios2 on 2018/8/22.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CalendarShowType)
{
	CalendarLastType = 0,// 只显示当前月之前
	CalendarMiddleType,// 前后各显示一半
	CalendarNextType// 只显示当前月之后
};

@interface LGCalendarManager : NSObject

@property (nonatomic,strong)NSIndexPath *startIndexPath;

//初始化方法
-(instancetype)initWithStartDate:(NSInteger)startDate;

//获取月份数的所有参数 在主线程读取月数组
- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth type:(CalendarShowType)type;


@end
