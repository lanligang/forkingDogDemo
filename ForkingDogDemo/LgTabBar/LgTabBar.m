//
//  LgTabBar.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/8.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LgTabBar.h"

@implementation LgTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
		[self.layer addSublayer:self.circleLayer];
		self.circleLayer.path = self.cirCleBezierPath.CGPath;

        [self loadBigButton];
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new]];
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
    
    CGFloat centerY = 15;
    
    _bigButton.center =(CGPoint){barWidth/2.0f,centerY};
    
    CGFloat centerBtnWidth = CGRectGetWidth(_bigButton.frame)+10.0f;
    
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
 [self bringSubviewToFront:_bigButton];

		//白色圆弧的间距
	CGFloat whiteSpace = 3.8;
	CGFloat radius =50/2.0f+whiteSpace;
		//计算高度
	CGPoint buttonCenterPoint = _bigButton.center;

	CGFloat barHeight = CGRectGetHeight(self.bounds);

	CGFloat h1 = _bigButton.center.y;

	CGFloat r   = radius;

		//具体公式为下面
	CGFloat space = sqrt(1-pow((h1/r),2))*r;

	CGPoint begainPoint0 = (CGPoint){0,0};

	CGPoint begainPoint = (CGPoint){buttonCenterPoint.x-space,0};

	CGPoint begainPoint2 = (CGPoint){buttonCenterPoint.x+space,0};

	CGPoint point3 = (CGPoint){barWidth,0};

	CGPoint point4 = (CGPoint){barWidth,barHeight};
	CGPoint point5 = (CGPoint){0,barHeight};

	[self.cirCleBezierPath removeAllPoints];
	[_cirCleBezierPath moveToPoint:begainPoint0];

	[_cirCleBezierPath addLineToPoint:begainPoint];
	CGFloat startAngle =M_PI+asin(h1/r);
	CGFloat endAngle = M_PI*2-asin(h1/r);
	[_cirCleBezierPath addArcWithCenter:buttonCenterPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
	[_cirCleBezierPath addLineToPoint:begainPoint2];
	[_cirCleBezierPath addLineToPoint:point3];
	[_cirCleBezierPath addLineToPoint:point4];
	[_cirCleBezierPath addLineToPoint:point5];
	self.circleLayer.path = _cirCleBezierPath.CGPath;
	_circleLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f].CGColor;
	_circleLayer.shadowColor = [UIColor lightGrayColor].CGColor;
	_circleLayer.shadowOffset = CGSizeMake(0, -2);
	_circleLayer.shadowOpacity = 0.3;

}

-(void)loadBigButton
{
      _bigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45.0f, 45)];
      [_bigButton setImage:[UIImage imageNamed:@"add_button"] forState:UIControlStateNormal];
       _bigButton.clipsToBounds = YES;
     [_bigButton addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bigButton];
}

-(void)clickCenterBtn:(UIButton *)button
{
  if([self.actionDelegate respondsToSelector:@selector(bigButtonAction)]){
    [self.actionDelegate bigButtonAction];
  }
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

-(UIBezierPath *)cirCleBezierPath
{
	if (!_cirCleBezierPath)
	 {
		_cirCleBezierPath = [UIBezierPath bezierPath];
	 }
	return _cirCleBezierPath;
}

-(CAShapeLayer *)circleLayer
{
	if (!_circleLayer)
	 {
		_circleLayer = [CAShapeLayer layer];
	 }
	return _circleLayer;
}
@end
