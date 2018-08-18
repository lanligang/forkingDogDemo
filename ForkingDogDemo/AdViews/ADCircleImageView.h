//
//  ADCircleImageView.h
//  ForkingDogDemo
//
//  Created by mc on 2018/8/19.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 * 剪切圆的位置
 */
typedef enum : NSUInteger {
	TOP_LEFT_CIRCLE_MASK,
	BOTTOM_RIGHT_CIRCLE_MASK,
} MaskPositionType;

@interface ADCircleImageView : UIImageView

//可设置
@property (nonatomic,assign)MaskPositionType positionType;

//外部可设置的圆角 默认为 0
@property (nonatomic,assign)CGFloat maskRaduis;

//最小的圆角 默认为 0
@property (nonatomic,assign)CGFloat minMskRadus;


@end
