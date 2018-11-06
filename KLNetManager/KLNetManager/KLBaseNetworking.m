//
//  KLBaseNetworking.m
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import "KLBaseNetworking.h"

#import "MJExtension.h"
#import "AFNetworking.h"

static KLBaseNetworking *_networking = nil;

@implementation KLBaseNetworking
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
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [KLBaseNetworking shareNetworking].manager;
    
    NSString *url = [self baseAPI:urlString];
    NSLog(@"\n\n请求参数parameter\n:%@\n\n", [parameters mj_JSONString]);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n\n接口地址:\n%@", url);
        NSLog(@"\n\n参数:\n%@", [parameters mj_JSONString]);
        NSLog(@"\n\n\nPOST基类网络返回:\n%@\n",responseObject);
        if (success) {
            
            NSString *errMsg = responseObject[@"err_msg"];
            errMsg = [errMsg stringByRemovingPercentEncoding];
            if (errMsg.length > 1) NSLog(@"\n=====================================================\n 网络返回信息err_msg:%@\n", errMsg);
            success(task, responseObject);
        } else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n接口地址:\n%@", [NSString stringWithFormat:@"%@%@",[KLBaseNetworking shareNetworking].baseUrl,urlString]);
        NSLog(@"\n\n参数:\n%@", [parameters mj_JSONString]);
        NSLog(@"\n\n接口：%@\n\n", urlString);
        NSLog(@"\nPOST基类网络返回失败:\n%@", error.userInfo);
        if (failure) {
            failure(task, error);
        }
        
    }];
}


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
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    
    AFHTTPSessionManager *manager = [KLBaseNetworking shareNetworking].manager;;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *uploadUrl = [NSString stringWithFormat:@"%@%@", kUPLOADBaseURL, urlString];
    NSLog(@"uploadURL:%@", uploadUrl);
    [manager POST:uploadUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (data) {
            [formData appendPartWithFileData:data name:typeName fileName:fileName mimeType:fileType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n==================================================");
        NSLog(@"ResponseObject:%@\n", responseObject);
        NSLog(@"======================================================");
        !success?:success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Upload error:%@", error.userInfo);
        !failure?:failure(task, error);
    }];
    
}


+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure
{
    AFHTTPSessionManager *manager = [KLBaseNetworking shareNetworking].manager;
    NSString *api = [self baseAPI:urlString];
    NSLog(@"接口地址:%@",api);
    
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [security setValidatesDomainName:NO];
    security.allowInvalidCertificates = YES;
    manager.securityPolicy = security;
    
    [manager GET:api parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n\n接口地址:\n%@", [NSString stringWithFormat:@"%@%@",[KLBaseNetworking shareNetworking].baseUrl,urlString]);
        NSLog(@"\n\n参数:\n%@", [parameters mj_JSONString]);
        NSLog(@"\n\nGET基类请求返回:\n%@", responseObject);
        
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n接口地址:\n%@", [NSString stringWithFormat:@"%@%@",[KLBaseNetworking shareNetworking].baseUrl,urlString]);
        NSLog(@"\n\n参数:\n%@", [parameters mj_JSONString]);
        NSLog(@"\n\n网络错误返回:\n%@", error.userInfo);
        if (failure) {
            failure(task, error);
        }
    }];
}



+ (NSString *)baseAPI:(NSString *)aUrl {
    NSString *baseUrl;
    if (aUrl && aUrl.length > 1) {
        baseUrl = [NSString stringWithFormat:@"%@%@", [KLBaseNetworking shareNetworking].baseUrl, aUrl];
    } else {
        baseUrl = [KLBaseNetworking shareNetworking].baseUrl;
    }
    return baseUrl;
}

+ (void)configBaseUrl:(NSString *)baseUrl {
    [KLBaseNetworking shareNetworking].baseUrl = baseUrl;
}
+ (instancetype)shareNetworking {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networking = [[KLBaseNetworking alloc] init];
        _networking.manager = [self defaultManager];
    });
    return _networking;
}

+ (AFHTTPSessionManager *)defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    return manager;
}

+ (void)configHttpSessionManager:(AFHTTPSessionManager *)manager {
    [KLBaseNetworking shareNetworking].manager = manager;
}

+ (void)configDataType:(NSString *)type {
    
}

+ (void)configSuccessType:(NSInteger)type {
    
}

+ (void)configMsg:(NSString *)type {
    
}

@end
