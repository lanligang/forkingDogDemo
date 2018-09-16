//
//  CollectionViewHeader.m

//
//  Created by ios2 on 2018/9/10.
//  Copyright © 2018年 LenSky. All rights reserved.
//



#import "LgHeaderFile.h"
#import "CollectionViewHeader.h"
#import "LgHeaderCollectionViewCell.h"

#import <AVFoundation/AVFoundation.h>

#import "UIImage+GIF.h"
#import "NSBundle+MJRefresh.h"

@implementation CollectionViewHeader{
	UIImageView *_giftImageView;
}

+(instancetype)collectionHeader
{
	
	
	CollectionViewHeader*header = [[CollectionViewHeader alloc]init];
	header.backgroundColor =[UIColor colorWithHexString:@"#333333"];
	return header;
}
-(void)initDataSource
{
	for (int i = 0; i<20; i++) {
		[self.dataSource addObject:@""];
	}
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
	[super prepare];
	//初始化数据源
	[self initDataSource];
	//添加通知
	[self addNotificationObserver];
		// 设置key
	self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
		// 设置高度
	CGFloat stateHeight = 	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
	if (NavBarHeight>64) {
		self.mj_h = px_scale(250)+stateHeight*2+40.0f;
	}else{
		self.mj_h = px_scale(250)+stateHeight+65.0f;
	}
	[self addSubview:self.myCollectionView];
	[_myCollectionView registerClass:[LgHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(-px_scale(55.0f));
		make.left.and.right.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(160.0f));
	}];
	_myCollectionView.delegate = self;
	_myCollectionView.dataSource = self;

	UIView *refreshView = [UIView new];
	refreshView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
	UIImageView *gifImgV = [UIImageView new];
	[self.refreshView addSubview:gifImgV];
	NSMutableArray * animationImgs = [NSMutableArray array];
	for (NSInteger  i = 14; i<98; i++) {
		NSString *imageName = [NSString stringWithFormat:@"animationImgs/animation%ld_@3x",(long)i];
		UIImage * animalImage = [UIImage imageWithContentsOfFile:[[NSBundle mj_refreshBundle] pathForResource:imageName ofType:@"png"]];
		[animationImgs addObject:animalImage];
	}
	gifImgV.animationImages = animationImgs;
	[gifImgV setAnimationDuration:animationImgs.count*0.03];
	[gifImgV setAnimationRepeatCount:0];
	_giftImageView = gifImgV;
	[gifImgV stopAnimating];
	[refreshView addSubview:gifImgV];
	self.refreshView = refreshView;
	[self addSubview:refreshView];
	[_giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.size.mas_equalTo(CGSizeMake(100.0f, 25.0f));
		make.bottom.mas_equalTo(-5.0);
	}];
	self.isLoadDataSource = NO;

	UILabel *topTitleLable =[UILabel new];
	topTitleLable.text = @"我是标题";
	topTitleLable.font = [UIFont systemFontOfSize:px_scale(28.0f)];
	topTitleLable.textColor = [UIColor colorWithHexString:@"#e0e0e0"];
	[self addSubview:topTitleLable];
	[topTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(_myCollectionView.mas_top).offset(-px_scale(32.0f));
		make.left.mas_equalTo(px_scale(30.0f));
		make.height.mas_equalTo(px_scale(28.0f));
	}];
}

#pragma mark 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	LgHeaderCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.delegate) {
		if ([self.delegate respondsToSelector:@selector(collectionViewDidCollectedWithData:andSender:)]) {
			[self.delegate collectionViewDidCollectedWithData:self.dataSource[indexPath.row] andSender:self];
		}
	}
}

//=================================
- (void)placeSubviews
{
	[super placeSubviews];
		// 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
	self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
	CGFloat stateHeight = 	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
	self.refreshView.frame = CGRectMake(0, 0, self.mj_w,stateHeight+40.0f);

}

