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
	[_circleImgView2 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534696019570&di=e1b89fa2c004e6a27a0bf047f3dc528b&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201601%2F15%2F192720gzyeeyxeflexe747.png"]];
	[_circleImgView1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534695970934&di=d919564ab6c95d07ebf65f85a7986cd4&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3433759673%2C1054886361%26fm%3D214%26gp%3D0.jpg"]];
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
	CGFloat radius = ([UIScreen mainScreen].bounds.size.width*1.3)*(currentY)/([UIScreen mainScreen].bounds.size.height);
	if (_currentAnimation == _circleImgView1) {
		_currentAnimation.maskRaduis = radius;
		_circleImgView2.maskRaduis = [UIScreen mainScreen].bounds.size.width;
	}else{
		_currentAnimation.maskRaduis = [UIScreen mainScreen].bounds.size.width*1.3 - radius;
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

-(void)layoutSubviews
{
	[super layoutSubviews];
	[_circleImgView2 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534696019570&di=e1b89fa2c004e6a27a0bf047f3dc528b&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201601%2F15%2F192720gzyeeyxeflexe747.png"]];
	[_circleImgView1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534695970934&di=d919564ab6c95d07ebf65f85a7986cd4&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3433759673%2C1054886361%26fm%3D214%26gp%3D0.jpg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
