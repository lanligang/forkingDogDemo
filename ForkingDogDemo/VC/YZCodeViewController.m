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
#import "UIColor+Hex.h"
#import "RequestBaseTool.h"
#import <YYText.h>

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

@property (nonatomic,assign)NSInteger maxPage;



@end

@implementation YZCodeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (!self.minePage) {
		self.navTitle = @"斗破苍穹";
		[self setValuesForKeysWithDictionary:@{@"minePage":@"1",@"pageMax":@"1624",@"name":@"doupo"}];
	}
	self.navigationItem.title = self.navTitle;
	_tfV = [[UITextView alloc]init];
	_tfV.font = [UIFont systemFontOfSize:20.0f];
	[self.view addSubview:_tfV];
	[_tfV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(0);
		make.left.and.right.equalTo(self.view);
		make.bottom.mas_equalTo(-30);
	}];
	_page = [self.minePage integerValue];
	_maxPage = [self.pageMax integerValue];
	
	NSString *str = [NSString stringWithFormat:@"http://www.doupobook.com/%@/%ld.html",self.name,(long)_page];
	[self requestWithUrl:str];
	_tfV.backgroundColor = [UIColor blackColor];
	_tfV.textColor = [UIColor colorWithHexString:@"ffffff"];
	SV_SHOW;
	[_tfV.lgOberVer.addObserverKey(@"attributedText") setDidChageMsg:^(id msg) {
		SV_Dismiss;
	}];

	NSString *strs[] = {@"上一章",@"下一章"};
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

}
-(void)requestWithUrl:(NSString *)url
{
	[RequestBaseTool getUrlStr:url andParms:@{} andCompletion:^(id obj) {
		if ([obj isKindOfClass:[NSString class]]) {
			[self changeTextWithHtmlStr:obj];
		}
	} Error:^(NSError *errror) {
		NSLog(@"%@",errror);
	}];
}

-(void)onClicked:(UIButton *)btn
{
	if (btn.tag == 100) {
		_page --;
	}else{
		_page ++;
	}
	if (_page< [_minePage integerValue]) {
		_page = [_minePage integerValue];
		return;
	}
	SV_SHOW;
	
	NSString *str = [NSString stringWithFormat:@"http://www.doupobook.com/%@/%ld.html",self.name,(long)_page];
	[self requestWithUrl:str];
}

- (NSString *)getZZwithString:(NSString *)string{
	NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
	string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
	return string;
}
-(void)changeTextWithHtmlStr:(NSString *)htmlStr
{
	NSString *allHtmlInfo = htmlStr;
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
		
		NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str];
		abs.yy_color = [UIColor whiteColor];
		abs.yy_lineSpacing = 15.0f;
		abs.yy_font = [UIFont systemFontOfSize:20.0f];
		_tfV.attributedText = abs;
		self.navigationItem.title = [NSString stringWithFormat:@"%@(%ld)页",self.navTitle,((long)_page - self.minePage.integerValue+1)];
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
