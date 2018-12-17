//
//  LgPageControlViewController.m
//  PageControlDemo
//
//  Created by ios2 on 2018/10/25.
//  Copyright © 2018 山舟网络. All rights reserved.
//

#import "LgPageControlViewController.h"

#import "LgPageView.h"

#import "NSObject+LgObserver.h"

#define MINX_VIEW_TAG 3000

@interface LgPageControlViewController ()<UIScrollViewDelegate>
{
	//滚动到的当前页面
	NSInteger _currentPage;
	LgPageView *_pageTitleView;
}
@property (nonatomic,strong)UIScrollView *bgScrollView;

@end

@implementation LgPageControlViewController
-(instancetype)initWithTitleView:(LgPageView *)titleView
				   andDelegateVc:(UIViewController<LgPageControlDelegate> *)delegateVc
{
	self =[super init];
	if (self) {
		//默认为 3 个 默认 清理为不清理
		self.minClearCount = 3;
		self.canClearSubVcCache = NO;

		self.lgDelegate = delegateVc;
		_pageTitleView = titleView;
		_pageTitleView.pageVc = self;
		_pageTitleView.delegate = delegateVc;
		//创建UI
		[_pageTitleView configeUI];
		[delegateVc addChildViewController:self];
		[delegateVc.view addSubview:self.view];




	}
	return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
	[self.view addSubview:self.bgScrollView];

	//添加观察者
	_pageTitleView.lgOberVer.changeObserved(_bgScrollView).addObserverKey(@"contentOffset");

	if (self.lgDelegate) {
		_currentPage = 0;
		[self loadChildVcWithIndex:0];
	}
}
#pragma mark 去加载控制器
-(void)loadChildVcWithIndex:(NSInteger)page
{
	//加载子控制器
	NSAssert(self.lgDelegate != nil, @"设置 LgPageControlViewController 代理");
	if (self.lgDelegate) {
		if ([self.lgDelegate respondsToSelector:@selector(lgPageControl:withIndex:)]) {
			NSInteger pageCount = [self.lgDelegate lgPageControl:self];
			NSInteger maxPage = pageCount - 1;
			if (page > maxPage||pageCount <= 0 )return;
		    UIViewController *vc = 	[self.lgDelegate lgPageControl:self withIndex:page];
			NSAssert([vc isKindOfClass:[UIViewController class]], @"请检查 lgPageControl:withIndex:代理方法返回类型");
			[self addChildViewController:vc];
			vc.view.tag = MINX_VIEW_TAG + page;
			vc.view.backgroundColor = [UIColor lightGrayColor];

			vc.view.frame = CGRectMake(page*CGRectGetWidth(self.bgScrollView.frame),
									   0,
									   CGRectGetWidth(self.bgScrollView.frame),
									   CGRectGetHeight(self.bgScrollView.frame));
			[self.bgScrollView addSubview:vc.view];
		}
		if (self.canClearSubVcCache) {
			if (self.childViewControllers.count > self.minClearCount) {

			__block UIViewController *vc = nil;
			   __block	NSInteger max = 1;
			[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
					NSInteger pageNum = obj.view.tag - MINX_VIEW_TAG - self->_currentPage;
				NSInteger pageAbs =  labs(pageNum);
				if (pageAbs >= max) {
					max = pageAbs;
					vc = obj;
				}
				}];
				if (vc) {
					[vc willMoveToParentViewController:nil];
					[vc.view removeFromSuperview];
					[vc removeFromParentViewController];
				}
			}
		}
	}
}
#pragma mark layout subViews
-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
   CGFloat width = 	CGRectGetWidth(self.view.frame);
   CGFloat height = 	CGRectGetHeight(self.view.frame);
	_bgScrollView.frame = CGRectMake(0, 0, width, height);
	//通过代理向外部要数据
	if (self.lgDelegate) {
		if ([self.lgDelegate respondsToSelector:@selector(lgPageControl:)]) {
			NSInteger pageCount = [self.lgDelegate lgPageControl:self];
			_bgScrollView.contentSize = CGSizeMake(pageCount*width, 0);
		}
	}
	NSArray *containtViews = 	_bgScrollView.subviews;
	if (containtViews.count>0) {
		for (int i = 0; i< containtViews.count; i++) {
			//这里修改View 的frame
			UIView *v = containtViews[i];
			NSInteger vTag = (v.tag - MINX_VIEW_TAG);
			v.frame = CGRectMake(vTag*width, 0, width, height);
		}
	}
	[self scrollTopage:_currentPage];
}

