//
//  ZSAdvertismentView.h
//
//
//  Created by 张森 on 15/10/13.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^imageTouchBlock) (NSInteger selectIndex);
@interface ZSAdvertismentView : UIView
/**
 *  高度
 */
@property (nonatomic ,assign) CGFloat height;
/**
 *  图片名称
 */
@property (nonatomic ,strong) NSArray * imagesName;

- (void)setImageTouchBlock:(imageTouchBlock)block;
@end
