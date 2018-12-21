//
//  YZCodeViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/19.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "YZCodeViewController.h"
#import "LGYZCodeImgView.h"
#import <Masonry.h>
#import "NSString+Hash.h"
#import "NSObject+LgObserver.h"

@interface YZCodeViewController ()<UIGestureRecognizerDelegate>
{
	CGPoint _lastPoint;
	UIView *_tView;
	CGPoint _startPoint;
	CGFloat _sPointX;
	UILabel * _stateLable;
	//难度等级  内部取绝对值
	CGFloat  _difficultyLevel;

}

@property(nonatomic,assign)BOOL isSuccess;

@end

@implementation YZCodeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_stateLable = [UILabel new];
	_stateLable.textColor = [UIColor redColor];
	[self.view addSubview:_stateLable];
	_stateLable.textAlignment = NSTextAlignmentCenter;
	_stateLable.text = @"从左向右滑动屏幕";
	[_stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.height.mas_equalTo(35.0f);
		make.top.mas_equalTo(40.0f);
	}];

	_difficultyLevel = 4.0f;

	LGYZCodeImgView *topCodeV = [[LGYZCodeImgView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
	[self.view addSubview:topCodeV];
	topCodeV.center = self.view.center;
	[topCodeV configerWithType:LgYZCodeBottom andImg:[UIImage imageNamed:@"aaaa"]];

	LGYZCodeImgView *bCodeV = [[LGYZCodeImgView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
	[self.view addSubview:bCodeV];
	bCodeV.center = CGPointMake(self.view.center.x - 100 - 100*0.5, self.view.center.y);
	[bCodeV configerWithType:LgYZCOdeTop andImg:[UIImage imageNamed:@"aaaa"]];
	_tView = bCodeV;
	_startPoint = _tView.center;
	_sPointX = topCodeV.center.x;
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
	[pan addTarget:self action:@selector(gestureDidChange:)];
	[self.view addGestureRecognizer:pan];
	self.view.backgroundColor = [UIColor yellowColor];

	[self.view.lgOberVer
	 .addObserverKey(@"bounds")
	 .addObserverKey(@"backgroundColor")
	 .addObserverKey(@"frame")
	 .addObserverKey(@"transform")
	 setDidChageMsg:^(id msg) {

		NSLog(@"输出 监听 结果|%@",msg);
	}];

	[self.lgOberVer.addObserverKey(@"isSuccess") setDidChageMsg:^(id msg) {
		NSLog(@"输出是否成功的信息|%@",msg);
	}];


}
-(void)gestureDidChange:(UIPanGestureRecognizer *)pan
{
	UIWindow *window = [[UIApplication sharedApplication].delegate window];
	CGPoint p = [pan locationInView:window];
	CGPoint vP = [pan velocityInView:window];
	if (pan.state == UIGestureRecognizerStateBegan) {
		_lastPoint = p;
		_stateLable.text = @"从左向右滑动屏幕";
	}else if (pan.state == UIGestureRecognizerStateChanged){

		if (fabs(vP.y)>fabs(vP.x)) {
			//纵向滑动
			if (fabs(_lastPoint.y - p.y)>0.1) {
				self.view.bounds = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + (_lastPoint.y - p.y), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
				_lastPoint = p;
			}
		}else{
			//横向滑动
			_tView .center = CGPointMake(p.x, _tView.center.y);
			LGYZCodeImgView *rectV = (LGYZCodeImgView *)_tView;
			[rectV showLine:YES];
		}
	}else if (pan.state == UIGestureRecognizerStateEnded){
			if (fabs(_tView .center.x -_sPointX)<= fabs(_difficultyLevel)) {
				[UIView animateWithDuration:0.2 animations:^{
					_tView .center = CGPointMake(_sPointX, _tView.center.y);
				}];
				LGYZCodeImgView *rectV = (LGYZCodeImgView *)_tView;
				[rectV showLine:NO];
				self.isSuccess = YES;
				[self yzCode];
			}else{
				[UIView animateWithDuration:0.2 animations:^{
					_tView.center = _startPoint;
				}];
				self.isSuccess = NO;
			}
			if (fabs(vP.y)>fabs(vP.x)) {
				[UIView animateWithDuration:atan(fabs(vP.y))*0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
					self.view.bounds = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + - vP.y*0.3f, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
				} completion:^(BOOL finished) {
				}];
			}
	}
}

-(void)yzCode
{
	NSString *file = [[NSBundle mainBundle]pathForResource:@"app_action" ofType:@"png"];
	if (file) {
		NSString *md5Code = file.fileMD5Hash;
		NSLog(@"Release的|%@",md5Code);
	}
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
