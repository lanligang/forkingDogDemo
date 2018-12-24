//
//  PopCalendarView.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/24.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCalendarManager.h"

@interface PopCalendarView : UIView


+(instancetype)showWithType:(CalendarShowType)type andMonthCount:(NSInteger)monthCount;


@end

