//
//  KLNetworking.h
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import "KLBaseNetworking.h"

@class KLRequestState;

///请求成功的状态吗
static NSInteger kRequestSuccess = 200;
static NSString *kRequestStatusCode = @"code";
static NSString *kRequestStatusMsg = @"msg";

///后台返回的保函数据内容的字段
static NSString *kRequestData = @"data";

///请求状态
typedef NS_ENUM(NSUInteger, KLRequestStatus) {
    ///失败
    KLRequestFailure,
    ///成功
    KLRequestSuccess
};

///网络返回数组(列表)的回调
typedef void(^RequestResultList)(KLRequestStatus success, NSArray *modelArray, KLRequestState *state);


///网络返回单个模型的回调
typedef void(^RequestResultModel)(KLRequestStatus success, id model, KLRequestState *state);

///往返返回字典的回调
typedef void(^RequestResultDict)(KLRequestStatus success, NSDictionary *dict, KLRequestState *state);

///返回成功或失败
typedef void(^RequestResultComplete)(KLRequestStatus success, KLRequestState *state);

//获取当前用户的token
NSString *tokenForCurrentUser(void);


@interface KLNetworking : KLBaseNetworking
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

    
@end




@interface KLRequestState : NSObject

@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSString *msg;

+ (instancetype)KLRequestState:(id)responseObject;
+ (instancetype)errorRequestState;

@end
