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

/* 缩放的比例 减少的缩放比例 必须设置 isScale 有效
 * scaleValue 默认为 0.3
 * 0.0 ~ 1.0
 */
@property (nonatomic,assign)CGFloat scaleValue;


-(instancetype)initWithLeftViewController:(UIViewController *)leftViewController andMainViewController:(UIViewController *)mainViewController;

-(void)openLeftView;

-(void)closeLeftView;

@end
