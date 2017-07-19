//
//  YFBaseViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/13.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "YFBaseViewController.h"
#import "YFNavView.h"
#import "Masonry.h"

@interface YFBaseViewController ()
@property (nonatomic, assign) BOOL finishLayoutSubviews;

@property (nonatomic, weak) YFNavView *navView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat naviBarAlpha;
@property (nonatomic, assign) CGFloat barRenderValue;

@end

@implementation YFBaseViewController

#pragma mark getters
- (CGFloat)headerHeight {
    if (!_headerHeight) {
        _headerHeight = 200;
    }
    return _headerHeight;
}

- (YFNavView *)navView {
    if (nil == _navView) {
        CGFloat naviBarY = self.edgesForExtendedLayout != UIRectEdgeNone ? 0 : -64;
        YFNavView *naviBarView = [YFNavView new];
        _navView = naviBarView;
        _navView.alpha = 0;
        [self.view addSubview:naviBarView];
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).with.offset(naviBarY);
            make.height.equalTo(@(64));
        }];
    }
    return _navView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        titleLabel.hidden = YES;
        titleLabel.text = self.title;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

#pragma mark setters
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    self.navigationItem.title = title;
}

- (void)setNaviBarAlpha:(CGFloat)naviBarAlpha {
    _naviBarAlpha = naviBarAlpha;
    self.navView.alpha = naviBarAlpha;
}

- (void)setBarRenderValue:(CGFloat)barRenderValue {
    _barRenderValue = barRenderValue;
    
    // calculate the renderColor
    UIColor *renderColor = [UIColor colorWithWhite:barRenderValue alpha:1];
    
    // apply the renderColor
    [self.navigationController.navigationBar setTintColor:renderColor];
    self.titleLabel.alpha = 1 - _barRenderValue;
    self.titleLabel.textColor = renderColor;
}

#pragma mark core method to calculate and apply the alpha
- (void)updateNavBarAlpha:(CGPoint)currentPoint {
    if (!self.finishLayoutSubviews || !self.gradBarColorEnabled) {
        return;
    }
    
    CGFloat ratio = currentPoint.y / (self.headerHeight - 64);
    if (currentPoint.y<self.headerHeight) {
        self.naviBarAlpha = ratio;
        self.barRenderValue = 1 - ratio;
    }
    
    self.titleLabel.hidden = ratio < 0.25;
    NSLog(@"%.2f", currentPoint.y);
    NSLog(@"ratio:%.2f", ratio);
}

- (void)setInit {
    if (self.gradBarColorEnabled) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        self.navigationItem.titleView = self.titleLabel;
        
        self.barRenderValue = 1;
        
    } else {
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)setGradBarColorEnabled:(BOOL)gradBarColorEnabled {
    _gradBarColorEnabled = gradBarColorEnabled;
    if (gradBarColorEnabled) {
        [self setInit];
    }
}

#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.finishLayoutSubviews = NO;
    
    [self setInit];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:self.gradBarColorEnabled];
    self.naviBarAlpha = self.naviBarAlpha;
    self.barRenderValue = self.barRenderValue;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.titleView.alpha = self.naviBarAlpha;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.finishLayoutSubviews = YES;
}

@end
