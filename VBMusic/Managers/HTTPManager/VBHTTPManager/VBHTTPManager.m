//
//  VBHTTPManager.m
//  VBMusic
//
//  Created by Vision on 15/12/5.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBHTTPManager.h"
#import "VBFileConfig.h"

@implementation VBHTTPManager

+ (id)defaultManager{
    static VBHTTPManager *httpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[VBHTTPManager alloc] init];
    });
    return httpManager;
}
- (id)init{
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }
    return self;
}
- (BOOL)checkNetworkStatus {
    __block BOOL isNetworkUse = YES;
    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            //未知
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            //WiFi
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            //移动网络
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
        }
    }];
    [_reachabilityManager startMonitoring];
    return isNetworkUse;
}

/**
 GET请求
 */
+ (void)getRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    [[[VBHTTPManager defaultManager] sessionManager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
//    [[[VBHTTPManager defaultManager] session] GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        successHandler(responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        failureHandler(error);
//    }];
}

/**
 POST请求
 */
+ (void)postRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 PUT请求
 */
+ (void)putRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(successHandler);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 DELETE请求
 */
+ (void)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        progressHandler(0, 0);
        completionHandler(nil, nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        progressHandler(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
    
}
/**
 文件上传
 */
+ (void)updateRequest:(NSString *)url params:(NSDictionary *)params fileConfig:(VBFileConfig *)fileConfig success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 文件上传，监听上传进度
 */
+ (void)updateRequest:(NSString *)url params:(NSDictionary *)params fileConfig:(VBFileConfig *)fileConfig successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        progressHandler(0, 0);
        completionHandler(nil, nil);
        return;
    }
    [[[VBHTTPManager defaultManager] sessionManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressHandler(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil, error);
    }];
}
@end



