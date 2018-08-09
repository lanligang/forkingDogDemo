//
//  TextTableViewCell.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _textCellLable.numberOfLines = 0;
    _textCellLable.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds)-10.0f;
    
}
-(void)configerWithModel:(id)model
{
    if ([model isKindOfClass:[NSString class]]) {
        _textCellLable.text = (NSString *)model;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
