//
//  LgTabBarViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/8.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LgTabBarViewController.h"
#import "LgTabBar.h"
#import "ViewController.h"

@interface LgTabBarViewController ()

@end

@implementation LgTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addAllChildViewController];
    
    LgTabBar *tabBar = [[LgTabBar alloc]init];
    // 利用KVO来使用自定义的tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    
}
-(void)addAllChildViewController
{
    ViewController *vc = [[ViewController alloc]init];
    ViewController *vc2 = [[ViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    UITabBarItem *item1 = [[UITabBarItem alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]init];
    item1.title = @"首页";
    item1.tag = 0;
    [item1 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
    
    [item1 setSelectedImage:[[UIImage imageNamed:@"tab_list_find_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setImage:[[UIImage imageNamed:@"tab_list_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    
    
    [item2 setSelectedImage:[[UIImage imageNamed:@"tab_poster_friend_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setImage:[[UIImage imageNamed:@"tab_poster_friend_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    
    item2.title = @"第二页";
    item2.tag = 1;
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    nav2.tabBarItem = item2;
    nav.tabBarItem = item1;
    self.viewControllers = @[nav,nav2];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
