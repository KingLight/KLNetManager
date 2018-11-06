//
//  KLNetworking.m
//  KLNetManager
//
//  Created by King on 2018/11/6.
//  Copyright © 2018 king. All rights reserved.
//

#import "KLNetworking.h"

#import "MJExtension.h"
#import "AFNetworking.h"
#pragma mark - 获取当前用户的token
///获取当前用户的token
NSString *tokenForCurrentUser() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"token"];
}


@implementation KLNetworking

//********   POST请求   ********/

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
    [self POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestList:responseObject modelClass:modelClass result:result];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
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
    
    [self POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestModel:responseObject modelClass:modelClass result:result];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
    
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
    
    [self POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestDict:responseObject result:result];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
    
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
    
    
    [self POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestComplete:responseObject result:result];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure,[KLRequestState errorRequestState]);
    }];
}

/********   GET请求   ********/

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
    
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestModel:responseObject modelClass:modelClass result:result];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
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
    
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestDict:responseObject result:result];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
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
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestComplete:responseObject result:result];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure,[KLRequestState errorRequestState]);
    }];
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
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestList:responseObject modelClass:modelClass result:result];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !result?:result(KLRequestFailure, nil, [KLRequestState errorRequestState]);
    }];
}



/********   通过responseObject返回回调    ********/
/**
 通过给定的网络返回数据 返回一个带有模型数组的回调
 */
+ (void)requestList:(id)responseObject modelClass:(Class)modelClass result:(RequestResultList)result {
    KLRequestState *state = [KLRequestState KLRequestState:responseObject];
    KLRequestStatus success = KLRequestFailure;
    NSArray *modelArray;
    
    if ([responseObject[kRequestStatusCode] integerValue] == kRequestSuccess &&
        [responseObject[kRequestData] isKindOfClass:[NSArray class]]) {
        success = KLRequestSuccess;
        if (modelClass) {
            modelArray = [modelClass mj_objectArrayWithKeyValuesArray:responseObject[kRequestData]];
        }
    }
    !result?:result(success, modelArray, state);
}


/**
 通过给定的网络返回数据 返回一个带有单个模型的回调
 */
+ (void)requestModel:(id)responseObject modelClass:(Class)modelClass result:(RequestResultModel)result {
    KLRequestState *state = [KLRequestState KLRequestState:responseObject];
    KLRequestStatus success = KLRequestFailure;
    id model;
    
    if (kRequestSuccess == [responseObject[kRequestStatusCode] integerValue] &&
        [responseObject[kRequestData] isKindOfClass:[NSDictionary class]]) {
        success = KLRequestSuccess;
        if (modelClass) {
            model = [modelClass mj_objectWithKeyValues:responseObject[kRequestData]];
        }
    }
    !result?:result(success, model, state);
}


/**
 通过给定的网络返回数据 返回一个带有词典的回调
 */
+ (void)requestDict:(id)responseObject result:(RequestResultDict)result {
    KLRequestState *state = [KLRequestState KLRequestState:responseObject];
    KLRequestStatus success = KLRequestFailure;
    NSDictionary *dict;
    if (kRequestSuccess == [responseObject[kRequestStatusCode] integerValue] &&
        [responseObject[kRequestData] isKindOfClass:[NSDictionary class]]) {
        success = KLRequestSuccess;
        dict = responseObject[kRequestData];
    }
    !result?:result(success, dict, state);
}

/**
 通过给定的网络返回数据 返回一个带成功失败的回调
 */
+ (void)requestComplete:(id)responseObject result:(RequestResultComplete)result {
    KLRequestState *state = [KLRequestState KLRequestState:responseObject];
    KLRequestStatus success = KLRequestFailure;
    
    if (kRequestSuccess == [responseObject[kRequestStatusCode] integerValue]) {
        success = KLRequestSuccess;
    }
    !result?:result(success, state);
}


/********   其他配置方法  ********/

+ (void)configDataType:(NSString *)type {
    kRequestData = type;
}

+ (void)configSuccessType:(NSInteger)type {
    kRequestSuccess = type;
}

+ (void)configMsg:(NSString *)type {
    kRequestStatusMsg = type;
}



@end



@implementation KLRequestState

+ (instancetype)KLRequestState:(id)responseObject {
    KLRequestState *state = [[KLRequestState alloc] init];
    state.code = [responseObject[kRequestStatusCode] integerValue];
    state.msg = responseObject[kRequestStatusMsg];
    return state;
}

+ (instancetype)errorRequestState {
    KLRequestState *state = [[KLRequestState alloc] init];
    state.msg = @"网络连接失败";
    state.code = 10000;
    return state;
}

@end
