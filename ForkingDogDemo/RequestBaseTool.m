//
//  RequestBaseTool.m
//  Reader
//
//  Created by ios2 on 2017/12/8.
//  Copyright © 2017年 石家庄光耀. All rights reserved.
//

#import "RequestBaseTool.h"
#import "AFNetworkActivityIndicatorManager.h"

//设置请求超时时长
#define requestTimeoutInterval 20.0f

#define ISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )


@implementation RequestBaseTool

+(instancetype)shareInstance
{
    static RequestBaseTool *anManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        anManager = [[RequestBaseTool alloc]init];
    });
    
    return anManager;
}

+(NSURLSessionDataTask *)ecodePostUrlStr:(NSString *)urlstr
                                andParms:(id)parms
                            andParamData:(NSString*)paramData
                           andCompletion:(void(^)(id obj))completion
                                   Error:(void(^)(NSError *errror))anerror
{
    
    NSMutableDictionary *dic = [parms mutableCopy];
      NSString *ss = [[[paramData stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@";" withString:@"；" ] stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    // 加密参数
	NSString * paramData_encode = ss;
    
    NSString *sendString = [NSString stringWithFormat:@"%@",paramData_encode];
    
     [dic setValue:sendString forKey:@"paramData"];
    
    return  [[RequestBaseTool shareInstance] __request:@"POST"
                                                urlstr:urlstr
                                           requestData:dic
                                            andIsEcode:YES
                                                compod:^(id responseObject,
                                                         NSError *aerrror) {
                                                    if (responseObject)
                                                    {
                                                        completion(responseObject);
                                                    }else{
                                                        anerror(aerrror);
                                                    }
                                                }];
    
}

+(NSURLSessionDataTask *)getUrlStr:(NSString *)urlstr
                          andParms:(NSDictionary *)parms
                     andCompletion:(void(^)(id obj))completion
                             Error:(void(^)(NSError *errror))anerror
{
    return  [[RequestBaseTool shareInstance] __request:@"GET"
                                                urlstr:urlstr
                                           requestData:parms
                                              andIsEcode:NO
                                                compod:^(id responseObject, NSError *aerrror) {
        if (responseObject)
        {
            completion(responseObject);
        }else{
            anerror(aerrror);
        }
    }];
}
+(NSURLSessionDataTask *)postUrlStr:(NSString *)urlstr
                           andParms:(id)parms
                      andCompletion:(void(^)(id obj))completion
                              Error:(void(^)(NSError *errror))anerror
{
    id parmars = parms;
    if ([parms isKindOfClass:[NSDictionary class]])
    {
        if (!parms) {
            parms = [NSDictionary dictionary];
        }
        parmars = [[NSMutableDictionary alloc]initWithDictionary:parms];
    }
    
    return  [[RequestBaseTool shareInstance] __request:@"POST"
                                             urlstr:urlstr
                                        requestData:parmars
                                            andIsEcode:NO
                                             compod:^(id responseObject,
                                                      NSError *aerrror) {
                                                 if (responseObject)
                                                 {
                                                     completion(responseObject);
                                                 }else{
                                                     anerror(aerrror);
                                                 }
                }];
}

+(NSURLSessionDataTask *)ecodeUpload:(NSString *)url
                           andParmrs:(id)parmrs
                        andParamData:(NSString *)paramData
                       andImagesInfo:(NSDictionary *)imgInfo
                       isCompression:(BOOL)isCompression
                       andCompletion:(void(^)(id obj))completion
                         andProgress:(void(^)(float prog))aProgres
                               Error:(void(^)(NSError *errror))anerror
{
    if (!parmrs) {
        parmrs = [NSDictionary dictionary];
    }
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]initWithDictionary:parmrs];
    NSString *ss = [[[paramData stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@";" withString:@"；" ] stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    // 加密参数
	NSString * paramData_encode = ss;
    [mutableDic setObject:paramData_encode forKey:@"paramData"];
    
    
    return [self upload:url andParmrs:mutableDic andIsEcode:YES andImagesInfo:imgInfo isCompression:isCompression andCompletion:completion andProgress:aProgres Error:anerror];
}

+(NSURLSessionDataTask *)upload:(NSString *)url
                      andParmrs:(id)parmrs
                     andIsEcode:(BOOL)isEcode
                  andImagesInfo:(NSDictionary *)imgInfo
                  isCompression:(BOOL)isCompression
                  andCompletion:(void(^)(id obj))completion
                    andProgress:(void(^)(float prog))aProgres
                          Error:(void(^)(NSError *errror))anerror
{
    return [[self shareInstance]upload:url
                             andParmrs:parmrs
                            andIsEcode:isEcode
                         andImagesInfo:imgInfo
                         isCompression:isCompression
                         andCompletion:completion
                           andProgress:aProgres
                                 Error:anerror];
}

/**
 * 基础的网络请求
 */
-(NSURLSessionDataTask *)__request:(NSString *)method
                            urlstr:(NSString *)url
                       requestData:(id)requestData
                        andIsEcode:(BOOL)isEcode
                            compod:(void(^)(id responseObject, NSError *aerrror))compoletion;
{
#ifdef DEBUG
    NSLog(@"请求参数--------- %@",requestData);
#endif
    if (ISNullString(url))
    {
        NSError *error = [NSError errorWithDomain:@"--地址为空---400" code:400 userInfo:nil];
        compoletion(nil,error);
        return nil;
    }
#pragma mark GET请求
    if ([method isEqualToString:@"GET"])
    {
        return  [self.afmanager GET:url parameters:requestData progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isEcode)
            {
                //加密回执解密
                NSData *responseData;
                //NSString *string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
			   responseData = responseObject;
                id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                compoletion(result,nil);
                
            }else  if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                compoletion(responseObject,nil);
            }
            else
            {
                id comp =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                compoletion(comp,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                if (compoletion)
                {
                    compoletion(nil,error);
                }
            }
        }];
    }
#pragma mark POST请求
    if([method isEqualToString:@"POST"])
    {
        //发出post请求
        if (requestData ==nil)
        {
            NSLog(@"请求参数为空");
            NSError *error = [NSError errorWithDomain:@"--请求参数为空---909" code:400 userInfo:nil];
            compoletion(nil,error);
            return nil;
        }
        return  [self.afmanager POST:url parameters:requestData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (isEcode)
            {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                 NSData *responseData;
                NSString *string;
                if (!result){
                    
                   string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
					responseData = responseObject;
				if (responseData) {
                      result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
				}else{
				NSLog(@"返回数据有问题---------！ %@",string);
				}
                }else{
                //为了适应安卓写的方法-----------——！！！！！！--------
                NSString *string = nil;
                //防止取值崩溃
                @try {
                    string = result[@"encrypt"];
                } @catch (NSException *exception) {
 #if DEBUG
                    NSLog(@"返回参数有问题----");
#endif
                }
                 if(!ISNullString(string)){

                      result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                    }
                }
                //加密回执解密
                NSError *error = nil;
                if(!result){
                 error =  [NSError errorWithDomain:string code:500 userInfo:@{@"reson":@"未能将数据解析出来"}];
                }
                compoletion(result,error);
#if DEBUG
                
#ifdef TOJSO_NDIC_MACRO
                NSLog(@" 测试环境下输出结果  %@",[result tojsonString]);
#endif
                
#endif
                
            }else  if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                compoletion(responseObject,nil);
            }else{
                  NSString * string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
#if DEBUG
                NSLog(@"---打印输出----------- %@",string);
#endif
                id comp =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                compoletion(comp,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                if (compoletion)
                {
                    compoletion(nil,error);
                }
            }
        }];
        
    }
