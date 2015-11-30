//
//  ZSAdvertismentView.m
//
//
//  Created by 张森 on 15/10/13.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSAdvertismentView.h"

@interface ZSAdvertismentView()<UIScrollViewDelegate>{
    imageTouchBlock _imageTouchBlock;
    CGFloat _width;
}
@property (nonatomic ,weak) UIScrollView * scrollView;
@property (nonatomic ,weak) UIPageControl * pageControl;
@property (nonatomic ,strong) NSTimer * timer;
@end

@implementation ZSAdvertismentView
- (instancetype)init{
    if (self = [super init]){
        self.height = 200;
        _width = [UIScreen mainScreen].bounds.size.width;
        self.backgroundColor = [UIColor blackColor];
        [self startTimer];
    }
    return self;
}

#pragma mark --- 设置图片数组
- (void)setImagesName:(NSArray *)imagesName{
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:[imagesName lastObject]];
    for (id obj in imagesName) {
        [array addObject:obj];
    }
    [array addObject:imagesName[0]];
    _imagesName = array;
    [self createFrame:imagesName];
}

- (void)imageTouch:(UIButton *)button{
    if (_imageTouchBlock) {
        _imageTouchBlock(button.tag - 1);
    }
}

- (void)setImageTouchBlock:(imageTouchBlock)block{
    _imageTouchBlock = block;
}

- (void)createFrame:(NSArray *) imagesName{
    self.frame = CGRectMake(0, 0, _width, _height);
    [self createUI];
    
    self.scrollView.contentSize =CGSizeMake(_imagesName.count * _width, 0);
    self.scrollView.contentOffset = CGPointMake(_width, 0);
    
    self.pageControl.numberOfPages = imagesName.count;
    CGFloat pageW = self.pageControl.numberOfPages * 20;
    CGFloat pageX = 0;
    CGFloat pageY = self.frame.size.height - 20;
    //设置pageControl的frame值
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, 20);
}

#pragma mark --- 创建UI
- (void)createUI{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.frame = self.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:90/255.0 green:200/255.0 blue:255/255.0 alpha:1.0];
    
    CGFloat imageH = self.scrollView.frame.size.height;
    for (int i = 0; i < _imagesName.count; i++) {
        UIButton * imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton setBackgroundImage:[UIImage imageNamed:_imagesName[i]] forState:UIControlStateNormal];
        CGFloat imageX = i * _width;
        imageButton.frame = CGRectMake(imageX, 0, _width, imageH);
        imageButton.tag = i + 1;
        [imageButton addTarget:self action:@selector(imageTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:imageButton];
    }
}

#pragma mark --- 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat Width=self.frame.size.width;
    if (scrollView.contentOffset.x <= 0) {
        [self.scrollView setContentOffset:CGPointMake(Width*([self.imagesName count]-2), 0) animated:NO];
    }else if (scrollView.contentOffset.x >= Width*([self.imagesName count]-1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    self.pageControl.currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

#pragma mark --- 自动滚动辅助逻辑代码
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    // 把timer对象事件交给主要线程处理，不会出现UI阻塞
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll{
    int page = self.scrollView.contentOffset.x/self.frame.size.width;
    CGFloat offSetX = page * self.scrollView.frame.size.width + self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}

@end
