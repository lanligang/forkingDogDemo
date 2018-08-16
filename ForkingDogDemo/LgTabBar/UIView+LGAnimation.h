//
//  UIView+LGAnimation.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/8/16.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGAnimation)
-(void)aq_addRoaAnimation;
- (void)aq_addShakeAnimation;
- (void)aq_addShakeAnimation:(NSInteger)repeatCount andAngle:(CGFloat)angle;
-(void)aq_addScaleAnimation:(CGFloat)scale;
-(void)aq_addRotationAnimation:(NSInteger)repeatCount andBegainAngle:(CGFloat)begainAngle andEndAngel:(CGFloat)endAngel;
@end
