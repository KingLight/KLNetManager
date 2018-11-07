
####网络请求封装说明
项目中的网络请求返回格式为统一的json数据，其返回体大致分为三类
- 返回数据类型是 模型数组(模型列表)
- 返回数据类型是 单个的模型(单个的词典,map)
- 返回数据类型为 成功或失败类型

项目中的请求方法主要为POST和GET,
基于以上，将网络请求封装如下：

#### 请求方法中的回调格式

- 请求状态

```
typedef NS_ENUM(NSUInteger, XFXRequestStatus) {
    ///失败
    XFXRequestFailure,
    ///成功
    XFXRequestSuccess
};
```

- 网络返回数组(列表)的回调

```
typedef void(^RequestResultList)(XFXRequestStatus success, NSArray *modelArray, XFXRequestState *state);
```


- 网络返回单个模型的回调

```
typedef void(^RequestResultModel)(XFXRequestStatus success, id model, XFXRequestState *state);

```
- 往返返回字典的回调

```
typedef void(^RequestResultDict)(XFXRequestStatus success, NSDictionary *dict, XFXRequestState *state);
```

- 返回成功或失败

```
typedef void(^RequestResultComplete)(XFXRequestStatus success, XFXRequestState *state);
```


#### POST方法
- 返回模型列表(数组) 

```
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
```
- 返回单个的模型 

```
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
```
- 返回单个词典 

```
/**
 post请求 返回一个字典
 
 @param urlString url
 @param parameters parameers
 @param result 返回的字典回调
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
  resultDict:(RequestResultDict)result;
```
- 返回成功或失败

```
/**
 post请求 返回成功或失败
 
 @param urlString url
 @param parameters parameter
 @param result 返回成功或失败
 */
+ (void)Post:(NSString *)urlString
  parameters:(id)parameters
resultComplete:(RequestResultComplete)result;
```
#### GET方法
- 返回模型列表(数组)

```
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
```
- 返回单个的模型

```
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
```
- 返回单个词典

```
/**
 Get请求 返回一个字典
 
 @param urlString url
 @param parameters parameter
 @param result 返回的字典
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
 resultDict:(RequestResultDict)result;
```
- 返回成功或失败

```
/**
 GET请求 返回成功或失败
 
 @param urlString urlString
 @param parameters parameters
 @param result 返回成功或失败
 */
+ (void)Get:(NSString *)urlString
 parameters:(id)parameters
resultComplete:(RequestResultComplete)result;
```


