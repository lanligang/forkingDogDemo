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
#import "SVHUDMacro.h"

@interface YZCodeViewController ()<UIGestureRecognizerDelegate,UIWebViewDelegate>
{
	CGPoint _lastPoint;
	UIView *_tView;
	CGPoint _startPoint;
	CGFloat _sPointX;
	UILabel * _stateLable;
	//难度等级  内部取绝对值
	CGFloat  _difficultyLevel;\
	UIWebView *_webView;
	UITextView *_tfV;
}

@property(nonatomic,assign)BOOL isSuccess;
//页码
@property(nonatomic,assign)NSInteger page;


@end

@implementation YZCodeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"斗破苍穹";
	UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectZero];
	[self.view insertSubview:webV atIndex:0];
	_tfV = [[UITextView alloc]init];
	_tfV.font = [UIFont systemFontOfSize:20.0f];
	[self.view addSubview:_tfV];
	[_tfV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(0);
		make.left.and.right.equalTo(self.view);
		make.bottom.mas_equalTo(-30);
	}];
	_page = 1;
	NSString *str = [NSString stringWithFormat:@"http://www.doupobook.com/doupo/%ld.html",(long)_page];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
	webV.delegate = self;
	_webView = webV;
	[webV loadRequest:request];

	SV_SHOW;
	[_tfV.lgOberVer.addObserverKey(@"text") setDidChageMsg:^(id msg) {
		SV_Dismiss;
	}];

	NSString *strs[] = {@"上一页",@"下一页"};
	for (int i = 0; i<2; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.view addSubview:btn];
		[btn setTitle:strs[i] forState:UIControlStateNormal];
		[btn setBackgroundColor:[UIColor blackColor]];
		btn.tag = i + 100;
		[btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
		[btn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(0);
			make.top.equalTo(_tfV.mas_bottom);
			if (i==0) {
				make.right.mas_equalTo(self.view.mas_centerX).offset(-2);
				make.left.mas_equalTo(0);
			}else{
				make.left.mas_equalTo(self.view.mas_centerX).offset(2);
				make.right.mas_equalTo(0);
			}
			make.bottom.mas_equalTo(0);
		}];
	}
	_tfV.editable = NO;
	return;
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


-(void)onClicked:(UIButton *)btn
{
	if (btn.tag == 100) {
		_page --;
	}else{
		_page ++;
	}
	if (_page<=0) {
		_page = 1;
		return;
	}
	SV_SHOW;
	NSString *str = [NSString stringWithFormat:@"http://www.doupobook.com/doupo/%ld.html",(long)_page];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
	[_webView loadRequest:request];
}

- (NSString *)getZZwithString:(NSString *)string{
	NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
	string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
	return string;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSString *htmlNum =  @"document.documentElement.innerHTML";
	NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlNum];
	NSScanner *theScanner;
	NSString *text = nil;

	theScanner = [NSScanner scannerWithString:allHtmlInfo];

	while ([theScanner isAtEnd] == NO) {
			// find start of tag
		[theScanner scanUpToString:@"<" intoString:NULL] ;
			// find end of tag
		[theScanner scanUpToString:@">" intoString:&text] ;
			// replace the found tag with a space
			//(you can filter multi-spaces out later if you wish)
		allHtmlInfo = [allHtmlInfo stringByReplacingOccurrencesOfString:
					   [NSString stringWithFormat:@"%@>", text]
															 withString:@""];
	}
	NSString *str =  [self getZZwithString:allHtmlInfo];
	NSArray *strs = [str componentsSeparatedByString:@"输入本网址访问本站，记住了吗？"];
	str = strs.lastObject;
	if (str) {
		str =[str componentsSeparatedByString:@"tuijian();"].firstObject;
		_tfV.text = str;
		self.navigationItem.title = [NSString stringWithFormat:@"斗破苍穹(%ld)页",(long)_page];
	}
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
