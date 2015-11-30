# ZSAdversmentView
自动循环广告轮播器
ZSAdvertismentView * advertisment = [[ZSAdvertismentView alloc]init];
    advertisment.height = 300;
    advertisment.imagesName = @[@"name1",@"name2",@"name3"];
    [advertisment setImageTouchBlock:^(NSInteger selectIndex) {
        NSLog(@"%zd",selectIndex);
    }];
    [self.view addSubview:advertisment];
