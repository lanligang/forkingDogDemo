//
//  UIFont+textFont.h
//  DanMu
//
//  Created by ios2 on 2018/5/30.
//  Copyright © 2018年 xiaolu·zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (textFont)
	//这里是我自己写的方法 用来加载不同的字体

+ (nullable UIFont *)fontWithLocalName:(NSString *)name andSize:(CGFloat)size;

@end
