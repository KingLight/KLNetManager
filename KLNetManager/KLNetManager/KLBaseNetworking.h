//
//  KLBaseNetworking.h
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;
#define kUPLOADBaseURL @""


@interface KLBaseNetworking : NSObject

@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) AFHTTPSessionManager *manager;


+ (instancetype)shareNetworking;

+ (void)configBaseUrl:(NSString *)baseUrl;
+ (void)configHttpSessionManager:(AFHTTPSessionManager *)manager;

+ (void)configDataType:(NSString *)type;

+ (void)configSuccessType:(NSInteger)type;

+ (void)configMsg:(NSString *)type;




/**
 POST - 基类请求请求
 
 @param urlString url
 @param parameters 参数
 @param success 成功
 @param failure 失败
 */
+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 GET - 基类请求
 
 @param urlString url
 @param parameters 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 上传的post请求
 
 @param urlString 上传的url
 @param parameters 参数
 @param data 数据流
 @param typeName 类型名字 (与后台约定)
 @param fileName 文件名字
 @param fileType 文件类型 ((图片image/jpeg, 音频amr/mp3/wmr))
 @param success 成功
 @param failure 失败
 */
+ (void)Upload:(NSString *)urlString
     parameter:(id)parameters
          data:(NSData *)data
     typeyName:(NSString *)typeName
      fileName:(NSString *)fileName
      fileType:(NSString *)fileType
       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end


