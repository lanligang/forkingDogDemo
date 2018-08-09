//
//  LgTabBar.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/8.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LgTabBarDelegate<NSObject>
@optional

-(void)bigButtonAction;

@end
@interface LgTabBar : UITabBar

@property (nonatomic, strong) UIButton  *bigButton;

@property (nonatomic, weak) id <LgTabBarDelegate>actionDelegate;


@end


