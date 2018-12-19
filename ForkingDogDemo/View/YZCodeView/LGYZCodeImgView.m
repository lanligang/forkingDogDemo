//
//  LGYZCodeImgView.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/19.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "LGYZCodeImgView.h"

@implementation LGYZCodeImgView {
	UIBezierPath *_centerPath;
	CAShapeLayer * _centerMaskLayer;
	CAShapeLayer * _lineLayer;
	LgYzCodeType  _type;
	CGFloat _aRadius;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_type = LgYZCodeBottom;
		_centerPath = [UIBezierPath bezierPath];
		_centerMaskLayer = [CAShapeLayer layer];
		_lineLayer = [CAShapeLayer layer];
		[self.layer addSublayer:_lineLayer];
	}
	return self;
}

-(void)configerWithType:(LgYzCodeType)type andImg:(UIImage *)image
{
	//原则上认为两者必须一致
	_type =type;
	if (image) {
		self.image = image;
	}
	[self layoutSubviews];
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	if (_type == LgYZCOdeTop) {
		CGFloat width = CGRectGetWidth(self.bounds);
		CGFloat height = CGRectGetHeight(self.bounds);
		CGFloat itemWidth = width /4.0f;
		CGFloat itemW = itemWidth /4.0f;
		CGFloat startX = width /2.0f;
		CGFloat startY = height/2.0f - itemWidth * 1/4.0f;

		CGPoint point0 = (CGPoint){startX,startY};
		[_centerPath moveToPoint:point0];
		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY + itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - 2*itemW,startY + itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX - 2*itemW,startY + 2* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY+ 2* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY+ 3* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 3* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 2* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY+ 2* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY+ 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY - 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX ,startY - 1* itemW}];
		[_centerPath closePath];
		_centerMaskLayer .path =  _centerPath.CGPath;
		_lineLayer.hidden = NO;
		self.layer.mask = _centerMaskLayer;

		_lineLayer.path = _centerPath.CGPath;
		_lineLayer.fillColor = [UIColor clearColor].CGColor;
		_lineLayer.strokeColor  = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
		_lineLayer.lineWidth = 2.5f;
	}else{
		CGFloat width = CGRectGetWidth(self.bounds);
		CGFloat height = CGRectGetHeight(self.bounds);
		CGFloat itemWidth = width /4.0f;
		CGFloat itemW = itemWidth /4.0f;
		CGFloat startX = width /2.0f;
		CGFloat startY = height/2.0f - itemWidth * 1/4.0f;

		CGPoint point0 = (CGPoint){startX,startY};
		[_centerPath moveToPoint:point0];
		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY + itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - 2*itemW,startY + itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX - 2*itemW,startY + 2* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY+ 2* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX - itemW,startY+ 3* itemW}];

		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 3* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 2* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY+ 2* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY+ 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY+ 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX + 2* itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY}];
		[_centerPath addLineToPoint:(CGPoint){startX + 1* itemW,startY - 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX ,startY - 1* itemW}];
		[_centerPath addLineToPoint:(CGPoint){startX ,0}];
		[_centerPath addLineToPoint:(CGPoint){width ,0}];
		[_centerPath addLineToPoint:(CGPoint){width ,height}];
		[_centerPath addLineToPoint:(CGPoint){0 ,height}];
		[_centerPath addLineToPoint:(CGPoint){0 ,0}];
		[_centerPath addLineToPoint:(CGPoint){startX ,0}];
		[_centerPath addLineToPoint:(CGPoint){startX ,startY}];
		[_centerPath closePath];
		_lineLayer.hidden = YES;
		_centerMaskLayer .path =  _centerPath.CGPath;
		_centerMaskLayer.backgroundColor = [UIColor redColor].CGColor;
		self.layer.mask = _centerMaskLayer;
	}
}
-(void)showLine:(BOOL)isShow
{
	_lineLayer.hidden = !isShow;
}
@end
