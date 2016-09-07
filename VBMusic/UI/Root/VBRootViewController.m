//
//  VBRootViewController.m
//  VBMusic
//
//  Created by Vision on 16/9/5.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBRootViewController.h"
#import "VBPlayerViewController.h"


@interface VBRootViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation VBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"fuck" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 40));
    }];
}

- (void)buttonClicked:(UIButton *)sender {
    VBPlayerViewController *playerViewController = [[VBPlayerViewController alloc] init];
    [self.navigationController pushViewController:playerViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
