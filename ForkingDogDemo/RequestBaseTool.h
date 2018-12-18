//
//  RequestBaseTool.h
//  Reader
//
//  Created by ios2 on 2017/12/8.
//  Copyright © 2017年 石家庄光耀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


//上传图片最大长度 如果压缩图片就会压缩到接近于 img_max_size 字节 30kb
#define img_max_size 40000

@interface RequestBaseTool : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *afmanager;


//---------------加密---------------——|请求---------——|

+(NSURLSessionDataTask *)ecodePostUrlStr:(NSString *)urlstr
                                andParms:(id)parms
                            andParamData:(NSString*)paramData
                           andCompletion:(void(^)(id obj))completion
                                   Error:(void(^)(NSError *errror))anerror;


//------------------基础非加密请求---------------------|
+(NSURLSessionDataTask *)getUrlStr:(NSString *)urlstr
                          andParms:(NSDictionary *)parms
                     andCompletion:(void(^)(id obj))completion
                             Error:(void(^)(NSError *errror))anerror;

+(NSURLSessionDataTask *)postUrlStr:(NSString *)urlstr
                           andParms:(id)parms
                      andCompletion:(void(^)(id obj))completion
                              Error:(void(^)(NSError *errror))anerror;


//------------------基础请求---------------------|
-(NSURLSessionDataTask *)__request:(NSString *)method
                            urlstr:(NSString *)url
                       requestData:(id)requestData
                        andIsEcode:(BOOL)isEcode
                            compod:(void(^)(id responseObject, NSError *aerrror))compoletion;
/** 加密上传图片
 * parmrs         非加密参数
 * paramData      要加密的字符串
 * imgInfo        上传图片的字典 结构{key:[img]}
 * isCompression  是否压缩图片
 * completion     完成的回调
 * aProgres       进度的回调
 * anerror        失败的回调
 */
+(NSURLSessionDataTask *)ecodeUpload:(NSString *)url
                      andParmrs:(id)parmrs
                        andParamData:(NSString *)paramData
                  andImagesInfo:(NSDictionary *)imgInfo
                  isCompression:(BOOL)isCompression
                  andCompletion:(void(^)(id obj))completion
                    andProgress:(void(^)(float prog))aProgres
                          Error:(void(^)(NSError *errror))anerror;



/**  imgInfo 参数的类型
 *   多个key上传多张不同图片
 {
 key1:[img1,img2,img3],
 key2:[img2],
 key3:[img3]
 }
 *  单个key 上传多张图片
 {
 key1:[img1,img2,img3],
 }
 * 单张图片 {key:[img]}
 * key 为服务器给的 比如上传头像 {avatar:[img]}
 *
 *
 * 对应多张图片不同key的情况 类似于这种要求
 *
 */

+(NSURLSessionDataTask *)upload:(NSString *)url
                      andParmrs:(id)parmrs
                     andIsEcode:(BOOL)isEcode
                  andImagesInfo:(NSDictionary *)imgInfo
                  isCompression:(BOOL)isCompression
                  andCompletion:(void(^)(id obj))completion
                    andProgress:(void(^)(float prog))aProgres
                          Error:(void(^)(NSError *errror))anerror;
//取消所有的网络请求
+(void)cancelAllRequest;

@end
