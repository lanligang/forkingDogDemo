//
//  LgMenuViewController.h
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/6.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAXOPEN_LEFT 200.0f

@interface LgMenuViewController : UIViewController
//是否缩放
@property (nonatomic, assign) BOOL isScale;

-(instancetype)initWithLeftViewController:(UIViewController *)leftViewController andMainViewController:(UIViewController *)mainViewController;

-(void)openLeftView;

-(void)closeLeftView;

@end
