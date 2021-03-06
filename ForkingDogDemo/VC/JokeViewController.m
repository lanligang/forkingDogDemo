//
//  JokeViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/18.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "JokeViewController.h"
#import "RequestBaseTool.h"
#import "JokeModels.h"
#import <Masonry.h>
#import "BaseTableViewCell.h"
#import "PopCalendarView.h"

@interface JokeViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,assign)NSInteger startIndex;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableDictionary *autoHeightCache;
@property (nonatomic,strong)UITableView *myTableView;
@property(nonatomic,assign)NSInteger page;

@end

@implementation JokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addSubview:self.myTableView];
	[_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	if (@available(iOS 11.0, *)) {
		_myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	}else{
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	NSInteger maxIndex = (self.maxPage == nil ||[self.maxPage isKindOfClass:[NSNull class]]||[self.maxPage isEqualToString:@""])?2: [self.maxPage integerValue];
	NSLog(@"输出总页数| %@",self.maxPage);
	__weak typeof(self)ws  = self;
	_myTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
		ws.startIndex =1+ arc4random() % maxIndex;
		ws.page = ws.startIndex;
		[ws requestDatasource];
	}];
	_myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

	[_myTableView.mj_header beginRefreshing];


}

-(void)loadMoreData
{
	self.page ++;
	[self requestDatasource];
}
-(void)setJokeId:(NSString *)jokeId
{
	_jokeId = jokeId;
}
-(void)requestDatasource
{
	NSInteger intRandom = self.page;
	NSString *url = [NSString stringWithFormat:@"http://khd.funnypicsbox.com/jokes/%@_%@.json",self.jokeId,@(intRandom)];
	[RequestBaseTool postUrlStr:url
					  andParms:@{}
				 andCompletion:^(id obj) {
					 [self.myTableView.mj_header endRefreshing];
					 [self.myTableView.mj_footer endRefreshing];
					 if (obj && [obj isKindOfClass:[NSArray class]]) {
						 JokeModels *models = [[JokeModels alloc]initWithDictionary:@{@"jsokes":obj}];
						 if (self.page == self.startIndex) {
							  [self.dataSource removeAllObjects];
						 }
						 [self.dataSource addObjectsFromArray:models.jsokes];
						 [self.myTableView reloadData];
					 }
	} Error:^(NSError *errror) {
		 [self.myTableView.mj_header endRefreshing];
		 [self.myTableView.mj_footer endRefreshing];
	}];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = @"MasTextCellTableViewCell";
	BaseTableViewCell *cell = nil;
	cell =  [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
	JokeModel *model = self.dataSource[indexPath.row];
	cell.model = model;
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		[PopCalendarView showWithType:CalendarMiddleType andMonthCount:1000];
		return;
	}
	UIViewController *vc = [[NSClassFromString(@"MasScrollDemoVC") alloc]init];
	if ((indexPath.row %2) == 0) {
		[vc setValue:@(1) forKey:@"isHorizontal"];
	}
	vc.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
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
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}

-(NSMutableArray *)dataSource
{
	if (!_dataSource)
	 {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}

-(NSMutableDictionary *)autoHeightCache
{
	if (!_autoHeightCache)
	 {
		_autoHeightCache = [[NSMutableDictionary alloc]init];
	 }
	return _autoHeightCache;
}

-(UITableView *)myTableView
{
	if (!_myTableView)
	 {
		_myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		 [_myTableView registerClass:NSClassFromString(@"MasTextCellTableViewCell") forCellReuseIdentifier:@"MasTextCellTableViewCell"];
		_myTableView.delegate = self;
		_myTableView.dataSource = self;
	 }
	return _myTableView;
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
