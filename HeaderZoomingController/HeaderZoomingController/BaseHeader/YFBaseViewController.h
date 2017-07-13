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

@property (nonatomic, assign) CGFloat naviBarAlpha;
@property (nonatomic, assign) CGFloat barRenderValue;

/**
 顶部图片大小,默认200
 */
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, weak) YFNavView *navView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateNavBarAlpha:(CGPoint)currentPoint;

@end
