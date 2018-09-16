//
//  CollectionViewHeader.h
//
//  Created by ios2 on 2018/9/10.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "MJRefreshComponent.h"

@protocol LgCollectionHeaderDelegate <NSObject>
@optional

-(void)collectionViewDidCollectedWithData:(id)data andSender:(id)sender;


@end


@interface CollectionViewHeader:MJRefreshComponent
<UICollectionViewDataSource,UICollectionViewDelegate>

/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

@property (assign, nonatomic) CGFloat insetTDelta;

@property (nonatomic,strong)UIView *refreshView;

// CollectionView 部分 以及数据
@property (nonatomic,strong)UICollectionView *myCollectionView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,assign)BOOL isLoadDataSource;

@property (nonatomic,copy)void(^lgRegreshAction)(void);

//代理
@property (nonatomic,weak)id<LgCollectionHeaderDelegate> delegate;

//初始化方法
+(instancetype)collectionHeader;

-(void)endLgRefresh;
//开启第一步 高度用户我们加载了这个控件
-(void)openFirstStepTop;


@end













