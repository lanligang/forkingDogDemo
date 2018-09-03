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
#import <StoreKit/StoreKit.h>


@interface ADViewController ()<UITableViewDelegate,UITableViewDataSource,SKStoreProductViewControllerDelegate>

@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableDictionary *autoHeightCache;

@property (nonatomic,strong)NSMutableDictionary *cellCacheDic;

@end

@implementation ADViewController{
	NSArray *_appIds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.myTableView];

	[_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.view);
		make.bottom.mas_equalTo(0);
	}];
	_appIds = @[@"989673964",@"1382147551",@"1382484132",@"",@"1233116180",@"1262355816",@"1296756659",@"1382147551",@"1382147551",@"1382147551",@"1382147551"];


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
	for (ADTableViewCell *cell in self.cellCacheDic.allValues) {
		[cell configeAdImgCircle];
	}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	SKStoreProductViewController *_SKSVC = [[SKStoreProductViewController alloc] init];
	_SKSVC.delegate = self;
	NSString *appId = _appIds[(indexPath.row%_appIds.count)];
	//这里加转子 hud 
	[_SKSVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId}
					  completionBlock:^(BOOL result, NSError *error) {
						  if (result) {
							  [self presentViewController:_SKSVC
												 animated:YES
											   completion:nil];
						  }
						  else{
							  NSLog(@"%@",error);
						  }
					  }];
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
#pragma mark- SKStoreProductViewControllerDelegate
-(void) productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
	[viewController dismissViewControllerAnimated:YES completion:nil];
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
