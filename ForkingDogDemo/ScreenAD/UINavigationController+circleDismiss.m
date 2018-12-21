//
//  UINavigationController+circleDismiss.m
//  TeBrand
//
//  Created by mc on 2018/11/4.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "UINavigationController+circleDismiss.h"
#import <objc/runtime.h>
#import "CustomNavBar.h"

static char * startView_key = '\0';
static char * maskLayer_key = '\0';
static char * endRect_key = '\0';
//isAmimation
static char * isAmimation_key = '\0';
@implementation UINavigationController (circleDismiss)

//展开的动画
-(void)circleStartAnimation
{
	if (self.is_Amimation) return;
	self.is_Amimation = YES;
	[self.maskLayer  removeAnimationForKey:@"pathStartAnimation"];
	self.maskLayer.fillColor = [UIColor whiteColor].CGColor;
	UIBezierPath *startPath = 	 [UIBezierPath bezierPathWithOvalInRect:self.end_Frame];
	CGFloat width  = CGRectGetWidth(self.view.frame);
	CGFloat height = CGRectGetHeight(self.view.frame);
	CGFloat radius = 	sqrt((pow(width, 2.0f) + pow(height, 2)))/2.0f;
	
	UIBezierPath *endPath =    [UIBezierPath bezierPathWithArcCenter:self.view.center
															  radius:radius
														  startAngle:0
															endAngle:M_PI*2
														   clockwise:YES];
	self.maskLayer.path = endPath.CGPath;
	self.view.layer.mask = self.maskLayer;
	/// 圆形放大动画
	CABasicAnimation *sourceAnima = [CABasicAnimation animationWithKeyPath:@"path"];
	sourceAnima.fromValue = (__bridge id)(startPath.CGPath);
	sourceAnima.toValue   = (__bridge id)(endPath.CGPath);
	sourceAnima.duration  = 0.6;
	sourceAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	sourceAnima.delegate  = self;
	[sourceAnima setValue:@"start" forKey:@"identifier"];
	[self.maskLayer addAnimation:sourceAnima forKey:@"pathStartAnimation"];
	__weak typeof(self)ws = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		ws.is_Amimation = NO;
	});
}

