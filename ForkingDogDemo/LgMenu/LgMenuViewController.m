//
//  LgMenuViewController.m
//  ForkingDogDemo
//
//  Created by LenSky on 2018/1/6.
//

#import "LgMenuViewController.h"
#import "UIView+LgMenu.h"
#import "LgMenuMacro.h"

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
   _scaleValue = 0.3;
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

 _leftViewController.view.frame = [UIScreen mainScreen].bounds;
 _rightViewController.view.frame = [UIScreen mainScreen].bounds;
 _rightViewController.view.clipsToBounds = YES;
 _rightViewController.view.backgroundColor = [UIColor whiteColor];
 UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipView:)];
	//只允许单手操作避免 两个手指滑动来回蹦的问题
	panGesture.maximumNumberOfTouches = 1;
 panGesture.delegate  = self;
 [self.view addGestureRecognizer:panGesture];
	//测试系统的边缘侧滑手势

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
  CGFloat currentX = mainView.x + chageX;
  if(_isScale){
	mainView.transform = CGAffineTransformMakeScale(1.0-currentX/MAXOPEN_LEFT*_scaleValue,1.0-currentX/MAXOPEN_LEFT*_scaleValue);
  }
  if(currentX <= 0){
   currentX = 0;
  }else if (currentX >= MAXOPEN_LEFT){
   currentX = MAXOPEN_LEFT;
  }

  [mainView bringSubviewToFront:_effectView];

  _effectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:currentX /MAXOPEN_LEFT*0.5];
	 
  if(_isScale){
   mainView.transform = CGAffineTransformMakeScale(1.0-currentX/MAXOPEN_LEFT*_scaleValue,1.0-currentX /MAXOPEN_LEFT*_scaleValue);
  }
    mainView.x = currentX;

  _lastPoint = aPoint;
 }else if (panges.state==UIGestureRecognizerStateEnded||panges.state==UIGestureRecognizerStateFailed ||panges.state==UIGestureRecognizerStateCancelled){
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
 CGFloat currentX =MAXOPEN_LEFT;
 CGAffineTransform aTransform = CGAffineTransformMakeScale(1.0-currentX/MAXOPEN_LEFT*_scaleValue,1.0-currentX /MAXOPEN_LEFT*_scaleValue);

 [UIView animateWithDuration:0.3 animations:^{
  if(_isScale){
   mainView.transform = aTransform;
  }
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
  if(_isScale){
   mainView.transform = CGAffineTransformMakeScale(1.0,1.0);
  }
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
 if(_isCanMove){
  return YES;
 }
//判断控制器是否可以相应侧滑
 if([self.rightViewController isKindOfClass:[UITabBarController class]])
{
  UITabBarController *tabBarVc = (UITabBarController *)self.rightViewController;
  if(tabBarVc.selectedIndex>=1){
   return NO;
  }else{
  UIViewController *firstVc =  tabBarVc.viewControllers.firstObject;
   if([firstVc isKindOfClass:[UINavigationController class]]){
    UINavigationController *nav = (UINavigationController *)firstVc;
    if(nav.viewControllers.count>1){
     return NO;
    }
   }
 }
}else if ([self.rightViewController isKindOfClass:[UINavigationController class]]){
 UINavigationController *nav = (UINavigationController *)self.rightViewController;
  if(nav.viewControllers.count>1){
   return NO;
  }
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

#pragma mark setter
-(void)setScaleValue:(CGFloat)scaleValue
{
	_scaleValue =scaleValue;
	if (_scaleValue<=0) {
		_scaleValue = 0;
	}else if (_scaleValue >= 1){
		_scaleValue = 1;
	}
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
