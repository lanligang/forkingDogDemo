//
//  LgHeaderCollectionViewCell.m
//
//  Created by ios2 on 2018/9/10.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "LgHeaderCollectionViewCell.h"
#import "LgHeaderFile.h"

@implementation LgHeaderCollectionViewCell{
	UILabel *_titleLable;
	UIImageView *_logoImgView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUpUI];
	}
	return self;
}
-(void)setUpUI
{
	UIView *bgView = [UIView new];
	bgView.backgroundColor = [UIColor colorWithHexString:@"#333333"];

	UIImageView *iconImgV = [UIImageView new];
	iconImgV.backgroundColor =[UIColor whiteColor];
	iconImgV.layer.cornerRadius = px_scale(98.0f)/2.0f;
	iconImgV.layer.masksToBounds = YES;
	iconImgV.contentMode = UIViewContentModeScaleAspectFit;
	[self.contentView addSubview:iconImgV];
	_logoImgView = iconImgV;
	[iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.size.mas_equalTo(CGSizeMake(px_scale(98.0f), px_scale(98.0f)));
		make.top.mas_equalTo(0);
	}];
	
	UILabel *bottomLable = [UILabel new];
	bottomLable.text = @"LenSky";
	bottomLable.font = [UIFont systemFontOfSize:px_scale(26.0f)];
	bottomLable.textColor = [UIColor colorWithHexString:@"#ffffff"];
	bottomLable.textAlignment = NSTextAlignmentCenter;
	_titleLable  = bottomLable;
	[self.contentView addSubview:bottomLable];
	[_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(iconImgV.mas_bottom).offset(px_scale(15.0f));
		make.left.mas_equalTo(px_scale(-10));
		make.right.mas_equalTo(px_scale(10.0f));
		make.height.mas_equalTo(px_scale(35.0f));
	}];
}
-(void)setModel:(id)model
{
	_model = model;
}

@end
