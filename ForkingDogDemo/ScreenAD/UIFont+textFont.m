//
//  UIFont+textFont.m
//  DanMu
//
//  Created by ios2 on 2018/5/30.
//  Copyright © 2018年 xiaolu·zhao. All rights reserved.
//

#import "UIFont+textFont.h"
#import <CoreText/CoreText.h>

@implementation UIFont (textFont)
+ (UIFont *)loadFontFromData:(NSData *)data andSize:(CGFloat)size

{
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);

	if (!provider) return nil;

	CGFontRef fontRef = CGFontCreateWithDataProvider(provider);
	CGDataProviderRelease(provider);
	if (!fontRef) return nil;
	CFErrorRef errorRef;
	//先注销该字体
	CTFontManagerUnregisterGraphicsFont(fontRef,NULL);
	//注册该字体
	BOOL suc = CTFontManagerRegisterGraphicsFont(fontRef, &errorRef);
	if (!suc)
	 {
		CFStringRef errorDescription = CFErrorCopyDescription(errorRef);
		CFRelease(errorDescription);
	 }
	CFStringRef fontName = CGFontCopyPostScriptName(fontRef);

	UIFont *font = [UIFont fontWithName:(__bridge NSString *)(fontName) size:size];

	if (fontName) CFRelease(fontName);

	CGFontRelease(fontRef);

	return font;

}

//这里是我自己写的方法 用来加载不同的字体
+ (nullable UIFont *)fontWithLocalName:(NSString *)name andSize:(CGFloat)size
{
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:nil]];

	if (data==nil) {
		return nil;
	 }
	return  [self loadFontFromData:data andSize:size];
}

@end
