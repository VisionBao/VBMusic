//
//  VBHTTPModels.m
//  VBMusic
//
//  Created by Vision on 15/12/24.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBHTTPModels.h"
#import "VBHTTPHelper.h"
#import "VBHttpUrlManager.h"

@implementation VBHTTPModels
+ (void)fuck{
    NSDictionary * dic = @{@"id": @"1055535086"};
    [[VBHTTPManager defaultManager]postRequest:@"http://itunes.apple.com/lookup?id=1055535086" params:dic success:^(id responseObj) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
