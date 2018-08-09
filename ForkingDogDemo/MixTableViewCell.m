//
//  MixTableViewCell.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "MixTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MixTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _mixLable.numberOfLines = 0;
    _mixLable.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds)-(15+10);
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2631476113,1562457641&fm=173&s=E082A6B85E1272C05A3D005E0300C0F3&w=463&h=815&img.JPEG"]];
     [_imgView2 sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2631476113,1562457641&fm=173&s=E082A6B85E1272C05A3D005E0300C0F3&w=463&h=815&img.JPEG"]];
     [_imgView3 sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2631476113,1562457641&fm=173&s=E082A6B85E1272C05A3D005E0300C0F3&w=463&h=815&img.JPEG"]];
}
-(void)configerWithModel:(id)model
{
    if ([model isKindOfClass:[NSString class]]) {
        _mixLable.text = (NSString *)model;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
