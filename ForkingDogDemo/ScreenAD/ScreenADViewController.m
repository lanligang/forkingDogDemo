//
//  ScreenADViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/11/23.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "ScreenADViewController.h"
#import "UINavigationController+circleDismiss.h"
#import "UIImageView+WebCache.h"
#import <Masonry.h>
#import "UIFont+textFont.h"
@interface ScreenADViewController ()

@end

@implementation ScreenADViewController
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController circleStartAnimation];
	UIImageView *imgView  = [UIImageView new];
	imgView.contentMode =UIViewContentModeScaleAspectFill;
	[self.view addSubview:imgView];
	self.view.backgroundColor = [UIColor whiteColor];
	NSString *urlStr[] = {@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542968378979&di=ecafd41b453b31095e8f3d4ff95892e2&imgtype=0&src=http%3A%2F%2Fpic36.photophoto.cn%2F20150701%2F0847085438428157_b.jpg",
		@"https://photo.16pic.com/00/57/76/16pic_5776795_b.jpg",
		@"https://pic.ibaotu.com/00/51/50/52N888piCbSQ.jpg-0.jpg!ww700",
	};
	NSInteger index =  arc4random()%3;
	[imgView sd_setImageWithURL:[NSURL URLWithString:urlStr[index]]];
	[imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];

	UILabel *timerLable = [UILabel new];
	timerLable.textColor = [UIColor whiteColor];
	timerLable.backgroundColor = [UIColor lightGrayColor];
	timerLable.layer.masksToBounds = YES;
	timerLable.layer.cornerRadius = 20.0f;
	timerLable.textAlignment = NSTextAlignmentCenter;
	timerLable.font = [UIFont fontWithLocalName:@"UnidreamLED.ttf" andSize:20.0f];
	timerLable.text = @"10";
	[self.view addSubview:timerLable];
	[timerLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-20.0f);
		make.top.mas_equalTo(40.0f);
		make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
	}];
	__block UILabel *timeOutLable = timerLable;
	__block NSInteger timeout = 15;
	__weak typeof(self)ws = self;
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
	dispatch_source_set_event_handler(_timer, ^{
		if(timeout<=0){
			//倒计时结束，关闭
			dispatch_source_cancel(_timer);
			dispatch_async(dispatch_get_main_queue(), ^{
				//设置界面的按钮显示 根据自己需求设置
				timeOutLable .text = @"0";
				[ws.navigationController circleAnimationDismiss];
			});
		}else{
			int seconds = timeout % 60;
			NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
			dispatch_async(dispatch_get_main_queue(), ^{
					//设置界面的按钮显示 根据自己需求设置
				timeOutLable .text = strTime;
			});
			timeout--;
		}
	});
	dispatch_resume(_timer);
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
