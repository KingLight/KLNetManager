//
//  KLNetManager.h
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KLNetworking.h"

@interface KLNetManager : NSObject

/**
 配置基础请求url
 
 @param baseUrl url
 */
+ (void)configBaseUrl:(NSString *)baseUrl;



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
  resultList:(RequestResultList)result;


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
 resultModel:(RequestResultModel)result;



/**
 post请求 返回一个字典
 
 @param urlString url
 @param parameters parameers
 @param result 返回的字典回调
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
  resultDict:(RequestResultDict)result;



/**
 post请求 返回成功或失败
 
 @param urlString url
 @param parameters parameter
 @param result 返回成功或失败
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
resultComplete:(RequestResultComplete)result;




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
 resultList:(RequestResultList)result;


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
resultModel:(RequestResultModel)result;


/**
 Get请求 返回一个字典
 
 @param urlString url
 @param parameters parameter
 @param result 返回的字典
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
 resultDict:(RequestResultDict)result;



/**
 GET请求 返回成功或失败
 
 @param urlString urlString
 @param parameters parameters
 @param result 返回成功或失败
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
resultComplete:(RequestResultComplete)result;



/**
 设置 后台返回的 数据字段的字段内容
 默认值 为 data
 
 @param type 后台包含数据的字段值
 */
+ (void)configDataType:(NSString *)type;


/**
 设置后台 成功返回数据时的状态码值
 默认值 为200
 
 @param type 状态码值
 */
+ (void)configSuccessType:(NSInteger)type;


/**
 设置后太返回数据中的msg字段
 
 @param type msg字段值
 默认为 msg
 */
+ (void)configMsg:(NSString *)type;


/**
 设置AFN请求中的manager，通常情况下，可以不配置。如果项目中采用了ssl验证需要配置
 
 @param manager manager
 */
+ (void)setupHttpSessionManager:(AFHTTPSessionManager *)manager;
@end


