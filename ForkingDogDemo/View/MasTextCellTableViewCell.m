//
//  MasTextCellTableViewCell.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/4.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "MasTextCellTableViewCell.h"
#import <Masonry.h>
#import "JokeModels.h"

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

 [_containtLable mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.mas_equalTo(20);
  make.top.equalTo(_userImageView.mas_bottom).offset(2);
  make.right.mas_equalTo(-10);
  make.height.mas_equalTo(10);
  make.bottom.equalTo(self.contentView.mas_bottom).offset(-3.0f);//这个约束很关键
 }];
}

-(void)configerWithModel:(id)model;
{
 [super configerWithModel:model];
 if([model isKindOfClass:[NSString class]]){
	 _containtLable.text = model;
	 }else{
		 if (model) {
			 JokeModel *joke = (JokeModel *)model;
			 NSString *htmlStr = joke.neirong;
			 _nameTextLable.text = joke.zuozhe;

			 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
			 [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, attributedString.length)];
			 [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributedString.length)];
			 _containtLable.attributedText = attributedString;
	 }
 }
	CGFloat maxWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20*2;
	CGFloat height = 	 [_containtLable sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;
	[_containtLable mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(height);
	}];
}

-(UIImageView *)userImageView
{
 if (_userImageView==nil)
 {
    _userImageView = [[UIImageView alloc]init];
	_userImageView.layer.cornerRadius = 15.0f;
	_userImageView.layer.masksToBounds = YES;
    _userImageView.backgroundColor = [UIColor grayColor];
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
	_containtLable.textColor = [UIColor redColor];
   _containtLable.numberOfLines = 0;
 }
 return _containtLable;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
