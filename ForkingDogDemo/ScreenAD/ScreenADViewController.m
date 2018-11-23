//
//  ScreenADViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/11/23.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "ScreenADViewController.h"
#import "UINavigationController+circleDismiss.h"

@interface ScreenADViewController ()

@end

@implementation ScreenADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
	[self.navigationController circleStartAnimation];
	[self.navigationController setNavigationBarHidden:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[self.navigationController circleAnimationDismiss];
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