#pragma mark 顶部加载数据时候调用
-(void)reloadDataMethod {
	self.isLoadDataSource = YES;
	//这里是要下拉刷新的情况
	[UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
		[_scrollView setContentInset:UIEdgeInsetsMake(self.mj_h, 0, 0, 0)];
		[_scrollView setContentOffset:CGPointMake(0, -self.mj_h) animated:NO];
	}];
	[_giftImageView startAnimating];
	if (self.lgRegreshAction) {
		self.lgRegreshAction();
	}
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
	[super scrollViewContentOffsetDidChange:change];

		// 在刷新的refreshing状态
	if (self.state == MJRefreshStateRefreshing) {
		//当不显示时不处理
		if (self.window == nil) return;
		// sectionheader停留解决
		//当前的偏移量大于原始的top ？ 成立 inset = - self.scrollView.mj_offsetY;
		//不成立 还是原始的 _scrollViewOriginalInset.top

		CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;

		insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
		self.scrollView.mj_insetT = insetT;
		self.insetTDelta = _scrollViewOriginalInset.top - insetT;
		//判断一下手势向上还是向下
	    UIPanGestureRecognizer *pan = 	_scrollView.panGestureRecognizer;
		 CGPoint vel = [pan velocityInView:_scrollView];
		if (vel.y <0) {
			//向上推
			if (self.insetTDelta>=-(self.mj_size.height -2.0f)) {
				//结束刷新
				[self endRefreshing];
				[self endLgRefresh];
			}
		}else if (vel.y>0){
			CGFloat maxTopH =-(self.mj_h - self.refreshView.mj_h+2.0f);
			if (self.insetTDelta< maxTopH) {
					if (self.isLoadDataSource==NO) {
						[self reloadDataMethod];
					}
			}
		}
		return;
	}
		// 跳转到下一个控制器时，contentInset可能会变
	_scrollViewOriginalInset = self.scrollView.contentInset;

		// 当前的contentOffset
	CGFloat offsetY = self.scrollView.mj_offsetY;
		// 头部控件刚好出现的offsetY
	CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;

		// 如果是向上滚动到看不见头部控件，直接返回
		// >= -> >
	if (offsetY > happenOffsetY) return;

		// 普通 和 即将刷新 的临界点
	CGFloat stateH = 	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
	//这里修改 能够响应第一次展开的高度
	CGFloat normal2pullingOffsetY = happenOffsetY - (self.mj_h-self.refreshView.mj_h-self.mj_h*0.6f);
	//这个计算的是可以展开百分比问题
	CGFloat pullingPercent = (happenOffsetY - offsetY) / (self.mj_h-self.refreshView.mj_h-stateH);

	if (self.scrollView.isDragging)
	 {
		// 如果正在拖拽
		self.pullingPercent = pullingPercent;
		if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
				// 转为即将刷新状态
			self.state = MJRefreshStatePulling;
		} else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
				// 转为普通状态
			self.state = MJRefreshStateIdle;
		}
	} else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
		// 开始刷新 —----在这个功能中紧紧是一个可以展开的功能
		[self beginRefreshing];
	} else if (pullingPercent < 1) {
		self.pullingPercent = pullingPercent;
	}
}

- (void)setState:(MJRefreshState)state
{
	MJRefreshCheckState

		// 根据状态做事情
	if (state == MJRefreshStateIdle) {
		if (oldState != MJRefreshStateRefreshing) return;

			// 保存刷新时间
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
		[[NSUserDefaults standardUserDefaults] synchronize];

			// 恢复inset和offset
		[UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
			self.scrollView.mj_insetT += self.insetTDelta;
				// 自动调整透明度
			if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
		} completion:^(BOOL finished) {
			self.pullingPercent = 0.0;

			if (self.endRefreshingCompletionBlock) {
				self.endRefreshingCompletionBlock();
			}
		}];
	} else if (state == MJRefreshStateRefreshing) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
				//计算top 指的是我们第一次要展开多少
				CGFloat top = self.scrollViewOriginalInset.top + (self.mj_h-self.refreshView.mj_h);
					// 增加滚动区域top
				self.scrollView.mj_insetT = top;
					// 设置滚动位置
				[self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
			} completion:^(BOOL finished) {
				[self executeRefreshingCallback];
			}];
		});
	}
}

