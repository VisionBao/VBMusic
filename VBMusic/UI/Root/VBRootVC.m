//
//  VBRootVC.m
//  VBMusic
//
//  Created by Vision on 15/12/24.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBRootVC.h"

@implementation VBRootVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initNavBar];
    self.title = @"fuck";
    [self addRightPlayButton];
    [self addBackUpBtn];

}

@end
