//
//  UIView+ViewFrameScreen.m
//  ForkingDogDemo
//
//  Created by mc on 2018/8/18.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "UIView+ViewFrameScreen.h"

@implementation UIView (ViewFrameScreen)
+(CGRect)rectFromSunView:(UIView *)view
{
	//查找frame
	UIView *vcView = [self rootViewFromSubView:view];
	UIView *superView = view.superview;
	CGRect viewRect = view.frame;
	CGRect viewRectFromWindow = [superView convertRect:viewRect toView:vcView];
	return viewRectFromWindow;
}
+ (UIView *)rootViewFromSubView:(UIView *)view
{
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
@end
