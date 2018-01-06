//
//  UIViewController+LgMenu.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/6.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "UIViewController+LgMenu.h"
#import "LgMenuViewController.h"

@implementation UIViewController (LgMenu)

-(void)openLgMenu
{
 BOOL isCircle = YES;

 UIViewController *vc = self.parentViewController;

 while (isCircle) {
  if([vc isKindOfClass:[LgMenuViewController class]]){
   isCircle = NO;
  }else{
   vc =vc.parentViewController;
   if(vc==nil){
   isCircle = NO;
   }
  }
 }
  if([vc isKindOfClass:[LgMenuViewController class]]){
   LgMenuViewController *lgMenu = (LgMenuViewController *)vc;
   [lgMenu openLeftView];
  }
}



@end
