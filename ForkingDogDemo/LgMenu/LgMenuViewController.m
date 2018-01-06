//
//  LgMenuViewController.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/6.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LgMenuViewController.h"
#import "UIView+LgMenu.h"

@interface LgMenuViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController		*leftViewController;

@property (nonatomic, strong) UIViewController		*rightViewController;
@property (nonatomic, assign) CGPoint lastPoint;

@property (nonatomic, assign) BOOL isCanMove;
@property (nonatomic, strong) UIView  *effectView;

@end

@implementation LgMenuViewController

-(instancetype)initWithLeftViewController:(UIViewController *)leftViewController andMainViewController:(UIViewController *)mainViewController
{
    self  =  [super init];
 if (self){
   [self addChildViewController:leftViewController];
   [self addChildViewController:mainViewController];
  self.leftViewController = leftViewController;
  self.rightViewController = mainViewController;
 }
 return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 [self.view addSubview:self.leftViewController.view];
 [self.view addSubview:self.rightViewController.view];
 [_rightViewController.view addSubview:self.effectView];

 self.view.backgroundColor = [UIColor whiteColor];

 _leftViewController.view.frame = self.view.bounds;
 _rightViewController.view.frame = self.view.bounds;
 UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipView:)];
 panGesture.delegate  = self;
 [self.view addGestureRecognizer:panGesture];
 _isCanMove = NO;
 
}
-(void)swipView:(UISwipeGestureRecognizer *)panges
{
  UIWindow *window =  [[UIApplication sharedApplication].delegate window];
  CGPoint aPoint  = [panges locationInView:window];
 if(panges.state==UIGestureRecognizerStateBegan){
  _lastPoint = aPoint;
 }else if (panges.state==UIGestureRecognizerStateChanged){
  CGFloat chageX = (aPoint.x-_lastPoint.x);

  UIView *mainView =self.rightViewController.view;
  mainView.x = mainView.x+chageX;
  if(mainView.x<=0){
   mainView.x=0;
  }else if (mainView.x>=MAXOPEN_LEFT){
   mainView.x= MAXOPEN_LEFT;
  }
  [mainView bringSubviewToFront:_effectView];
  _effectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:mainView.x/MAXOPEN_LEFT*0.5];
  _lastPoint = aPoint;
 }else if (panges.state==UIGestureRecognizerStateEnded){
  UIView *mainView =self.rightViewController.view;
  if(mainView.x>=MAXOPEN_LEFT*0.35){
   [self openLeftView];
  }else{
   [self closeLeftView];
  }
 }
}
-(void)openLeftView
{
  UIView *mainView =self.rightViewController.view;
 [mainView bringSubviewToFront:_effectView];

 [UIView animateWithDuration:0.3 animations:^{
  mainView.x = MAXOPEN_LEFT;
   _effectView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.5];
 }];
 _isCanMove = YES;
 _effectView.userInteractionEnabled = YES;
}
-(void)closeLeftView
{
  UIView *mainView =self.rightViewController.view;
 [UIView animateWithDuration:0.3 animations:^{
   mainView.x = 0;
   _effectView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0];
 }];
 _isCanMove = NO;
 _effectView.userInteractionEnabled = NO;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  UIWindow *window =  [[UIApplication sharedApplication].delegate window];
  CGPoint touchPoint = [touch locationInView:window];
 NSLog(@"下面");
 if(_isCanMove){
  return YES;
 }
 if(touchPoint.x<=20.0f){
  _isCanMove = YES;
  return YES;
 }else{
  return NO;
 }
}
//多重手势识别是否开启
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
 return NO;

}
//蒙板view
-(UIView *)effectView
{
 if (_effectView==nil)
 {
 _effectView = [[UIView alloc]init];
 _effectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
 _effectView.frame = [UIScreen mainScreen].bounds;
 _effectView.userInteractionEnabled = NO;

 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
 [_effectView addGestureRecognizer:tap];

 }
 return _effectView;
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
   [self closeLeftView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
