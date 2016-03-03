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
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaQuery.h>
@interface VBPlayingVC ()
{
}
@property (nonatomic, strong)AVPlayer *mainPlayer;
@property (nonatomic, strong)AVPlayerItem *playerItem;

@end

@implementation VBPlayingVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *songUrl = @"http://m5.file.xiami.com/606/80606/405500/1769806650_1827630_l.mp3?auth_key=4e32eb942e926a97db6766cf009d60f4-1451433600-0-null";
    _mainPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:songUrl]];
   

    NSString *musicPath = [VBFileManager getPathWithType:VBFilePATH_LOCALMUSIC];
    VBLogInfo(@"%@",musicPath);
    
//    [[VBHTTPManager defaultManager] downloadRequest:songUrl filePath:[NSString stringWithFormat:@"%@",musicPath] successAndProgress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
//        NSLog(@"- %lld - %lld",bytesWritten, totalBytesWritten);
//    } complete:^(id dataObj, NSURL *filePath ,NSError *error) {
//        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
//
//
//        _playerItem = [AVPlayerItem playerItemWithURL:filePath];
//        [_mainPlayer replaceCurrentItemWithPlayerItem:_playerItem];
//        if (_mainPlayer == NULL)
//        {
//            NSLog(@"fail to play audio :(");
//            return;
//        }
//        
        [_mainPlayer setVolume:1];
        [_mainPlayer play];
        [self configNowPlayingInfoCenter];
//
//    }];
    
    
    
    
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
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [_mainPlayer play];
                VBLogInfo(@"播放");
                break;
            case UIEventSubtypeRemoteControlPause:
                [_mainPlayer pause];
                VBLogInfo(@"暂停");
                break;
            case UIEventSubtypeRemoteControlStop:
                VBLogInfo(@"停止");
                break;
                // 这个是插入耳机情况下暂停或者播放的事件，跟上面两个手动点击是不一样的
            case UIEventSubtypeRemoteControlTogglePlayPause:
                VBLogInfo(@"切换播放停止");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                VBLogInfo(@"下一曲");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                VBLogInfo(@"上一曲");
                break;
            default:
                break;
        }
    }
}
//- (void)configPlayingInfo{
//    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
////        if ((lastPlayItem != _mainPlayer.currentItem) && !isRepeat) {
////            lastPlayItem = _mainPlayercurrentItem;
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//            [dict setObject:self.titleLabel.text forKey:MPMediaItemPropertyTitle];//歌曲名设置
//            
//            [dict setObject:self.artistLabel.text forKey:MPMediaItemPropertyArtist];//歌手名设置
//            
//            
//            [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:self.artwork.image]  forKey:MPMediaItemPropertyArtwork];//专辑图片设置
//            
//            [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.player.currentItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
//            [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
//            [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.player.currentItem.duration)] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
//            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
//            
////        }
//    }
//}
-(void)configNowPlayingInfoCenter{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        //歌曲名称
        [dict setObject:@"song" forKey:MPMediaItemPropertyTitle];
        
        //演唱者
        [dict setObject:@"singer" forKey:MPMediaItemPropertyArtist];
        
        //专辑名
        [dict setObject:@"album" forKey:MPMediaItemPropertyAlbumTitle];
        
        //专辑缩略图
        UIImage *image = [UIImage imageNamed:@"main_playing_animation4"];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        //音乐剩余时长
        [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_mainPlayer.currentItem.duration)] forKey:MPMediaItemPropertyPlaybackDuration];
        
        //音乐当前播放时间 在计时器中修改
        [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_mainPlayer.currentItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        //设置锁屏状态下屏幕显示播放音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
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
