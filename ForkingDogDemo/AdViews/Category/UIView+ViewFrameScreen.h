//
//  UIView+ViewFrameScreen.h
//  ForkingDogDemo
//
//  Created by mc on 2018/8/18.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFrameScreen)

//获取某个view在屏幕上的frame
+(CGRect)rectFromSunView:(UIView *)view;

@end
