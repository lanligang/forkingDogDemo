//
//  LgHeaderFile.h
//  ForkingDogDemo
//
//  Created by mc on 2018/9/17.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#ifndef LgHeaderFile_h
#define LgHeaderFile_h

#import <UIKit/UIKit.h>
#define px_scale(x) ((x)/2.0f) * CGRectGetWidth([UIScreen mainScreen].bounds)/375.0f

#define NavBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

#import "UIColor+Hex.h"

#import <Masonry.h>

#import "MJRefreshComponent.h"

#endif /* LgHeaderFile_h */
