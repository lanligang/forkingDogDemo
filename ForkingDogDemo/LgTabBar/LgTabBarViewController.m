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

@interface LgTabBarViewController ()<LgTabBarDelegate>

@end

@implementation LgTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LgTabBar *tabBar = [[LgTabBar alloc]init];
    // 利用KVO来使用自定义的tabBar
    tabBar.actionDelegate = self;
    [self addAllChildViewController];
    [self setValue:tabBar forKey:@"tabBar"];
}
#pragma mark LgTabBarDelegate
-(void)bigButtonAction
{
// PopAnimationViewVc *popVc = [PopAnimationViewVc showWithDataArray:@[] andViewController:self];
}

-(void)addAllChildViewController
{
    ViewController *vc = [[ViewController alloc]init];
    UIViewController *vc2 = [[UIViewController alloc]init];
    UIViewController *vc3 = [[UIViewController alloc]init];
    UIViewController *vc4 = [[UIViewController alloc]init];


    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
   UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];

 UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
  UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];



    UITabBarItem *item1 = [[UITabBarItem alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]init];
    UITabBarItem *item3 = [[UITabBarItem alloc]init];
    UITabBarItem *item4 = [[UITabBarItem alloc]init];
    item1.title = @"第1页";
    item2.title = @"第2页";
    item3.title = @"第3页";
    item4.title = @"第4页";

    [item1 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
    [item3 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
    [item4 setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor greenColor]} forState:UIControlStateSelected];
 
    [item1 setSelectedImage:[[UIImage imageNamed:@"tab_list_find_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setImage:[[UIImage imageNamed:@"tab_list_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    
    
    [item2 setSelectedImage:[[UIImage imageNamed:@"tab_poster_friend_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setImage:[[UIImage imageNamed:@"tab_poster_friend_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];

 [item3 setSelectedImage:[[UIImage imageNamed:@"tab_list_find_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 [item3 setImage:[[UIImage imageNamed:@"tab_list_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];

 [item4 setSelectedImage:[[UIImage imageNamed:@"tab_list_find_p"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 [item4 setImage:[[UIImage imageNamed:@"tab_list_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];


    nav2.tabBarItem = item2;
    nav.tabBarItem = item1;
    nav3.tabBarItem = item3;
    nav4.tabBarItem = item4;
 [self addChildViewController:nav];
 [self addChildViewController:nav2];
 [self addChildViewController:nav3];
 [self addChildViewController:nav4];
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
