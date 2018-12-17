//
//  LgPageControlDelegate.h
//  PageControlDemo
//
//  Created by ios2 on 2018/10/25.
//  Copyright © 2018 山舟网络. All rights reserved.
//
#if __OBJC__
#import <UIKit/UIKit.h>
@class LgPageView;
@class LgPageControlViewController;

@protocol LgPageControlDelegate <NSObject>

@required

-(NSInteger)lgPageControl:(LgPageControlViewController *)pageController;

-(UIViewController *)lgPageControl:(LgPageControlViewController *)pageController withIndex:(NSInteger)index;

-(NSArray *)lgPageTitlesWithLgPageView:(LgPageView *)pageView;

@optional
	//已经滚动
-(void)lgPageControl:(LgPageControlViewController *)pageController didScrollOffSet:(CGFloat)offSet;
	//滚动结束时候调用
-(void)lgPageControl:(LgPageControlViewController *)pageController didEndScrollOffSet:(CGFloat)offSet andPageIndex:(NSInteger)pageIdnex;

@end
#endif