#pragma mark - 公共方法
- (void)endRefreshing
{
	[super endRefreshing];
	dispatch_async(dispatch_get_main_queue(), ^{
		self.state = MJRefreshStateIdle;
	});
	if (_myCollectionView) {
		[UIView animateWithDuration:0.2 animations:^{
			[self.myCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
				make.bottom.mas_equalTo(-px_scale(55.0f));
			}];
			[self layoutIfNeeded];
		}];
	}
	[UIView animateWithDuration:0.1 animations:^{
		_scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
		[_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
	}];
}

-(void)playerSound
{
	//如果有音效加入 pull_dow.wav 文件
	NSString *path = [[NSBundle mainBundle ] pathForResource:@"pull_dow" ofType:@"wav"];
	if (!path) return;
	SystemSoundID soundID; 
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
		// 添加有结果的声音
	AudioServicesPlaySystemSound (soundID);
}
-(void)beginRefreshing
{
	[super beginRefreshing];
	[self playerSound];
	
	if (_myCollectionView) {
		[UIView animateWithDuration:0.2 animations:^{
			[self.myCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
				make.bottom.mas_equalTo(-px_scale(20.0f));
			}];
			[self layoutIfNeeded];
		}];
		[_myCollectionView reloadData];
	}
}

-(UICollectionView *)myCollectionView
{
	if (!_myCollectionView)
	 {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
		layout.itemSize = CGSizeMake(px_scale(110.0f), px_scale(160.0f));
		layout.minimumInteritemSpacing = px_scale(30.0f);
		layout.sectionInset = UIEdgeInsetsMake(0, px_scale(30.0f), 0, px_scale(30.0f));
		//设置横向滚动
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
		_myCollectionView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
		[_myCollectionView setShowsHorizontalScrollIndicator:NO];
		[_myCollectionView setAlwaysBounceHorizontal:YES];
	 }
	return _myCollectionView;
}

-(void)addNotificationObserver
{
//	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReciverDidChange:) name:reciver_notificationName object:nil];
}
-(NSMutableArray *)dataSource
{
	if (!_dataSource)
	 {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}

-(void)didReciverDidChange:(NSNotification *)noti
{
//	//修改数量
//	IndustrySaveModel *obj = noti.object;
//	if (obj) {
//		if (self.dataSource.count<=0) {
//			[self.dataSource addObject:obj];
//		}else{
//			NSString *string = [NSString stringWithFormat:@"itemId = '%@'",obj.itemId];
//			NSPredicate *pred = [NSPredicate predicateWithFormat:string];
//			NSArray *array =  [self.dataSource filteredArrayUsingPredicate:pred];
//			if (array&&array.count>0) {
//				[self.dataSource removeObjectsInArray:array];
//			}
//			[self.dataSource insertObject:obj atIndex:0];
//		}
//		if (self.dataSource.count>20) {
//			[self.dataSource removeObjectsInRange:NSMakeRange(19, (self.dataSource.count-19))];
//		}
//		NSMutableArray *saveDataArray = [NSMutableArray array];
//		for (IndustrySaveModel *model in self.dataSource) {
//			[saveDataArray addObject:model.ecode];
//		}
//		[[NSUserDefaults standardUserDefaults]setObject:saveDataArray forKey:@"IndustrySaveKey"];
//		[[NSUserDefaults standardUserDefaults] synchronize];
//		[_myCollectionView reloadData];
//	}
}

-(void)dealloc
{
	//[[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark 下拉刷新结束的时候
-(void)endLgRefresh
{
	[self performSelector:@selector(endRefreshAnimation) withObject:nil afterDelay:0.1];
}

-(void)endRefreshAnimation
{
	self.isLoadDataSource = NO;
	[_giftImageView stopAnimating];
	[self endRefreshing];
}
-(void)openFirstStepTop
{
	[self beginRefreshing];
}


@end
