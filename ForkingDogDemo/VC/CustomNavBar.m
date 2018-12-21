//
//  CustomNavBar.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/13.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

-(instancetype)init
{
	self = [super init];
	if (self) {
		[self insertSubview:self.bgView atIndex:0];
		self.barStyle = UIBarStyleBlack;
		[self setShadowImage:[UIImage new]];
		[self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
		_colorStr1 = @"#FFD700";
		_colorStr2 = @"#7FFFAA";
	}
	return self;
}

-(void)setAAlpha:(CGFloat)aAlpha
{
	_aAlpha = aAlpha;
	self.bgView.alpha = aAlpha;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	CGFloat stateHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
	self.bgView.frame = (CGRect){0,-stateHeight,self.bounds.size.width,self.bounds.size.height + stateHeight};
	[self insertSubview:self.bgView atIndex:0];

	for (UIView *v  in self.subviews) {
		if ([v isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
			v.hidden = YES;
		}
		if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
			v.hidden = YES;
		}
	}
 {
	CAGradientLayer *layer =	[CustomNavBar setGradualChangingColor:self.bgView fromColor:_colorStr1 toColor:_colorStr2];
	[self.bgView.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isKindOfClass:[CAGradientLayer class]]) {
			[obj removeFromSuperlayer];
			*stop = YES;
		}
	}];
	[self.bgView.layer addSublayer:layer];
 }
}
	//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
	NSLog(@"修改j渐变了");
		//    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = view.bounds;

		//  创建渐变色数组，需要转换为CGColor颜色
	gradientLayer.colors = @[(__bridge id)[self colorWithHex:fromHexColorStr].CGColor,(__bridge id)[self colorWithHex:toHexColorStr].CGColor];

		//  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
	gradientLayer.startPoint = CGPointMake(0, 0);
	gradientLayer.endPoint = CGPointMake(1, 0);

		//  设置颜色变化点，取值范围 0.0~1.0
	gradientLayer.locations = @[@0,@1];

	return gradientLayer;
}
	//获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor {
	hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([hexColor length] < 6) {
		return nil;
	}
	if ([hexColor hasPrefix:@"#"]) {
		hexColor = [hexColor substringFromIndex:1];
	}
	NSRange range;
	range.length = 2;
	range.location = 0;
	NSString *rs = [hexColor substringWithRange:range];
	range.location = 2;
	NSString *gs = [hexColor substringWithRange:range];
	range.location = 4;
	NSString *bs = [hexColor substringWithRange:range];
	unsigned int r, g, b, a;
	[[NSScanner scannerWithString:rs] scanHexInt:&r];
	[[NSScanner scannerWithString:gs] scanHexInt:&g];
	[[NSScanner scannerWithString:bs] scanHexInt:&b];
	if ([hexColor length] == 8) {
		range.location = 4;
		NSString *as = [hexColor substringWithRange:range];
		[[NSScanner scannerWithString:as] scanHexInt:&a];
	} else {
		a = 255;
	}
	return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}

-(UIView *)bgView
{
	if (!_bgView)
 {
	_bgView = [[UIView alloc]init];
	_bgView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:1.0];
	self.barTintColor =_bgView.backgroundColor;
 }
	return _bgView;
}



@end
