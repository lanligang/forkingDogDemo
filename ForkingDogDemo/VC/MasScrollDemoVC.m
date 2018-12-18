//
//  MasScrollDemoVC.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/18.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "MasScrollDemoVC.h"
#import <Masonry.h>
#import "UITextField+input.h"

@interface MasScrollDemoVC ()
{
	UIScrollView *_bgScrollView;
}
@end

@implementation MasScrollDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
	//针对于在ScrollView 上使用mas 约束
	_bgScrollView = [UIScrollView new];
	//不超过长度也可以滑动
	if (_isHorizontal) {
		_bgScrollView.pagingEnabled = YES;
		[_bgScrollView setBounces:NO];
	}else{
		_bgScrollView.alwaysBounceVertical = YES;
	}
	_bgScrollView.backgroundColor = [UIColor blackColor];

	[self.view addSubview:_bgScrollView];

	[self setUpUI];

}
//构建UI布局
-(void)setUpUI
{

	UIView *containtView = [UIView new];
	[_bgScrollView addSubview:containtView];
	[_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	[containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(_bgScrollView);
		if (_isHorizontal) {
			make.height.equalTo(self.view);
		}else{
			make.width.equalTo(self.view);
		}
	}];

	UIView *lastV = nil;
	UIColor *colors[6] = {
		[UIColor redColor],
		[UIColor yellowColor],
		[UIColor greenColor],
		[UIColor purpleColor],
		[UIColor orangeColor],
		[UIColor brownColor]
	};
	for (int i = 0 ; i<10; i++) {
		UIView *v = [UIView new];
		v.backgroundColor =colors[i%6];
		[containtView addSubview:v];
		UITextField *tf = [[UITextField alloc]init];
		[v addSubview:tf];
		[tf showInputAccessoryView];
		[tf mas_makeConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(40);
			make.left.mas_equalTo(20);
			make.right.mas_equalTo(-20);
			make.top.mas_equalTo(20);
		}];
		[tf makeDarkKeyBoard];
		tf.placeholder = @"请输入内容";
		tf.borderStyle = UITextBorderStyleRoundedRect;
		[v mas_makeConstraints:^(MASConstraintMaker *make) {
			if (_isHorizontal) {
				if (lastV) {
					make.left.equalTo(lastV.mas_right);
				}else{
					make.left.mas_equalTo(0);
				}
				make.bottom.top.mas_equalTo(0);
				make.width.equalTo(self.view);
			}else{
				make.left.and.right.mas_equalTo(0);
				make.height.mas_equalTo(100);
				if (lastV) {
					make.top.equalTo(lastV.mas_bottom).offset(10);
				}else{
					make.top.mas_equalTo(0);
				}
			}
		}];
		lastV = v;
	}
	[containtView mas_updateConstraints:^(MASConstraintMaker *make) {
		if (_isHorizontal) {
			make.right.equalTo(lastV.mas_right);
		}else{
			make.bottom.equalTo(lastV.mas_bottom).offset(10);
		}
	}];

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
