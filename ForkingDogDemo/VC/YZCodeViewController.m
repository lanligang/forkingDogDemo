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
}
-(void)gestureDidChange:(UIPanGestureRecognizer *)pan
{
	CGPoint p = [pan locationInView:self.view];
	if (pan.state == UIGestureRecognizerStateBegan) {
		_lastPoint = p;
		_stateLable.text = @"从左向右滑动屏幕";
	}else if (pan.state == UIGestureRecognizerStateChanged){
			_tView .center = CGPointMake(p.x, _tView.center.y);
		LGYZCodeImgView *rectV = (LGYZCodeImgView *)_tView;
		[rectV showLine:YES];
	}else if (pan.state == UIGestureRecognizerStateEnded){
			if (fabs(_tView .center.x -_sPointX)<= fabs(_difficultyLevel)) {
				[UIView animateWithDuration:0.2 animations:^{
					_tView .center = CGPointMake(_sPointX, _tView.center.y);
				}];
				LGYZCodeImgView *rectV = (LGYZCodeImgView *)_tView;
				[rectV showLine:NO];
				_stateLable.text = @"真棒👍！！！";
				[self yzCode];
			}else{
				[UIView animateWithDuration:0.2 animations:^{
					_tView.center = _startPoint;
				}];
				_stateLable.text = @"请重新滑动";
			}
	}
}

-(void)yzCode
{
	NSString *file = [[NSBundle mainBundle]pathForResource:@"app_action" ofType:@"png"];
	if (file) {
		NSString *md5Code = file.fileMD5Hash;
		//8c6ddda41bc76e5f2a86add169a623ca
		//dc30284dce1be0d4116857d61ae0446b
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
