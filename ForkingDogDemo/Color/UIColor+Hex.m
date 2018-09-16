//
//  UIColor+Hex.m
//  lian
//
//  Created by Fire on 15-9-7.
//  Copyright (c) 2015年 DuoLaiDian. All rights reserved.
//

#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

//根据图片获取图片的主色调 相当的 需要从异步获取 卡主线程
+(UIColor*)mostColor:(UIImage*)image
{

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
	int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
	int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
		//第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
	CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,
												 thumbSize.width,
												 thumbSize.height,
												 8,//bits per component
												 thumbSize.width*4,
												 colorSpace,
												 bitmapInfo);

	CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
	CGContextDrawImage(context, drawRect, image.CGImage);
	CGColorSpaceRelease(colorSpace);

		//第二步 取每个点的像素值
	unsigned char* data = CGBitmapContextGetData (context);
	if (data == NULL) return nil;
	NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

	for (int x=0; x<thumbSize.width; x++) {
		for (int y=0; y<thumbSize.height; y++) {
			int offset = 4*(x*y);
			int red = data[offset];
			int green = data[offset+1];
			int blue = data[offset+2];
			int alpha =  data[offset+3];
			if (alpha>0) {//去除透明
				if (red==255&&green==255&&blue==255) {//去除白色
				}else{
					NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
					[cls addObject:clr];
				}

			}
		}
	}
	CGContextRelease(context);
		//第三步 找到出现次数最多的那个颜色
	NSEnumerator *enumerator = [cls objectEnumerator];
	NSArray *curColor = nil;
	NSArray *MaxColor=nil;
	NSUInteger MaxCount=0;
	while ( (curColor = [enumerator nextObject]) != nil )
	 {
		NSUInteger tmpCount = [cls countForObject:curColor];
		if ( tmpCount < MaxCount ) continue;
		MaxCount=tmpCount;
		MaxColor=curColor;

	 }
	return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

//读取完成的回调  不能连续调用
+(void)getColorWithImage:(UIImage *)image
		   andCompletion:(void(^)(UIColor *imageColor))completion
{
	if ([NSThread currentThread]==[NSThread mainThread]) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			UIColor *color = 	[self mostColor:image];
				// 在主线程中完成UI操作
			dispatch_async(dispatch_get_main_queue(), ^{
				if (completion) {
					completion(color);
				}
			});
		});
	}else{
		UIColor *color = 	[self mostColor:image];
			// 在主线程中完成UI操作
		dispatch_async(dispatch_get_main_queue(), ^{
			if (completion) {
				completion(color);
			}
		});
	}
}

+(void)getColorWithUrl:(NSString  *)url
		 andCompletion:(void(^)(UIColor *imageColor))completion
{
	if (url==nil||[url isKindOfClass:[NSNull class]]||url.length<=0) {
		return;
	}
	NSString *aUrl = @"";
	if (![url hasPrefix:@"http"]) {
		aUrl = [NSString stringWithFormat:@"http://%@",url];
	}else{
		aUrl = url;
	}
	
	[[UIImageView new]sd_setImageWithURL:[NSURL URLWithString:aUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
				[self getColorWithImage:image andCompletion:completion];
	}];
}



@end