#pragma mark PUT请求
    if([method isEqualToString:@"PUT"]){
        //发出PUT请求
        return  [self.afmanager PUT:url parameters:requestData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            if (isEcode)
            {
                NSData *responseData;
                 responseData = responseObject;
                 id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                compoletion(result,nil);
                
            }else if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                compoletion(responseObject,nil);
            }
            else
            {
                id comp =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                compoletion(comp,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            compoletion(nil,error);
        }];
    }
#pragma mark DELETE请求
    
    if([method isEqualToString:@"DELETE"])
    {
        return  [self.afmanager DELETE:url parameters:requestData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isEcode)  {
                //加密回执解密
                NSData *responseData;
				responseData = responseObject;
                id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                compoletion(result,nil);
                
            }else  if ([responseObject isKindOfClass:[NSDictionary class]]) {
                compoletion(responseObject,nil);
            }  else  {
                id comp =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                compoletion(comp,nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            compoletion(nil,error);
        }];
        
    }
    return nil;
}
//----------------------------上传图片------------
-(NSURLSessionDataTask *)upload:(NSString *)url
                      andParmrs:(id)parmrs
                     andIsEcode:(BOOL)isEcode
                  andImagesInfo:(NSDictionary *)imgInfo
                  isCompression:(BOOL)isCompression
                  andCompletion:(void(^)(id obj))completion
                    andProgress:(void(^)(float prog))aProgres
                          Error:(void(^)(NSError *errror))anerror
{
    
    __weak RequestBaseTool *weakSelf = self;
    NSLog(@" 输出请求参数   ===|   %@",parmrs);
    return  [self.afmanager POST:url parameters:parmrs constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        for (NSString *key in imgInfo.allKeys) {
            NSArray *images = imgInfo[key];
            
            for (int i = 0; i< images.count; i++)
            {
                UIImage *image = images[i];
                
                NSData *imageData =nil;
                NSString *imgType = @".jpg";
//                if (![image isKindOfClass:[UIImage class]]) {
//                    NSData *temData = (NSData *)image;//临时data
//                    imageData = [self zipGIFWithData:temData];//转换大小后的数据
//                     imgType = @".gif";
//                }else{
                    if (isCompression)
                    {
                        imageData = [weakSelf compressImage:image toMaxFileSize:img_max_size];
                    }else{
                        imageData = UIImageJPEGRepresentation(image, 1);
                    }
//                }
                NSInteger ms = [[NSDate date]timeIntervalSince1970]*1000/1;
                NSString *str = [NSString stringWithFormat:@"%ld",(long)ms];
                NSString *fileName = [NSString stringWithFormat:@"%@%@",str,imgType];
                [formData appendPartWithFileData:imageData name:key fileName:fileName mimeType:@"png/jpg/gif"];
            }
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        CGFloat progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        // 回到主队列刷新UI,用户自定义的进度条
        dispatch_async(dispatch_get_main_queue(), ^{
            // NSString *progressStr = [NSString stringWithFormat:@"%.2f",progress];
            if (aProgres)
            {
                aProgres(progress);
            }
        });
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
 
        dispatch_async(dispatch_get_main_queue(), ^{

            if (isEcode)
            {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                NSData *responseData;
                NSString *string;
                if (!result){
                    
                    string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
					responseData = responseObject;
                    result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                }else{
                    //适应安卓无法直接获取非json------
                    NSString *string = nil;
                    //防止取值崩溃
                    @try {
                        string = result[@"encrypt"];
                    } @catch (NSException *exception) {
                        NSLog(@"返回参数有问题----");
                    }
                    if(!ISNullString(string)){
						responseData =responseObject;
                        result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                    }
                }
                //加密回执解密
                NSError *error = nil;
                if(!result){
                    error =  [NSError errorWithDomain:string code:500 userInfo:@{@"reson":@"未能将数据解析出来"}];
                    if (anerror) {
                        anerror(error);
                    }
                }else{
                     completion(result);
#if DEBUG
                    
#ifdef TOJSO_NDIC_MACRO
                   NSLog(@" 测试环境下输出结果  %@",[result tojsonString]);
#endif
                    
#endif
                }
            }else  if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                completion(responseObject);
            }else{
                id comp =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                completion(comp);
            }
        });
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        dispatch_async(dispatch_get_main_queue(), ^{
            if (anerror) {
                anerror(error);
            }
        });
    }];
}

