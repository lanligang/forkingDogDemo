//
//  UINavigationController+circleDismiss.h
//  TeBrand
//
//  Created by mc on 2018/11/4.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (circleDismiss)<CAAnimationDelegate>

@property (nonatomic,strong)UIView *startView;

@property (nonatomic,strong)CAShapeLayer *maskLayer;

@property (nonatomic,assign)CGRect end_Frame;
//是否正在执行动画 防止连续点击
@property(nonatomic,assign)BOOL is_Amimation;

//展开的动画
-(void)circleStartAnimation;
//收回的动画
-(void)circleAnimationDismiss;

-(void)configerAlpha:(CGFloat)alpha;
-(void)configerColor:(UIColor *)color;

@end
