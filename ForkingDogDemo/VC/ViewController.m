//
//  ViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "ViewController.h"
//这里 用mas  只是用来布局
#import <Masonry.h>
//单独文字
#import "TextTableViewCell.h"
//混合样式
#import "MixTableViewCell.h"
//masCell
#import "MasTextCellTableViewCell.h"
#import "LgMenuHeader.h"
#import "ADTableViewCell.h"
#import "ADViewController.h"

#import "GameViewController.h"
#import "ADScreenManager.h"
#import "LgPageControlViewController.h"
#import "UINavigationController+circleDismiss.h"

#import "ObjcMethod.h"
#import "JokeModels.h"

@interface ViewController ()<LgPageControlDelegate>{
	LgPageControlViewController *_pageVc;
	LgPageView *_pageView;
}

@property (nonatomic,strong)UITableView *myTableView;


@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *dicArray;


@end

@implementation ViewController


-(void)setTitleView
{
 UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44.0f)];

 self.navigationItem.titleView  = titleView;
 NSArray *titles =@[@"消息",@"通知"];
 for (int i = 0; i<2; i++)
 {
 UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
 [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
 [btn setTitle:titles[i] forState:UIControlStateNormal];
 [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 [titleView addSubview:btn];
 if(i==0){
  btn.selected = YES;
  UIView *lineView = [UIView new];
  lineView.backgroundColor =[UIColor lightGrayColor];
  [titleView addSubview:lineView];
  [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
   make.centerX.mas_equalTo(0);
   make.centerY.mas_equalTo(0);
   make.height.mas_equalTo(20.0f);
   make.width.mas_equalTo(1.0f);
  }];
 }
 [btn mas_makeConstraints:^(MASConstraintMaker *make) {
  if(i==0){
   make.right.mas_equalTo(titleView.mas_centerX);
  }else{
   make.left.mas_equalTo(titleView.mas_centerX);
  }
  make.width.mas_equalTo(60.0f);
  make.height.mas_equalTo(44.0f);
  make.centerY.mas_equalTo(0);
 }];
 }
 UIView *spaceView = [UIView new];
 spaceView.bounds =CGRectMake(0, 0, 44, 44);
 UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:spaceView];
 self.navigationItem.rightBarButtonItem =item;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
	[ObjcMethod getPropertyListWithClass:JokeModel.class];
	self.navigationController.navigationBar.translucent = YES;
    [self setTitleView];

	CGFloat topY =	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(self.navigationController.navigationBar.frame);
	[self.dataSource addObjectsFromArray:@[@"斗破苍穹",@"斗破苍穹之无上之境",@"斗破苍穹之重生萧炎",@"斗破苍穹2",@"斗破苍穹续集天蚕土豆",@"斗破苍穹之穿越轮回"]];
	NSArray *array = @[@{@"minePage":@"1",@"pageMax":@"1624",@"name":@"doupo"},
	  @{@"minePage":@"5361",@"pageMax":@"23450",@"name":@"wushang"},
	  @{@"minePage":@"6923",@"pageMax":@"7397",@"name":@"xiaoyan"},
	  @{@"minePage":@"6884",@"pageMax":@"6922",@"name":@"dpcq2"},
	  @{@"minePage":@"7398",@"pageMax":@"7410",@"name":@"tudou"},
	  @{@"minePage":@"7412",@"pageMax":@"8262",@"name":@"lunhui"}
	  ];
	[self.dicArray addObjectsFromArray:array];
	
	LgPageView *pageView =[[LgPageView alloc]initWithFrame:CGRectMake(0, topY, CGRectGetWidth(self.view.frame), 40.0f)
											  andTitleFont:[UIFont systemFontOfSize:18.0f]
										   andSeletedColor:[UIColor redColor]
											andNormalColor:[UIColor lightGrayColor]
											  andLineColor:[UIColor redColor]
											 andLineHeight:3.0f];
	_pageView = pageView;
	[self.view addSubview:pageView];

	LgPageControlViewController *pageVc = [[LgPageControlViewController alloc]initWithTitleView:pageView andDelegateVc:self];
	pageVc.canClearSubVcCache = NO;
	pageVc.minClearCount = 2;
	_pageVc = pageVc;
	pageVc.view.frame = CGRectMake(0,
								   CGRectGetMaxY(pageView.frame),
								   CGRectGetWidth(self.view.frame),
								   CGRectGetHeight(self.view.frame)- CGRectGetMaxY(pageView.frame));
 UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"header_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openAction:)];
 self.navigationItem.leftBarButtonItem = rightItem;
	//[ADScreenManager showScreenAmimation];
}
-(void)openAction:(id)sender
{
   [self openLgMenu];
}
#pragma mark LgPageControlDelegate

-(NSInteger)lgPageControl:(LgPageControlViewController *)pageController
{
	return self.dataSource.count;
}
-(UIViewController *)lgPageControl:(LgPageControlViewController *)pageController withIndex:(NSInteger)index
{
	UIViewController *vc = nil;
	[self vcWithIndex:index andVc:&vc];
	return vc;
}

-(void)vcWithIndex:(NSInteger)index andVc:(UIViewController **)vc
{
	*vc = ({
		id aVc =  (UIViewController *)[[NSClassFromString(@"YZCodeViewController") alloc]init];
		[aVc setValue:self.dataSource[index] forKey:@"navTitle"];
		[aVc setValuesForKeysWithDictionary:self.dicArray[index]];
		aVc;
	});
}

-(NSArray *)lgPageTitlesWithLgPageView:(LgPageView *)pageView
{
	return self.dataSource;
}

-(NSMutableArray *)dataSource
{
	if (!_dataSource)
	 {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}
-(NSMutableArray *)dicArray
{
	if (!_dicArray)
	 {
		_dicArray = [[NSMutableArray alloc]init];
	 }
	return _dicArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
