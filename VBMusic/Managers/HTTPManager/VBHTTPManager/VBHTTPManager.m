//
//  VBHTTPManager.m
//  VBMusic
//
//  Created by Vision on 15/12/5.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBHTTPManager.h"
#import <AFNetworking.h>

@implementation VBHTTPManager{
    AFHTTPRequestOperationManager *_requestOperationMgr;
    AFNetworkReachabilityManager *_reachabilityManager;
}

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
        [_reachabilityManager startMonitoring];
    }
    return self;
}
- (void)getCurrentReachabilityStatusBlock:(void (^)(AFNetworkReachabilityStatus status))block{
    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            //未知
        }
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //无网络
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            //移动网络
        }
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //WiFi
            
        }
    }];
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
@end