//收回的动画
-(void)circleAnimationDismiss
{
	if (self.is_Amimation) return;
	self.is_Amimation = YES;
	[self.maskLayer  removeAnimationForKey:@"pathEndAnimation"];
	self.maskLayer.fillColor = [UIColor whiteColor].CGColor;
	UIBezierPath *startPath = 	 [UIBezierPath bezierPathWithOvalInRect:self.end_Frame];
	CGFloat width  = CGRectGetWidth(self.view.frame);
	CGFloat height = CGRectGetHeight(self.view.frame);
	CGFloat radius = 	sqrt((pow(width, 2.0f) + pow(height, 2)))/2.0f;

	UIBezierPath *endPath =    [UIBezierPath bezierPathWithArcCenter:self.view.center
															  radius:radius
														  startAngle:0
															endAngle:M_PI*2
														   clockwise:YES];
	self.maskLayer.path = startPath.CGPath;
	CABasicAnimation *sourceAnima = [CABasicAnimation animationWithKeyPath:@"path"];
	sourceAnima.fromValue = (__bridge id)(endPath.CGPath);
	sourceAnima.toValue   = (__bridge id)(startPath.CGPath);
	sourceAnima.duration  = 0.6;
	sourceAnima.delegate = self;
	[sourceAnima setValue:@"end" forKey:@"identifier"];
	sourceAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[self.maskLayer addAnimation:sourceAnima forKey:@"pathEndAnimation"];
	__weak typeof(self)ws = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		ws.is_Amimation = NO;
		if (ws.startView) {
			ws.startView = nil;
		}
		[ws dismissViewControllerAnimated:NO completion:nil];
	});
}
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	NSString *identifier = [anim valueForKey:@"identifier"];
	if (identifier) {
		if ([identifier isEqualToString:@"start"]) {
			[self.maskLayer removeAnimationForKey:@"pathStartAnimation"];
			self.is_Amimation = NO;
		}else if ([identifier isEqualToString:@"end"]){
			self.is_Amimation = NO;
			[self.maskLayer removeAnimationForKey:@"pathEndAnimation"];
		}
	}
}
#pragma mark 查找view 在view 中显示的位置
- (CGRect)rectFromSunView:(UIView *)view {
	//查找frame
	UIView *vcView = [self rootViewFromSubView:view];
	UIView *superView = view.superview;
	CGRect viewRect = view.frame;
	CGRect viewRectFromWindow = [superView convertRect:viewRect toView:vcView];
	return viewRectFromWindow;
}
- (UIView *)rootViewFromSubView:(UIView *)view {
	UIViewController *vc = nil;
	UIResponder *next = view.nextResponder;
	do {
		if ([next isKindOfClass:[UINavigationController class]]) {
			vc = (UIViewController *)next;
			break ;
		}
		next = next.nextResponder;
	} while (next != nil);
	if (vc == nil) {
		next = view.nextResponder;
		do {
			if ([next isKindOfClass:[UIViewController class]] || [next isKindOfClass:[UITableViewController class]]) {
				vc = (UIViewController *)next;
				break ;
			}
			next = next.nextResponder;
		} while (next != nil);
	}
	return vc.view;
}
//set get 方法
-(void)setStartView:(UIView *)startView
{
	[self willChangeValueForKey:@"startView"];
	objc_setAssociatedObject(self, &startView_key, startView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	self.end_Frame = [self rectFromSunView:startView];
	[self didChangeValueForKey:@"startView"];
}

-(UIView *)startView
{
	return  objc_getAssociatedObject(self, &startView_key);
}

-(void)setMaskLayer:(CAShapeLayer *)maskLayer
{
	[self willChangeValueForKey:@"maskLayer"];
	objc_setAssociatedObject(self, &maskLayer_key, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"maskLayer"];
}

-(CAShapeLayer *)maskLayer
{
	id obj =  objc_getAssociatedObject(self, &maskLayer_key);
	if (!obj) {
		CAShapeLayer *layer = [CAShapeLayer layer];
		self.maskLayer = layer;
		self.view.layer.mask = layer;
	}
	return objc_getAssociatedObject(self, &maskLayer_key);
}
-(void)setEnd_Frame:(CGRect)end_Frame
{
	NSValue * rectValue =  @(end_Frame);
	[self willChangeValueForKey:@"end_Frame"];
	objc_setAssociatedObject(self, &endRect_key, rectValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self willChangeValueForKey:@"end_Frame"];
}

-(void)setIs_Amimation:(BOOL)is_Amimation
{
	NSNumber *num = @(is_Amimation);
	[self willChangeValueForKey:@"is_Amimation"];
    objc_setAssociatedObject(self, &isAmimation_key, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self willChangeValueForKey:@"is_Amimation"];
}
-(BOOL)is_Amimation
{
	NSNumber *num =  objc_getAssociatedObject(self, &isAmimation_key);
	if (num) {
		return num.boolValue;
	}
	return NO;
}

-(CGRect)end_Frame
{
	NSValue *value =  objc_getAssociatedObject(self, &endRect_key);
	if (value) {
		return value.CGRectValue;
	}

	return CGRectMake(CGRectGetWidth(self.view.bounds)/2.0f, CGRectGetHeight(self.view.bounds)/2.0f, 50, 50);
}
-(void)configerAlpha:(CGFloat)alpha
{
	if ([self.navigationBar isKindOfClass:[CustomNavBar class]]) {
		CustomNavBar *bar = (CustomNavBar *)self.navigationBar;
		bar.aAlpha = alpha;
	}
}
-(void)configerColor:(UIColor *)color
{
	if ([self.navigationBar isKindOfClass:[CustomNavBar class]]) {
		CustomNavBar *bar = (CustomNavBar *)self.navigationBar;
		bar.barTintColor = color;
		[UIView animateWithDuration:0.1 animations:^{
			bar.bgView.backgroundColor = color;
		}];
	}
}

@end
