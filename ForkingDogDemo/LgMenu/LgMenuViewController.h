//
//  LgMenuViewController.h
//  ForkingDogDemo
//
//  Created by LenSky on 2018/1/6.
//

#import <UIKit/UIKit.h>

@interface LgMenuViewController : UIViewController
//是否缩放
@property (nonatomic, assign) BOOL isScale;

-(instancetype)initWithLeftViewController:(UIViewController *)leftViewController andMainViewController:(UIViewController *)mainViewController;

-(void)openLeftView;

-(void)closeLeftView;

@end
