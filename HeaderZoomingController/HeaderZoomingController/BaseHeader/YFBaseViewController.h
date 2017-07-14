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
 布局完成
 */
@property (nonatomic, readonly, assign) BOOL finishLayoutSubviews;

/**
 顶部图片大小,默认200
 */
@property (nonatomic, assign) CGFloat headerHeight;

- (void)updateNavBarAlpha:(CGPoint)currentPoint;

@end
