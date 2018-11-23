//
//  ADScreenManager.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/11/23.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "ADScreenManager.h"
#import "ScreenADViewController.h"

@implementation ADScreenManager
+(void)showScreenAmimation
{
       UIWindow *window =  	[[UIApplication sharedApplication].delegate window];
	UIViewController *presentVc = window.rootViewController.presentedViewController;
	if (window.rootViewController) {
		while (presentVc) {
			presentVc = window.rootViewController.presentedViewController;
		}
	}
	if (presentVc) {
		ScreenADViewController *adVc = [[ScreenADViewController alloc]init];
		UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:adVc];
		nav.modalPresentationStyle = UIModalPresentationCustom;
		[presentVc presentViewController:nav animated:NO completion:nil];
	}else{
		ScreenADViewController *adVc = [[ScreenADViewController alloc]init];
		UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:adVc];
		nav.modalPresentationStyle = UIModalPresentationCustom;
		[window.rootViewController presentViewController:nav animated:NO completion:nil];
	}
}
@end
