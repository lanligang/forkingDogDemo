//
//  ADCircleImageView.m
//  ForkingDogDemo
//
//  Created by mc on 2018/8/19.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "ADCircleImageView.h"

@implementation ADCircleImageView{
	UIView *_circleMaskView;
}
-(instancetype)init
{
	self = [super init];
	if (self) {
		_maskRaduis = 0.0f;
		_minMskRadus = 0.0f;
		_circleMaskView = [[UIView alloc]init];
		_circleMaskView.layer.cornerRadius = _maskRaduis;
		_circleMaskView.backgroundColor = [UIColor whiteColor];
		self.maskView = _circleMaskView;
	}
	return self;
}
-(void)setMaskRaduis:(CGFloat)maskRaduis
{
	_maskRaduis = maskRaduis;
	if (_maskRaduis < _minMskRadus) {
		_maskRaduis = _minMskRadus;
	}
	[self layoutSubviews];
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	self.layer.masksToBounds = YES;
	_circleMaskView.bounds =CGRectMake(0, 0, _maskRaduis*2.0f, _maskRaduis*2.0f);
	_circleMaskView.layer.cornerRadius = _maskRaduis;
	CGFloat width = 	CGRectGetWidth(self.bounds);
	CGFloat height =    CGRectGetHeight(self.bounds);
	//暂时先固定一下位置
	switch (_positionType) {
		case TOP_LEFT_CIRCLE_MASK:
			_circleMaskView.center = CGPointMake(width/5.0f, height/3.0f);
			break;
		case BOTTOM_RIGHT_CIRCLE_MASK:
			_circleMaskView.center = CGPointMake(width*4/5.0f, height*2/3.0f);
			break;
		default:
			break;
	}
}


@end