- (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

#pragma mark 压缩GIF动图------------------
-(NSData *)zipGIFWithData:(NSData *)data {
    
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray *images = [NSMutableArray array];
    
    NSInteger biteLength =   [data length];//字节数
    
    NSInteger oneImgBite =  10/count;
    NSLog(@"  输出压缩   前   gif 的大小  ！！！！！         %lu",(unsigned long)biteLength);
    if (biteLength<10) {
        CFRelease(source);
        return data;
    }
    
    for (size_t i = 0; i < count; i++) {
        
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        UIImage *ima = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];

         NSData *imgData  = [self compressImage:ima toMaxFileSize:oneImgBite];
        
        ima = [UIImage imageWithData:imgData];
        [images addObject:ima];
        
        CGImageRelease(image);
    }

    CFRelease(source);
    [self creatGifWithImages:images];
    
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentStr = [document objectAtIndex:0];
    NSString *textDirectory = [documentStr stringByAppendingPathComponent:@"gif"];
    NSString *path = [textDirectory stringByAppendingPathComponent:@"example.gif"];
    NSData *newData =  [NSData dataWithContentsOfFile:path];
    
    NSLog(@"  输出压缩后 gif 的大小  ！！！！！         %lu",(unsigned long)newData.length);
    
    return newData;
}
-(void)creatGifWithImages:(NSMutableArray *)images{
    
    //图像目标
    CGImageDestinationRef destination;
    //创建输出路径
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentStr = [document objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *textDirectory = [documentStr stringByAppendingPathComponent:@"gif"];
    
    [fileManager createDirectoryAtPath:textDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *path = [textDirectory stringByAppendingPathComponent:@"example.gif"];
    
    //创建CFURL对象
    
    CFURLRef url = CFURLCreateWithFileSystemPath (
                                                  
                                                  kCFAllocatorDefault,
                                                  
                                                  (CFStringRef)path,
                                                  
                                                  kCFURLPOSIXPathStyle,
                                                  
                                                  false);
    //通过一个url返回图像目标
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, NULL);
    //设置gif的信息,播放间隔时间,基本数据,和delay时间
    
    NSDictionary *frameProperties = [NSDictionary
                                     
                                     dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.1], (NSString *)kCGImagePropertyGIFDelayTime, nil]
                                     
                                     forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //设置gif信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString*)kCGImagePropertyGIFHasGlobalColorMap];
    
    [dict setObject:(NSString *)kCGImagePropertyColorModelGray forKey:(NSString *)kCGImagePropertyColorModel];
    
    //设置像素位数 为8位
    [dict setObject:[NSNumber numberWithInt:2] forKey:(NSString*)kCGImagePropertyDepth];
    
    //运行的次数
    [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:dict
                                   
                                                             forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    
    //合成gif
    for (UIImage * dImg in images)
        
    {
        CGImageDestinationAddImage(destination, dImg.CGImage, (__bridge CFDictionaryRef)frameProperties);
        
    }
    
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    
    CGImageDestinationFinalize(destination);
    
    CFRelease(destination);
    
}

- (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source{
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }

    CFRelease(cfFrameProperties);
    return frameDuration;
}

-(AFHTTPSessionManager *)afmanager
{
    if (_afmanager==nil)  {
        _afmanager = [AFHTTPSessionManager manager];
    }
    _afmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                            @"text/html",
                                                            @"image/jpeg",
                                                            @"image/png",
                                                            @"text/json",
                                                            @"xml",nil];
    _afmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_afmanager.requestSerializer willChangeValueForKey:@"timeoutInterval"];

    //设置请求超时的时间
    _afmanager.requestSerializer.timeoutInterval = requestTimeoutInterval;
    [_afmanager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
  //允许网络请求的时候顶部状态栏转圈
 AFNetworkActivityIndicatorManager *manager = [AFNetworkActivityIndicatorManager sharedManager];
 manager.enabled = YES;

    return _afmanager;
}

+(void)cancelAllRequest
{
    AFHTTPSessionManager *manger =  [[self shareInstance] afmanager];
    [manger.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
}




@end
