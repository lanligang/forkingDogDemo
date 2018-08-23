//
//  UIScrollView+PopScrollView.m
//  TeBrand
//
//  Created by ios2 on 2018/8/23.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "UIScrollView+PopScrollView.h"

@implementation UIScrollView (PopScrollView)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	if (self.contentOffset.x <= 0) {
		if ([self.delegate isKindOfClass:NSClassFromString(@"LeftViewController")]) {
			return NO;
		}
		if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"LgMenuViewController")]) {
			return YES;
		}
	}
	return NO;
}

@end
