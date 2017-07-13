//
//  TestViewController.m
//  WHAddCDeom
//
//  Created by 于帆 on 2017/7/7.
//  Copyright © 2017年 wuhao. All rights reserved.
//

#import "TestViewController.h"
#import "Masonry.h"
#import "WHNavView.h"

@interface TestViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, assign) CGFloat naviBarAlpha;
@property (nonatomic, assign) CGFloat barRenderValue;

@property (nonatomic, weak) WHNavView *navView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TestViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInit];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    [self.imageView setImage:[UIImage imageNamed:@"test"]];
    self.imageView.clipsToBounds = YES;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self addPanGesture];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.titleView.alpha = self.naviBarAlpha;
    self.navigationItem.titleView.hidden = NO;
}

- (void)setInit {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = self.titleLabel;
    self.barRenderValue = 1;
}

- (void)addPanGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topImagePanAction:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)topImagePanAction:(UIPanGestureRecognizer *)pan {
    CGPoint movePoint = [pan translationInView:pan.view];
    [pan setTranslation:CGPointZero inView:pan.view];
    
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat delta = _imageView.frame.size.height + movePoint.y;
        if (delta <= 64) {
            delta = 64;
        }
        make.height.mas_equalTo(delta);
    }];
    
    CGFloat maxValue = 200;
    CGFloat minValue = 64;
    CGFloat ratio = (_imageView.frame.size.height - 64) / (maxValue - minValue);
    
    if (_imageView.frame.size.height<200) {
        self.naviBarAlpha =  1 - ratio;
        self.barRenderValue = ratio;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat delta = _imageView.frame.size.height + movePoint.y;
            if (delta<=200) {
                make.height.mas_equalTo(delta);
            }else {
                make.height.mas_equalTo(200);
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:_barRenderValue alpha:0]}];
                self.naviBarAlpha =  0;
            }
        }];
    }
}

- (void)setNaviBarAlpha:(CGFloat)naviBarAlpha {
    _naviBarAlpha = naviBarAlpha;
    self.navView.alpha = naviBarAlpha;
}

- (void)setBarRenderValue:(CGFloat)barRenderValue {
    _barRenderValue = barRenderValue;
    barRenderValue += 0.3;
    UIColor *renderColor = [UIColor colorWithWhite:barRenderValue alpha:1];
    [self.navigationController.navigationBar setTintColor:renderColor];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.alpha = 1 - _barRenderValue;
    titleLabel.textColor = renderColor;
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

- (WHNavView *)navView {
    if (nil == _navView) {
        WHNavView *naviBarView = [[WHNavView alloc] init];
        _navView = naviBarView;
        [self.view addSubview:naviBarView];
        [naviBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.view);
            make.height.equalTo(@(64));
        }];
    }
    return _navView;
}

@end
