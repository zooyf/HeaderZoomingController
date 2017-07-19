//
//  YFBaseViewController.h
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/13.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFNavView;

@interface YFBaseViewController : UIViewController

/**
 布局是否完成.在viewDidLayoutSubviews()执行完毕后设置为true
 */
@property (nonatomic, readonly, assign) BOOL finishLayoutSubviews;

/**
 使用渐变导航栏,设置为true时导航栏渐变
 */
@property (nonatomic, assign) BOOL gradBarColorEnabled;

/**
 渐变高度,默认200
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 在scrollViewDidScroll:方法中调用此方法实现导航栏渐变

 @param currentPoint 传入scrollView.contentOffset来表示当前坐标
 */
- (void)updateNavBarAlpha:(CGPoint)currentPoint;

@end
