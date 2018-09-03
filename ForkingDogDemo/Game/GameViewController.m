//
//  GameViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/9/3.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "GameViewController.h"
#import "MyScene.h"
#import "UIView+LgMenu.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)loadView
{
	SKView *view = [[SKView alloc]init];
	view.frame =[UIScreen mainScreen].bounds;
	self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	SKView *view = (SKView *)self.view;
	MyScene * scene = [MyScene sceneWithSize:CGSizeMake(view.width, view.height)];
	//设置缩放填充方式
	//缩放SKScene以填充SKView，同时保留场景的高宽比。如果视图具有不同的高宽比，可能会出现一些裁剪
	scene.scaleMode = SKSceneScaleModeAspectFill;
	// Present the scene.   
	[view presentScene:scene];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
