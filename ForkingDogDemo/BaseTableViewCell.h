//
//  BaseTableViewCell.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

//我们就先用 字符串设置了
@property (nonatomic,strong)id model;

//子类继承父类进行传值 设置参数
-(void)configerWithModel:(id)model;

@end
