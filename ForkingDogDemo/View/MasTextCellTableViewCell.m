//
//  MasTextCellTableViewCell.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/4.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "MasTextCellTableViewCell.h"
#import <Masonry.h>

@implementation MasTextCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if(self){
	
	[self addUI];
	 [self addViewLayout];
  }
 return self;
}
-(void)addUI
{
 [self.contentView addSubview:self.userImageView];
 [self.contentView addSubview:self.nameTextLable];
 [self.contentView addSubview:self.containtLable];
}
-(void)addViewLayout
{
 [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.equalTo(self.contentView.mas_left).offset(5);
  make.top.equalTo(self.contentView.mas_top).offset(5);
  make.width.and.height.mas_equalTo(30.0f);
 }];
 [_nameTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.equalTo(_userImageView.mas_right).offset(4);
  make.centerY.equalTo(_userImageView.mas_centerY);
  make.height.mas_equalTo(10.0f);
 }];
 
 UIImageView *lastImageView;
 CGFloat imagWidth = ((CGRectGetWidth([UIScreen mainScreen].bounds)-40.0f)-2*2)/3.0f;
 
 for (int i = 0; i<3; i++) {
  UIImageView *imageiew = [[UIImageView alloc]init];
  imageiew.backgroundColor = [UIColor redColor];
  [self.contentView addSubview:imageiew];
  
  [imageiew mas_makeConstraints:^(MASConstraintMaker *make) {
	if(lastImageView){
	 	make.left.mas_equalTo(lastImageView.mas_right).offset(2.0f);
	}else{
	 	make.left.mas_equalTo(_containtLable.mas_left);
	}
	make.width.mas_equalTo(imagWidth);
	make.height.mas_equalTo(imagWidth);
	make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
  }];
	lastImageView = imageiew;
 }
 [_containtLable mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.mas_equalTo(20);
  make.top.equalTo(_userImageView.mas_bottom).offset(2);
  make.right.mas_equalTo(-10);
  make.bottom.equalTo(lastImageView.mas_top).offset(-3.0f);//这个约束很关键
 }];
}

-(void)configerWithModel:(id)model;
{
 [super configerWithModel:model];
 if([model isKindOfClass:[NSString class]]){
  _containtLable.text = (NSString *)model;
 }
}

-(UIImageView *)userImageView
{
 if (_userImageView==nil)
 {
 _userImageView = [[UIImageView alloc]init];
 _userImageView.backgroundColor = [UIColor redColor];
 }
 return _userImageView;
}
-(UILabel *)nameTextLable
{
 if (_nameTextLable==nil)
 {
 _nameTextLable = [[UILabel alloc]init];
 _nameTextLable.text  = @"我是masCell";
 }
 return _nameTextLable;
}
-(UILabel *)containtLable
{
 if (_containtLable==nil)
 {
 _containtLable = [[UILabel alloc]init];
 _containtLable.numberOfLines = 0;
 _containtLable.backgroundColor = [UIColor purpleColor];
 }
 return _containtLable;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
