//
//  OpenCloseTableViewCell.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/17.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "OpenCloseTableViewCell.h"
#import <Masonry.h>
#import "OpenCloseModel.h"

@implementation OpenCloseTableViewCell {
	UIView *_bottomView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
	UIView *lasV = nil;
	CGFloat left = 10;
	CGFloat right = 10;
	CGFloat itemTBSpace = 5;
	CGFloat column = 4;
	CGFloat itemSpace = 10.0f;
	CGFloat itemWidth =  (CGRectGetWidth([UIScreen mainScreen].bounds) - left - right - (column -1) * itemSpace)/column;
	for (int i = 0; i<8; i++) {
		UIView *v = [UIView new];
		v.backgroundColor =  [UIColor redColor];
		[self.contentView addSubview:v];

		[v mas_makeConstraints:^(MASConstraintMaker *make) {
			make.size.mas_equalTo((CGSize){itemWidth,itemWidth});
			if (!lasV) {
				make.left.mas_equalTo(left);
				make.top.mas_equalTo(20.0f);
			}else{
				NSInteger aColumn = column/1;
				if (i%aColumn == 0) {
					make.left.mas_equalTo(left);
					make.top.equalTo(lasV.mas_bottom).offset(itemTBSpace);
				}else{
					make.top.equalTo(lasV.mas_top);
					make.left.equalTo(lasV.mas_right).offset(itemSpace);
				}
				if (i==7) {
					make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
				}
			}
		}];

		lasV  = v;
	}
	_bottomView = lasV;
}

-(void)configerWithModel:(id)model
{
	OpenCloseModel *aModel = model;
   CGFloat bottomHeight =	aModel.isOpen?(-100):(-10);
	[_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(self.contentView.mas_bottom).offset(bottomHeight);
	}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
