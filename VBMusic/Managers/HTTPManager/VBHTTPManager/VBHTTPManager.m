//
//  VBHTTPManager.m
//  VBMusic
//
//  Created by Vision on 15/12/5.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBHTTPManager.h"

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
        _requestOperationMgr = [AFHTTPRequestOperationManager manager];
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
- (void)get{
    _requestOperationMgr = [AFHTTPRequestOperationManager manager];
    _requestOperationMgr.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [_requestOperationMgr GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    [[[VBHTTPManager defaultManager] requestOperationMgr] GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureHandler(error);
    }];
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
    [[[VBHTTPManager defaultManager] requestOperationMgr] POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
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
    [[[VBHTTPManager defaultManager] requestOperationMgr] PUT:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successHandler(successHandler);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
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
    [[[VBHTTPManager defaultManager] requestOperationMgr] DELETE:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successHandler(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler{
    if (![[VBHTTPManager defaultManager] checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
}

@end
