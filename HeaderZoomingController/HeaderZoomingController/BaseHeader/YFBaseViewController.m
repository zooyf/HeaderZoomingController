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

@interface YFBaseViewController () <UIGestureRecognizerDelegate>
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
        _headerHeight = ScreenWidth/2.0;
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
        titleLabel.text = self.title;
        titleLabel.font = [UIFont systemFontOfSize:15];
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
    
    [self setNaviBarAlpha:1 - barRenderValue];
    
    // calculate the renderColor
    UIColor *renderColor = [UIColor colorWithWhite:barRenderValue alpha:1];
    
    // apply the renderColor
    [self.navigationController.navigationBar setTintColor:renderColor];
    self.titleLabel.alpha = 1 - _barRenderValue;
    self.titleLabel.textColor = renderColor;
}

- (void)setGradBarColorEnabled:(BOOL)gradBarColorEnabled {
    _gradBarColorEnabled = gradBarColorEnabled;
    if (gradBarColorEnabled) {
        self.navigationItem.titleView = self.titleLabel;
    }
}

#pragma mark core method to calculate and apply the alpha
- (void)updateNavBarAlpha:(CGPoint)currentPoint {
    if (!self.finishLayoutSubviews || !self.gradBarColorEnabled) {
        return;
    }
    
    CGFloat ratio = currentPoint.y / (self.headerHeight - 64);
    if (currentPoint.y<self.headerHeight) {
        [self setBarRenderValue:1 - ratio];
    }
    
    self.titleLabel.hidden = ratio < 0.25;
    NSLog(@"%.2f", currentPoint.y);
    NSLog(@"ratio:%.2f", ratio);
}

- (void)setInit {
    
    // 单机键盘消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    if (![self isRootViewController]) {
        // 当前控制器不是navigation.rootViewController
        // 添加返回按钮
        // 允许右划返回
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    } else if (self.showBackBtn) {
        // 是根视控制器 并且要显示返回按钮(应该为present出的控制器)
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    
    self.finishLayoutSubviews = NO;
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark other
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)isRootViewController {
    // 判断当前控制器是否是根控制器
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *rootViewController = viewControllers.firstObject;
    
    return self == rootViewController;
}

- (void)backAction {
    if ([self isRootViewController]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInit];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setBarRenderValue:self.barRenderValue];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.finishLayoutSubviews = YES;
    [self setBarRenderValue:self.gradBarColorEnabled ? (self.barRenderValue ? : 1) : 0];
}

@end
