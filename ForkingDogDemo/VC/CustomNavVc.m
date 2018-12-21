//
//  CustomNavVc.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/13.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "CustomNavVc.h"
#import "CustomNavBar.h"

@interface CustomNavVc()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation CustomNavVc

-(void)viewDidLoad
{
	[super viewDidLoad];
	CustomNavBar *navBar = [[CustomNavBar alloc]init];
	[ self setValue:navBar forKey:@"navigationBar"];
	__weak CustomNavVc *weakSelf = self;
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])  {
	self.interactivePopGestureRecognizer.delegate = weakSelf;
	self.delegate = weakSelf;
	}

}
#pragma mark UINavigationControllerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if ([self.childViewControllers count] == 1) {
		return NO;
	}
	return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end
