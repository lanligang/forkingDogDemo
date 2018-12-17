//
//  LgPageControlViewController.h
//  PageControlDemo
//
//  Created by ios2 on 2018/10/25.
//  Copyright © 2018 山舟网络. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LgPageControlDelegate.h"
#import "LgPageView.h"

@interface LgPageControlViewController : UIViewController


-(instancetype)initWithTitleView:(LgPageView *)titleView
				   andDelegateVc:(UIViewController<LgPageControlDelegate> *)delegateVc;


@property(nonatomic,weak)id <LgPageControlDelegate> lgDelegate;

//是否可以清理之前的数据
@property(nonatomic,assign)BOOL canClearSubVcCache;

//最小清理数量
@property(nonatomic,assign)NSInteger minClearCount;

//当前页面
@property(nonatomic,assign,readonly)NSInteger lgCurrentPage;

/**
 * 刷新界面使用
 */
-(void)reloadData;

//往后面追加
-(void)addPageNumber;

//滚动到某一页
-(void)scrollTopage:(NSInteger)page;

//从外侧调用加载到某个页面
-(void)endScroll:(NSInteger)page;



@end
