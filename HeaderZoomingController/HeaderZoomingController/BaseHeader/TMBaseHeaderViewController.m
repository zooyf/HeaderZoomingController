//
//  TMBaseHeaderViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/11.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "TMBaseHeaderViewController.h"
#import "Masonry.h"
#import "YFNavView.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface TMBaseHeaderViewController () <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, assign) CGFloat naviBarAlpha;
@property (nonatomic, assign) CGFloat barRenderValue;

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView        *containerView;
@property (nonatomic, weak) YFNavView *navView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL finishLayout;

@end

@implementation TMBaseHeaderViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
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

- (YFNavView *)navView {
    if (nil == _navView) {
        YFNavView *naviBarView = [[YFNavView alloc] init];
        _navView = naviBarView;
        [self.view addSubview:naviBarView];
        [naviBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.view);
            make.height.equalTo(@(64));
        }];
    }
    return _navView;
}

- (CGFloat)imageHeight {
    return _imageHeight ? : ScreenWidth/2.0;
}


#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initScrollView];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.finishLayout) {
        self.finishLayout = YES;
    }
}

- (void)initNavigationBar {
    self.finishLayout = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = self.titleLabel;
    self.barRenderValue = 1;
}

- (void)initScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(-64);
    }];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
//    [scrollView.panGestureRecognizer addTarget:self action:@selector(<#selector#>)];
    
    UIView *containerView = [UIView new];
    self.containerView = containerView;
    [containerView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.equalTo(@(ScreenHeight + self.imageHeight));
    }];
    
    [scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(containerView);
        make.height.equalTo(@(self.imageHeight));
    }];
    [self.imageView setImage:[UIImage imageNamed:@"test"]];
    self.imageView.clipsToBounds = YES;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];

}

- (void)headerImageZoomingWithOffset:(CGPoint)movePoint {
    if (!self.finishLayout) {
        return;
    }
    
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat delta = _imageView.frame.size.height - movePoint.y - 64;
        NSLog(@"delta: %.2f", delta);
        if (delta <= self.imageHeight) {
            delta = self.imageHeight;
        }
        make.height.mas_equalTo(delta);
    }];
    
    CGFloat maxValue = self.imageHeight;
    CGFloat minValue = 64;
    CGFloat ratio = (_imageView.frame.size.height - 64) / (maxValue - minValue);
    
    if (_imageView.frame.size.height<self.imageHeight) {
        self.naviBarAlpha =  1 - ratio;
        self.barRenderValue = ratio;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = scrollView.contentOffset;
    NSLog(@"%.2f", scrollView.contentOffset.y);
    [self headerImageZoomingWithOffset:movePoint];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.imageHeight);
        CGFloat delta = _imageView.frame.size.height + scrollView.contentOffset.y;
        if (delta<=self.imageHeight) {
//            make.height.mas_equalTo(self.imageHeight);
        }else {
//            make.height.mas_equalTo(self.imageHeight);
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:_barRenderValue alpha:0]}];
            self.naviBarAlpha =  0;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
