//
//  ViewController.m
//  ZSAdversmentView
//
//  Created by 张森 on 15/11/30.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "ViewController.h"
#import "ZSAdvertismentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZSAdvertismentView * advertisment = [[ZSAdvertismentView alloc]init];
    advertisment.height = 300;
    advertisment.imagesName = @[@"1",@"2",@"3"];
    [advertisment setImageTouchBlock:^(NSInteger selectIndex) {
        NSLog(@"%zd",selectIndex);
    }];
    [self.view addSubview:advertisment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
