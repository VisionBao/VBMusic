//
//  VBRootVC.m
//  VBMusic
//
//  Created by Vision on 15/12/24.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBRootVC.h"
#import "VBPlayingVC.h"
#import "VBHTTPModels.h"
@implementation VBRootVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initNavBar];
    self.title = @"fuck";
    [self addRightPlayButton];
    [self addBackUpBtn];
    UIView *fuckView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    fuckView.backgroundColor = [UIColor yellowColor];
    [fuckView vb_registerMotionEffectWithdepth:40];
    [self.view addSubview:fuckView];
    [self fuckHttp];
    self.view.backgroundColor = [UIColor yellowColor];
}
- (void)fuckHttp{
    [VBHTTPModels fuck];
}
- (void)rightMenuBtnClick{
    VBPlayingVC *playingVC = [[VBPlayingVC alloc]init];
    [self presentViewController:playingVC animated:YES completion:nil];
}
@end
