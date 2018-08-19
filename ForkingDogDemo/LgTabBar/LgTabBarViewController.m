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
#import "ADViewController.h"

#import "UIView+LGAnimation.h"

@interface LgTabBarViewController ()<LgTabBarDelegate,UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray  *circleViews;

@end

@implementation LgTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LgTabBar *tabBar = [[LgTabBar alloc]init];
    // 利用KVO来使用自定义的tabBar
    tabBar.actionDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
	[self addAllChildViewController];
 _circleViews = [NSMutableArray array];
	__weak typeof(self)ws = self;
	self.delegate = ws;
	self.selectedIndex = 0;
	[self checkHiddenRedCircle];
}
-(void)checkHiddenRedCircle
{
	if (_circleViews.count>0) {
		return;
	}
	for (UIView *view in self.tabBar.subviews)
	{
		if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
			UIView *circleView  = [UIView new];
			circleView.frame = CGRectMake(CGRectGetWidth(view.frame)-5, 0, 5, 5);
			circleView.backgroundColor = [UIColor redColor];
			circleView.layer.cornerRadius = 2.5f;
			circleView.clipsToBounds = YES;
			[_circleViews addObject:circleView];
			for (UIView *aview in view.subviews)  {
				if ([aview isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
					circleView.frame = CGRectMake(CGRectGetWidth(aview.frame)/2+10,  CGRectGetHeight(aview.frame)/2-11, 5, 5);
					[aview addSubview:circleView];
					circleView.hidden = YES;
				}
			}
		}
	}
}
-(void)viewWillAppear:(BOOL)animated
{
 [super viewWillAppear:animated];
 [self checkHiddenRedCircle];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	NSInteger index = 0;
	for (UIView *v  in tabBar.subviews) {
		if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
			if (item.tag==index) {
				for (UIView *aView in v.subviews) {
					if ([aView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
						if (index==0) {
							[aView aq_addRoaAnimation];
						} else{
							[aView aq_addScaleAnimation:1.2];
						}
						return;
					}
				}
			}
			index++;
		}
	}
}
#pragma mark LgTabBarDelegate
-(void)bigButtonAction
{
	UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"温馨提示" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布" otherButtonTitles:@"继续", nil];
	[action showInView:self.view];
}

-(void)addAllChildViewController
{
    ViewController *vc = [[ViewController alloc]init];
    ADViewController *vc2 = [[ADViewController alloc]init];
    UIViewController *vc3 = [[UIViewController alloc]init];
    UIViewController *vc4 = [[UIViewController alloc]init];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
   UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
 UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
  UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];

    UITabBarItem *item1 = [[UITabBarItem alloc]init];
	item1.tag = 0;
    UITabBarItem *item2 = [[UITabBarItem alloc]init];
	item2.tag = 1;
    UITabBarItem *item3 = [[UITabBarItem alloc]init];
	item3.tag = 2;
    UITabBarItem *item4 = [[UITabBarItem alloc]init];
	item4.tag = 3;
    item1.title = @"第1页";
    item2.title = @"广告";
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

	self.viewControllers = @[nav,nav2,nav3,nav4];
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
