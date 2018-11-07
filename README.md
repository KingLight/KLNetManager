##### 安装 
```
pod 'KLNetManager'
```



#### 网络请求封装说明
项目中的网络请求返回格式为统一的json数据，其返回体大致分为三类
- 返回数据类型是 模型数组(模型列表)
- 返回数据类型是 单个的模型(单个的词典,map)
- 返回数据类型为 成功或失败类型

项目中的请求方法主要为POST和GET,
基于以上，将网络请求封装如下：

#### 请求方法中的回调格式

- 请求状态

```
typedef NS_ENUM(NSUInteger, KLRequestStatus) {
    ///失败
    KLRequestFailure,
    ///成功
    KLRequestSuccess
};
```

- 网络返回数组(列表)的回调

```
typedef void(^RequestResultList)(KLRequestStatus success, NSArray *modelArray, KLRequestState *state);
```


- 网络返回单个模型的回调

```
typedef void(^RequestResultModel)(KLRequestStatus success, id model, KLRequestState *state);

```
- 往返返回字典的回调

```
typedef void(^RequestResultDict)(KLRequestStatus success, NSDictionary *dict, KLRequestState *state);
```

- 返回成功或失败

```
typedef void(^RequestResultComplete)(KLRequestStatus success, KLRequestState *state);
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

#####  主体类
- KLNetManager 
    - 配置项目中网络请求的根目录
    
     ``` + (void)configBaseUrl:(NSString *)baseUrl; ```  
      
      
    - 设置 后台返回的 数据字段的字段内容,默认是data
    
     ``` + (void)configDataType:(NSString *)type; ```

    - 设置后台 成功返回数据时的状态码值，默认是200
    
        ``` + (void)configSuccessType:(NSInteger)type; ``` 
        
    -  设置返回数据中的msg字段 

     ``` + (void)configMsg:(NSString *)type; ```
    
    - 设置AFN请求中的manager，通常情况下，可以不配置。如果项目中采用了ssl验证需要配置

        ``` + (void)setupHttpSessionManager:(AFHTTPSessionManager *)manager; ```