#pragma mark 移除所有的自视图
-(void)removeChildViewControllersAndView
{
	[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[obj willMoveToParentViewController:nil];
		[obj.view removeFromSuperview];
		[obj removeFromParentViewController];
	}];
}

#pragma mark ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat offSetX = scrollView.contentOffset.x;
	if ([self.lgDelegate respondsToSelector:@selector(lgPageControl:didScrollOffSet:)]) {
		[self.lgDelegate lgPageControl:self didScrollOffSet:offSetX];
	}
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	CGFloat offSetX = scrollView.contentOffset.x;
	NSInteger page = offSetX/(CGRectGetWidth(scrollView.frame) - 0.1)/1;
	_currentPage  = page;
	[_pageTitleView didScrollToPage:page andIsAnimation:YES];
	if (self.lgDelegate) {
	     UIView *subView = (UIView *)[scrollView viewWithTag:MINX_VIEW_TAG+page];
		if (!subView) {
			[self loadChildVcWithIndex:page];
		}else{
			for (UIViewController *vc in self.childViewControllers) {
				NSInteger viewPage = vc.view.tag - MINX_VIEW_TAG;
				if (viewPage == page) {
					[vc viewWillAppear:YES];
					break;
				}
			}
		}
	}
}

/**
 * 刷新界面使用
 */
-(void)reloadData
{
	[self removeChildViewControllersAndView];
	CGFloat width = 	CGRectGetWidth(self.view.frame);
	CGFloat height = 	CGRectGetHeight(self.view.frame);
	_bgScrollView.frame = CGRectMake(0, 0, width, height);
		//通过代理向外部要数据
	if (self.lgDelegate) {
		if ([self.lgDelegate respondsToSelector:@selector(lgPageControl:)]) {

			NSInteger pageCount = [self.lgDelegate lgPageControl:self];

			_bgScrollView.contentSize = CGSizeMake(pageCount*width, 0);
			if (pageCount >0) {
				[self loadChildVcWithIndex:0];
			}
		}
	}
	if (_pageTitleView) {
		[_pageTitleView configeUI];
		[_pageTitleView didScrollToPage:0 andIsAnimation:YES];
	}
	[self scrollTopage:0];
}
//滚动到某一页
-(void)scrollTopage:(NSInteger)page
{
	_currentPage = page;
	CGFloat offSetX = CGRectGetWidth(self.view.frame) * _currentPage;
	[self.bgScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}

-(void)endScroll:(NSInteger)page
{
	_currentPage = page;
	CGFloat offSetX = CGRectGetWidth(self.view.frame) * _currentPage;
	[self.bgScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
	
	if (self.lgDelegate) {
		UIView *subView = (UIView *)[self.bgScrollView viewWithTag:MINX_VIEW_TAG+page];
		if (!subView) {
			[self loadChildVcWithIndex:page];
		}else{
			for (UIViewController *vc in self.childViewControllers) {
				NSInteger viewPage = vc.view.tag - MINX_VIEW_TAG;
				if (viewPage == page) {
					[vc viewWillAppear:YES];
					break;
				}
			}
		}
	}
}

#pragma mark 向后追加内容
-(void)addPageNumber
{
	if (self.childViewControllers.count<=0) {
		[self reloadData];
		return;
	}
	CGFloat width = 	CGRectGetWidth(self.view.frame);
	if (self.lgDelegate) {
		if ([self.lgDelegate respondsToSelector:@selector(lgPageControl:)]) {
			NSInteger pageCount = [self.lgDelegate lgPageControl:self];
			_bgScrollView.contentSize = CGSizeMake(pageCount*width, 0);
		}
	}
	[self scrollTopage:_currentPage];
	[_pageTitleView configeUI];
	[_pageTitleView didScrollToPage:_currentPage andIsAnimation:NO];
}

#pragma getter
-(NSInteger)lgCurrentPage
{
	return _currentPage;
}

#pragma mark Getter
-(UIScrollView *)bgScrollView
{
	if (!_bgScrollView) {
		_bgScrollView = [[UIScrollView alloc]init];
		[_bgScrollView setBounces:YES];
		[_bgScrollView setPagingEnabled:YES];
		[_bgScrollView setShowsVerticalScrollIndicator:NO];
		[_bgScrollView setShowsHorizontalScrollIndicator:NO];
		_bgScrollView.delegate = self;
	 }
	return _bgScrollView;
}


@end
