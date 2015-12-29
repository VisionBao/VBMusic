//
//  VBPlayingVC.m
//  VBMusic
//
//  Created by Vision on 15/12/24.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBPlayingVC.h"
#import <BFKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VBHTTPHelper.h"
#import "VBFileManager.h"
#import <AFNetworking.h>

@interface VBPlayingVC (){
}
@property (nonatomic, strong)AVPlayer *mainPlayer;
@property (nonatomic, strong)AVPlayerItem *playerItem;
@property (nonatomic, strong)UIView *aaaaa;
@end

@implementation VBPlayingVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *songUrl = @"http://m5.file.xiami.com/46/16046/140343/1908947_2311158_l.mp3?auth_key=57c2870ec3852758f725c32d3f94374c-1451433600-0-null";
    
//    [VBHTTPManager downloadRequest:songUrl successAndProgress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
//        NSLog(@"- %lld - %lld",bytesWritten, totalBytesWritten);
//    } complete:^(id dataObj, NSError *error) {
//        NSString *musicPath = [VBFileManager getPathWithType:VBFilePATH_LOCALMUSIC];
//        [NSFileManager defaultManager];
//        
//        VBLogInfo(@"%@",musicPath);
////        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fuck.mp3",musicPath]];
//        NSData *data = [NSData dataWithData:dataObj];
//        [data writeToFile:[NSString stringWithFormat:@"%@/fuck.mp3",musicPath] atomically:YES];
//        
//        
//    }];
//    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:]];
    [_mainPlayer replaceCurrentItemWithPlayerItem:_playerItem];
    
    NSString *musicPath = [VBFileManager getPathWithType:VBFilePATH_LOCALMUSIC];
    VBLogInfo(@"%@",musicPath);
    [VBHTTPManager downloadRequest:songUrl filePath:[NSString stringWithFormat:@"%@",musicPath] successAndProgress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        NSLog(@"- %lld - %lld",bytesWritten, totalBytesWritten);
    } complete:^(id dataObj, NSError *error) {
        
    }];
    
    
    
    
    NSArray *array = @[@"播放", @"暂停", @"继续", @"下一曲", @"上一曲"];
    
    [array enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        tempBtn.frame = CGRectMake(idx * 70, 100, 60, 40);
        [tempBtn setTitle:obj forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn.tag = 1000 + idx;
        [self.view addSubview:tempBtn];
    }];
    
}
- (void)buttonClicked:(UIButton *)sender{
    switch (sender.tag - 1000) {
        case 0:
        {
            VBLogInfo(@"播放");
            [_mainPlayer play];
        }
            break;
        case 1:
        {
            VBLogInfo(@"暂停");
            [_mainPlayer pause];
        }
            break;
        case 2:
        {
            VBLogInfo(@"继续");
        }
            break;
        case 3:
        {
            VBLogInfo(@"下一曲");
        }
            break;
        case 4:
        {
            VBLogInfo(@"上一曲");
        }
            break;
        default:
            break;
    }
}
- (void)dealloc{

}
@end
