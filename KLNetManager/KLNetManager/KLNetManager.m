//
//  KLNetManager.m
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import "KLNetManager.h"

@implementation KLNetManager
+ (void)configBaseUrl:(NSString *)baseUrl {
    [KLBaseNetworking configBaseUrl:baseUrl];
}




/**
 post请求 返回模型数组
 
 @param urlString url
 @param parameters parametr
 @param modelClass 模型class
 @param result 返回
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
  modelClass:(Class)modelClass
  resultList:(RequestResultList)result {
    [KLNetworking Post:urlString parameters:parameters modelClass:modelClass resultList:result];
}


/**
 post请求 返回单个模型
 
 @param urlString url
 @param parameters parameter
 @param modelClass model Class
 @param result 返回的模型
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
  modelClass:(Class)modelClass
 resultModel:(RequestResultModel)result {
    [KLNetworking Post:urlString parameters:parameters modelClass:modelClass resultModel:result];
}



/**
 post请求 返回一个字典
 
 @param urlString url
 @param parameters parameers
 @param result 返回的字典回调
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
  resultDict:(RequestResultDict)result {
    [KLNetworking Post:urlString parameters:parameters resultDict:result];
}



/**
 post请求 返回成功或失败
 
 @param urlString url
 @param parameters parameter
 @param result 返回成功或失败
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
resultComplete:(RequestResultComplete)result {
    [KLNetworking Post:urlString parameters:parameters resultComplete:result];
}




/**
 GET请求 - 返回模型数组
 
 @param urlString url
 @param parameters prameters
 @param modelClass model类
 @param result 返回的结果集
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
 modelClass:(Class)modelClass
 resultList:(RequestResultList)result {
    [KLNetworking Get:urlString parameters:parameters modelClass:modelClass resultList:result];
}


/**
 get请求 返回单个模型
 
 @param urlString url
 @param parameters paramenter
 @param modelClass 模型类
 @param result 返回的模型
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
 modelClass:(Class)modelClass
resultModel:(RequestResultModel)result {
    [KLNetworking Get:urlString parameters:parameters modelClass:modelClass resultModel:result];
}


/**
 Get请求 返回一个字典
 
 @param urlString url
 @param parameters parameter
 @param result 返回的字典
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
 resultDict:(RequestResultDict)result {
    [KLNetworking Get:urlString parameters:parameters resultDict:result];
}



/**
 GET请求 返回成功或失败
 
 @param urlString urlString
 @param parameters parameters
 @param result 返回成功或失败
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
resultComplete:(RequestResultComplete)result {
    [KLNetworking Get:urlString parameters:parameters resultComplete:result];
}

/**
 设置 后台返回的 数据字段的字段内容
 
 @param type 后台包含数据的字段值
 */
+ (void)configDataType:(NSString *)type {
    [KLNetworking configDataType:type];
}

/**
 设置后台 成功返回数据时的状态码值
 
 @param type 状态码值
 */
+ (void)configSuccessType:(NSInteger)type {
    [KLNetworking configSuccessType:type];
}

+ (void)configMsg:(NSString *)type {
    [KLNetworking configMsg:type];
}


/**
 设置AFN请求中的manager，通常情况下，可以不配置。如果项目中采用了ssl验证需要配置
 
 @param manager manager
 */
+ (void)setupHttpSessionManager:(AFHTTPSessionManager *)manager {
    [KLBaseNetworking shareNetworking].manager = manager;
}


@end
