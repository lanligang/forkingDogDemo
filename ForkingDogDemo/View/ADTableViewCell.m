//
//  ADTableViewCell.m
//  ForkingDogDemo
//
//  Created by mc on 2018/8/19.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "ADTableViewCell.h"
#import "ADCircleImageView.h"
#import <Masonry.h>
#import "UIView+ViewFrameScreen.h"
#import "UIImageView+WebCache.h"

@implementation ADTableViewCell{
	ADCircleImageView *_circleImgView1;
	ADCircleImageView *_circleImgView2;
	ADCircleImageView *_currentAnimation;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
	}
	return self;
}
-(void)setUpUI
{
	_circleImgView1 = [[ADCircleImageView alloc]init];
	_circleImgView2 = [[ADCircleImageView alloc]init];
	
	[_circleImgView2 sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2631476113,1562457641&fm=173&s=E082A6B85E1272C05A3D005E0300C0F3&w=463&h=815&img.JPEG"]];
	[_circleImgView1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534691762701&di=aab4ad2e77e3223fb844fd0c3e7f7130&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0117e2571b8b246ac72538120dd8a4.jpg%401280w_1l_2o_100sh.jpg"]];
	
	_circleImgView1.positionType = TOP_LEFT_CIRCLE_MASK;
	_circleImgView2.positionType = BOTTOM_RIGHT_CIRCLE_MASK;
	[self.contentView addSubview:_circleImgView1];
	[self.contentView addSubview:_circleImgView2];
	_circleImgView2.maskRaduis = 0;
	_circleImgView1.maskRaduis = 0;
	[_circleImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(250.0f);
		make.bottom.equalTo(self.contentView.mas_bottom);
	}];
	[_circleImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(250.0f);
		make.bottom.equalTo(self.contentView.mas_bottom);
	}];
	
}

-(void)configeAdImgCircle
{
   CGRect rect = [UIView rectFromSunView:_circleImgView1];
   CGFloat currentY =  CGRectGetMaxY(rect) - CGRectGetHeight(rect)/2.0f;
	CGFloat radius = ([UIScreen mainScreen].bounds.size.width)*(currentY)/([UIScreen mainScreen].bounds.size.height-100);
	if (_currentAnimation == _circleImgView1) {
		_currentAnimation.maskRaduis = radius;
		_circleImgView2.maskRaduis = [UIScreen mainScreen].bounds.size.width;
	}else{
		_currentAnimation.maskRaduis = [UIScreen mainScreen].bounds.size.width+68 - radius;
		_circleImgView1.maskRaduis = [UIScreen mainScreen].bounds.size.width;
	}
}


-(void)configeBegainAnimation
{
	CGRect rect = [UIView rectFromSunView:_circleImgView1];
	if (rect.origin.y <= 10 ) {
		//开始出现的时候调用
		_currentAnimation = _circleImgView1;
	}else{
		_currentAnimation = _circleImgView2;
	}
	[self.contentView bringSubviewToFront:_currentAnimation];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
