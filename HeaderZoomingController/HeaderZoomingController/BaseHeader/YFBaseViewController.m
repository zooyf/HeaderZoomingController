//
//  YFBaseViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/13.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "YFBaseViewController.h"
#import "YFNavView.h"

@interface YFBaseViewController () <UIScrollViewDelegate>

@end

@implementation YFBaseViewController

- (CGFloat)headerHeight {
    if (!_headerHeight) {
        _headerHeight = 200;
    }
    return _headerHeight;
}

- (YFNavView *)navView {
    if (nil == _navView) {
        YFNavView *naviBarView = [[YFNavView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        _navView = naviBarView;
        [self.view addSubview:naviBarView];
    }
    return _navView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        titleLabel.text = @"TEST";
        titleLabel.hidden = YES;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)setNaviBarAlpha:(CGFloat)naviBarAlpha {
    _naviBarAlpha = naviBarAlpha;
    self.navView.alpha = naviBarAlpha;
}

- (void)setBarRenderValue:(CGFloat)barRenderValue {
    _barRenderValue = barRenderValue;
    UIColor *renderColor = [UIColor colorWithWhite:barRenderValue alpha:1];
    [self.navigationController.navigationBar setTintColor:renderColor];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.alpha = 1 - _barRenderValue;
    titleLabel.textColor = renderColor;
}

- (void)updateNavBarAlpha:(CGPoint)currentPoint {
    
    CGFloat ratio = -(currentPoint.y - 64) / (self.headerHeight - 64);
    
    if (currentPoint.y<self.headerHeight) {
        self.naviBarAlpha =  1 - ratio;
        self.barRenderValue = ratio;
    }
}

- (void)setInit {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = self.titleLabel;
    self.barRenderValue = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInit];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.titleView.alpha = self.naviBarAlpha;
    self.navigationItem.titleView.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}

@end
