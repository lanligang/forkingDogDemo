//
//  UITextField+input.m
//  HeroDesigners
//
//  Created by Macx on 2017/7/21.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "UITextField+input.h"
#import "Masonry.h"
#import "NSObject+LgObserver.h"

@implementation UITextField (input)

-(void)makeDarkKeyBoard
{
    self.keyboardAppearance = UIKeyboardAppearanceDark;
}
-(void)showInputAccessoryView
{
    if (self.inputAccessoryView==nil)
    {
        UIView *accessView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 35.0f)];
      UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = accessView.bounds;
    [accessView addSubview:effectView];

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
      [button setTitle:@"完成" forState:UIControlStateNormal];
      button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
      [accessView addSubview:button];
      UILabel *centerLable = [UILabel new];
      centerLable.text =self.placeholder;
      centerLable.textColor =[UIColor whiteColor];
      centerLable.textAlignment = NSTextAlignmentCenter;
      centerLable.font = [UIFont systemFontOfSize:13.5f];
      [accessView addSubview:centerLable];
      centerLable.tag = 1000;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      if (self.keyboardAppearance==UIKeyboardAppearanceDark)
      {
        accessView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
      }else{
          accessView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
      }

      self.inputAccessoryView = accessView;
      [centerLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(80);
          make.right.mas_equalTo(-80);
          make.centerY.mas_equalTo(0);
          make.height.mas_equalTo(20);
      }];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(-5);
          make.height.mas_equalTo(30);
          make.centerY.mas_equalTo(0);
          make.width.mas_equalTo(60);
      }];

	   __weak typeof(self)ws = self;
	   [self.lgOberVer.addObserverKey(@"placeholder") setDidChageMsg:^(id msg) {
		   if (ws.inputAccessoryView) {
			   UILabel *lable = (UILabel *)[ws.inputAccessoryView viewWithTag:1000];
			   if(lable){
				    lable.text = ws.placeholder;
			   }
			}
	   }];
    }
}

-(void)onclick:(UIButton *)btn
{
    [self resignFirstResponder];
}


@end
