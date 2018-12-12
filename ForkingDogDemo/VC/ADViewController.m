//
//  ADViewController.m
//  ForkingDogDemo
//
//  Created by mc on 2018/8/18.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "ADViewController.h"
#import "ADTableViewCell.h"
#import <Masonry.h>
#import "MJRefresh.h"
#import "CollectionViewHeader.h"
#import "DCCycleScrollView.h"
#import "UIColor+Hex.h"
#import <StoreKit/StoreKit.h>

@interface ADViewController ()
<UITableViewDelegate,
UITableViewDataSource,
LgCollectionHeaderDelegate,
DCCycleScrollViewDelegate,
SKStoreProductViewControllerDelegate>

@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableDictionary *autoHeightCache;

@property (nonatomic,strong)NSMutableDictionary *cellCacheDic;
@property (nonatomic,weak)UIViewController *weakVc;


@end

@implementation ADViewController{
	NSArray *_appIds;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//	[super viewWillAppear:animated];
//	[self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//	[self.navigationController setNavigationBarHidden:NO animated:animated];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.myTableView];

	[_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.view);
		make.bottom.mas_equalTo(0);
	}];
	_appIds = @[
				@"989673964",
				@"1382147551",
				@"629774477",
				@"1256992655",
				@"1382484132",
				@"1233116180",
				@"1262355816",
				@"1296756659",
				@"1382147551",
				@"1382147551",
				@"1382147551",
				@"553106760",
				@"1382147551"];

	_myTableView.lg_header = [CollectionViewHeader collectionHeader];
	_myTableView.lg_header.delegate = self;
	__weak typeof(self) ws = self;
	[_myTableView.lg_header setLgRegreshAction:^{
		[ws requstData];
	}];

	DCCycleScrollView *dccyScrollView = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.0f) shouldInfiniteLoop:YES imageGroups:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534696019570&di=e1b89fa2c004e6a27a0bf047f3dc528b&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201601%2F15%2F192720gzyeeyxeflexe747.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534696019570&di=e1b89fa2c004e6a27a0bf047f3dc528b&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201601%2F15%2F192720gzyeeyxeflexe747.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534696019570&di=e1b89fa2c004e6a27a0bf047f3dc528b&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201601%2F15%2F192720gzyeeyxeflexe747.png"]];
	dccyScrollView.delegate = self;
	dccyScrollView.autoScroll = YES;
	dccyScrollView.isZoom = YES;
	dccyScrollView.itemWidth = CGRectGetWidth(self.view.frame) - 80.0f;
	dccyScrollView.itemSpace = -20.0f;
	self.myTableView.tableHeaderView = dccyScrollView;
	dccyScrollView.backgroundColor  = [UIColor colorWithHexString:@"#333333"];
	/*
	//如果想要打开调用
	[_myTableView.lg_header openFirstStepTop];
	//如果想关闭 使用
	[_myTableView.lg_header endLgRefresh];
	 */
	self.view.backgroundColor = [UIColor colorWithHexString:@"#333333"];

}
-(void)requstData
{
	[_myTableView.lg_header endLgRefresh];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ADTableViewCell *cell = nil;
	cell =  [tableView dequeueReusableCellWithIdentifier:@"ADTableViewCell" forIndexPath:indexPath];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
		//如果想要预估区头和区尾同样的方法
	NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
	NSNumber * heightNum = self.autoHeightCache[key];
	if(heightNum)return heightNum.floatValue;
	return 44.0f;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
	CGFloat height =  CGRectGetHeight(cell.frame);
	self.autoHeightCache[key] = @(height);
	if ([cell isKindOfClass:[ADTableViewCell class]]) {
		[self.cellCacheDic setObject:cell forKey:[NSString stringWithFormat:@"%@",indexPath]];
	    ADTableViewCell *	adCell = (ADTableViewCell *)cell;
		[adCell configeBegainAnimation];
		[adCell configeAdImgCircle];
	}
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.cellCacheDic removeObjectForKey:[NSString stringWithFormat:@"%@",indexPath]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	 UIPanGestureRecognizer *pan =  scrollView.panGestureRecognizer;
	CGPoint p =  [pan velocityInView:scrollView];
	NSLog(@"-------------- 输出当前的Y 变化 | %f",fabs(p.y));
	for (ADTableViewCell *cell in self.cellCacheDic.allValues) {
		[cell configeAdImgCircle];
	}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *appId = _appIds[(indexPath.row%_appIds.count)];
	SKStoreProductViewController *_SKSVC = [[SKStoreProductViewController alloc] init];
	_SKSVC.delegate = self;
	//这里加转子 hud
	[self presentViewController:_SKSVC animated:NO completion:nil];
	[_SKSVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId}
					  completionBlock:^(BOOL result, NSError *error) {
						  if (result) {

						  }  else{
							  [_SKSVC dismissViewControllerAnimated:NO completion:nil];
						  }
					  }];
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
	[viewController dismissViewControllerAnimated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

	return CGFLOAT_MIN;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}
#pragma mark DCCycleScrollViewDelegate
- (void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
	//点击的代理方法
}
-(UITableView *)myTableView
{
	if (!_myTableView)
	 {
		_myTableView = [[UITableView alloc]init];
		_myTableView.delegate = self;
		_myTableView.dataSource = self;
		[_myTableView registerClass:[ADTableViewCell class] forCellReuseIdentifier:@"ADTableViewCell"];
	 }
	return _myTableView;
}
-(NSMutableDictionary *)autoHeightCache
{
	if (!_autoHeightCache)
	 {
		_autoHeightCache = [[NSMutableDictionary alloc]init];
	 }
	return _autoHeightCache;
}

-(NSMutableDictionary *)cellCacheDic
{
	if (!_cellCacheDic)
	 {
		_cellCacheDic = [[NSMutableDictionary alloc]init];
	 }
	return _cellCacheDic;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
