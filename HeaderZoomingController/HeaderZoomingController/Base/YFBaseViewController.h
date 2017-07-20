//
//  YFBaseViewController.h
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/13.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFNavView;

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface YFBaseViewController : UIViewController

/**
 显示返回按钮，只有根视图控制器的时候才使用此属性
 Show the back button. Enabled when the controller is rootViewController of navigationController.
 */
@property (nonatomic, assign) BOOL showBackBtn;

/**
 点击左上角返回按钮执行的方法，重写以达到自己的目的
 Action of backBtn. Override to implement your custom function
 */
- (void)backAction;

#pragma mark ------- 透明渐变导航栏 -------
#pragma mark ------- Transparent gradColor navigation bar -------
/**
 布局是否完成.在viewDidLayoutSubviews()执行完毕后设置为true
 Whether did the layout have finished. YES after viewDidLayoutSubviews() get called.
 */
@property (nonatomic, readonly, assign) BOOL finishLayoutSubviews;

/**
 使用渐变导航栏,设置为true时导航栏渐变
 Whether to enable gradColor navigation bar.
 */
@property (nonatomic, assign) BOOL gradBarColorEnabled;

/**
 渐变高度,默认屏幕宽的一半
 The height of the gradient. Default to half of the screen width.
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 在scrollViewDidScroll:方法中调用此方法实现导航栏渐变
 used in scrollViewDidScroll: method
 
 @param currentPoint scrollView.contentOffset.
 */
- (void)updateNavBarAlpha:(CGPoint)currentPoint;

@end
