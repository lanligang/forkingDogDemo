//
//  LGYZCodeImgView.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/19.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	LgYZCOdeTop  = 1,
	LgYZCodeBottom
} LgYzCodeType;

@interface LGYZCodeImgView : UIImageView

-(void)configerWithType:(LgYzCodeType)type andImg:(UIImage *)image;

-(void)showLine:(BOOL)isShow;



@end

