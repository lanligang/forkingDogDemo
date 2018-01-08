//
//  LgTabBar.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/8.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LgTabBar.h"

@implementation LgTabBar{
    
    UIButton *_bigButton;
    
}

-(instancetype)init
{
    self = [super init];
    if(self){
        [self loadBigButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    
//    CGFloat barHeight = self.bounds.size.height;
    
    CGFloat centerY = 20.0f;
    
    _bigButton.center =(CGPoint){barWidth/2.0f,centerY};
    
    CGFloat centerBtnWidth = CGRectGetWidth(_bigButton.frame);
    
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    //自定义位置了可以
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    
}

-(void)loadBigButton
{
    _bigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _bigButton.backgroundColor = [UIColor yellowColor];
    _bigButton.layer.cornerRadius =30.0f;
    _bigButton.clipsToBounds = YES;
    [_bigButton addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bigButton];
}

-(void)clickCenterBtn:(UIButton *)button
{
    
}
//点击事件 超出部分的限制
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在 tabbar 里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为 subview 的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在 subView 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}









@end
