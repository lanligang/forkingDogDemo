//
//  UIViewController+LgMenu.m
//  ForkingDogDemo
//
//  Created by LenSky on 2018/1/6.
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
-(void)closeLgMenu
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
  [lgMenu closeLeftView];
 }
}



@end
