//
//  LgPageView.h
//  PageControlDemo
//
//  Created by ios2 on 2018/10/25.
//  Copyright © 2018 山舟网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LgPageControlDelegate.h"

@class LgPageControlViewController;

@interface LgPageView : UIView

@property(nonatomic,weak)id <LgPageControlDelegate> delegate;

//设置的pageVc
@property(nonatomic,weak)LgPageControlViewController * pageVc;

/** 带参数 初始化
 * titleFont         字体
 * seletedColor 选中的颜色
 * normalColor  正常的颜色
 * lineColor       线条颜色
 * lineHeight    线的高度
 */
-(instancetype)initWithFrame:(CGRect)frame
				andTitleFont:(UIFont *)titleFont
			 andSeletedColor:(UIColor *)seletedColor
			  andNormalColor:(UIColor *)normalColor
				andLineColor:(UIColor *)lineColor
			   andLineHeight:(CGFloat)lineHeight;

-(void)configeUI;

//下面的分页滚动到第几页了
-(void)didScrollToPage:(NSInteger)page andIsAnimation:(BOOL)isAnimation;



@end
