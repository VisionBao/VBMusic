//
//  VBPlayerViewController.m
//  VBMusic
//
//  Created by Vision on 16/9/5.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

#import "VBPlayerViewController.h"

@interface VBPlayerViewController ()

//UI
@property (nonatomic, strong) UIImageView *backImageView;




@end

@implementation VBPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backImageView = [[UIImageView alloc] init];
    
    [self.view addSubview:_backImageView];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));

    }];
    
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
