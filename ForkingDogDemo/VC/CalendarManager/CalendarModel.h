//
//  CalendarModel.h
//  app
//
//  Created by ios2 on 2018/8/22.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LGCalendarType)
{
	LGCalendarTodayType = 0,
	LGCalendarLastType,
	LGCalendarNextType
};
@interface CalendarHeaderModel:NSObject
//月份的头信息
@property (nonatomic,copy)NSString *headerText;
//当前月的数组
@property (nonatomic,strong)NSArray *calendarItemArray;

@end

@interface CalendarModel : NSObject

@property (nonatomic,assign)NSInteger year;
@property (nonatomic,assign)NSInteger month;
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,copy)NSString *holiday;            // 节日
@property (nonatomic,assign)NSInteger dateInterval; // 日期的时间戳
@property (nonatomic,assign)NSInteger week;// 星期
@property (nonatomic,assign)LGCalendarType type;

@end
