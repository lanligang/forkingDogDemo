//
//  AppDelegate.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "AppDelegate.h"
#import "LgMenuViewController.h"
#import "LeftViewController.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    if (@available(iOS 11.0,*)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
    }
    if (@available(iOS 8.0,*)) {
        //设置导航的透明度为NO
        [UINavigationBar appearance].translucent = NO;
     [UITabBar appearance].translucent = NO;
    }

 self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
 self.window.backgroundColor =[UIColor whiteColor];
 
  [self.window makeKeyAndVisible];

 LeftViewController *leftVc = [[LeftViewController alloc]init];

 ViewController *vc = [[ViewController alloc]init];
 ViewController *vc2 = [[ViewController alloc]init];

 UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];


 UITabBarItem *item1 = [[UITabBarItem alloc]init];
 UITabBarItem *item2 = [[UITabBarItem alloc]init];
 item1.title = @"首页";
 [item1 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
 [item2 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];

 [item1 setSelectedImage:[[UIImage imageNamed:@"tab_list_find_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 [item1 setImage:[[UIImage imageNamed:@"tab_list_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];


 [item2 setSelectedImage:[[UIImage imageNamed:@"tab_poster_friend_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 [item2 setImage:[[UIImage imageNamed:@"tab_poster_friend_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];

 item2.title = @"第二页";

 UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];


 nav2.tabBarItem = item2;
 nav.tabBarItem = item1;

 UITabBarController *tabarVc = [[UITabBarController alloc]init];

 tabarVc.viewControllers = @[nav,nav2];

 LgMenuViewController *menuVc = [[LgMenuViewController alloc]initWithLeftViewController:leftVc andMainViewController:tabarVc];
 menuVc.isScale = YES;
 self.window.rootViewController = menuVc;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
