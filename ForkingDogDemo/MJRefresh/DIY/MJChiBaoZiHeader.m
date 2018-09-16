//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"
#import "UIImage+GIF.h"
#import "NSBundle+MJRefresh.h"

@implementation MJChiBaoZiHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
#warning 如果要使用该动画请将所有的图片都加入进来
//  NSString *path =  [[NSBundle mj_refreshBundle]pathForResource:@"download_02" ofType:@"gif"];
//
//
//    if (NullString(path))
//    {
//        return;
//    }
//
//    NSDictionary *gifInfo =   [UIImage getGifInfo:[NSURL fileURLWithPath:path]];
//    NSArray *imageArray =gifInfo[@"images"];
    NSMutableArray *animationImgs = [NSMutableArray array];
    for (NSInteger  i = 14; i<98; i++) {
        NSString *imageName = [NSString stringWithFormat:@"animationImgs/animation%ld_@3x",(long)i];
        
        UIImage * animalImage = [UIImage imageWithContentsOfFile:[[NSBundle mj_refreshBundle] pathForResource:imageName ofType:@"png"]];
        [animationImgs addObject:animalImage];
        
//        UIImage *img = imageArray[i];
//        NSData *data =UIImagePNGRepresentation(img);
//       NSString *str =  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *apath  = [NSString stringWithFormat:@"%@/animation%ld_@3x.png",str,(long)i];
//        [data writeToFile:apath atomically:YES];
//        NSLog(@"---输出路径----------%@",apath);

    }
    
    
     [self setImages:animationImgs forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    
    [self setImages:animationImgs forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:animationImgs forState:MJRefreshStateRefreshing];
}


@end
