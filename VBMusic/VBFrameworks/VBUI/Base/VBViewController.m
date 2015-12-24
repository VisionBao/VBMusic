//
//  VBViewController.m
//  VBMusic
//
//  Created by Vision on 15/12/24.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBViewController.h"

@implementation VBViewController{
    UIImageView *_rightPlayImageView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setClipsToBounds:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)initNavBar{
    if (!_navBar) {
        _navBar = [[VBNavigationBar alloc] init];
        _navItem = [[UINavigationItem alloc] init];
        
        [_navBar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
        [_navBar setTranslucent:NO];
        [_navBar pushNavigationItem:_navItem animated:NO];
        [_navBar setBarTintColor:[UIColor whiteColor]];
        [_navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[VBColorManager colorWithHomeColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial Rounded MT Bold" size:17],NSFontAttributeName, nil]];
        
        [self.view addSubview:_navBar];
    }
}
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self setNavBarTitle:title];
}
- (void)addBackUpBtn{
    if (!_backUpButton) {
        _backUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backUpButton.frame = CGRectMake(0, 0, 44, 44);
        [_backUpButton setBackgroundColor:[UIColor clearColor]];
        _backUpButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_backUpButton setImage:[UIImage imageNamed:@"but_back"] forState:(UIControlStateNormal)];
        [_backUpButton addTarget:self action:@selector(backBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_backUpButton];
    _navItem.leftBarButtonItem = backBtnItem;

}
- (void)addRightPlayButton{
    if (!_rightMenuButton) {
        _rightMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 35, STATUS_BAR_HEIGHT, 40, 40)];
        //        [_rightMenuNavBtn setBackgroundColor:[UIColor redColor]];
        _rightMenuButton.layer.masksToBounds = YES;
    }
    
    [_rightMenuButton addTarget:self action:@selector(rightMenuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_rightPlayImageView) {
        _rightPlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 18, 19)];
        _rightPlayImageView.animationDuration = .5;
        [_rightPlayImageView setImage:[UIImage imageNamed:@"main_playing_animation1"]];
        _rightPlayImageView.animationImages = [NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"main_playing_animation1"],
                                               [UIImage imageNamed:@"main_playing_animation2"],
                                               [UIImage imageNamed:@"main_playing_animation3"],
                                               [UIImage imageNamed:@"main_playing_animation4"],
                                               nil];
    }
    
//    if ([[CMPlayingViewController defaultPlayCenterViewCtrl] isPlaying]) {
        [_rightPlayImageView startAnimating];
//    }
    
    [_rightMenuButton addSubview:_rightPlayImageView];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightMenuButton];
    _navItem.rightBarButtonItem = rightBtnItem;
}
- (void)setNavBarTitle:(NSString *)string{
    _navItem.title = string;
}
- (void)addLeftBtn:(NSString *)title backImg:(NSString *)backImg{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    if (backImg && [backImg length] > 0) {
        UIImage *image = [UIImage imageNamed:backImg];
        if (image) {
            [leftBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            [leftBtn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
        }
    } else if (title.length>0) {
        leftBtn.width = title.length*17;
    }
    
    [leftBtn addTarget:self action:@selector(backBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    _navItem.rightBarButtonItem = backBtnItem;
}
- (void)addRightBtn:(NSString *)title backImg:(NSString *)backImg{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    if (backImg && [backImg length] > 0) {
        UIImage *image = [UIImage imageNamed:backImg];
        if (image) {
            [rightBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            [rightBtn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
        }
    } else if (title.length>0) {
        rightBtn.width = title.length*17;
    }
    
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    _navItem.rightBarButtonItem = backBtnItem;
}



#pragma mark -- buttonAction
- (void)backBtnItemClick {
    id backViewController = [self.navigationController popViewControllerAnimated:YES];
    if (!backViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)rightBtnClick:(UIButton *)sender{
    
}
- (void)rightMenuBtnClick{

}
@end
