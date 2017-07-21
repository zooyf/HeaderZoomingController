//
//  SubViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/14.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "SubViewController.h"
#import "UIScrollView+PullBig.h"

@interface SubViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL favor;

@property (weak, nonatomic) IBOutlet UIView *floatView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/**
 可拉伸的视图
 view that scaled
 */
@property (nonatomic, strong) UIImageView *headerZoomingView;
/**
 跟随滑动不可拉伸的视图
 View that scrolls with dragging.
 */
@property (nonatomic, strong) UIView *headerView;

@end

@implementation SubViewController

#pragma mark getter
- (UIImageView *)headerZoomingView {
    if (!_headerZoomingView) {
        UIImageView *headerZoomingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.headerHeight)];
        headerZoomingView.image = [UIImage imageNamed:@"Flower"];
        [headerZoomingView setContentMode:UIViewContentModeScaleAspectFill];
        _headerZoomingView = headerZoomingView;
    }
    return _headerZoomingView;
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:self.headerZoomingView.bounds];
        UIView *content = [[UIView alloc] initWithFrame:CGRectMake(10, self.headerHeight - 50, 50, 30)];
        content.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:content];
        _headerView = headerView;
    }
    return _headerView;
}

#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hello YF";
    self.gradBarColorEnabled = YES;
    
    self.headerHeight = ScreenWidth/2;
    
    // UIScrollView+PullBig one line implementation.👍
    // Thanks to you520t. https://github.com/you520t/PullBig
    [self.scrollView setBigView:self.headerZoomingView withHeaderView:self.headerView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_favor_n"] style:UIBarButtonItemStylePlain target:self action:@selector(favorAction:)];
    
    // Do any additional setup after loading the view.
}

#pragma mark custom methods
- (void)favorAction:(UIBarButtonItem *)barButtonItem {
    _favor = !_favor;
    if (_favor) {
        [barButtonItem setTintColor:[UIColor redColor]];
        [barButtonItem setImage:[UIImage imageNamed:@"btn_favor_h"]];
    } else {
        [barButtonItem setTintColor:nil];
        [barButtonItem setImage:[UIImage imageNamed:@"btn_favor_n"]];
    }
}

#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint fixedPosition = scrollView.contentOffset;
    fixedPosition.y += self.headerHeight;
    [self updateNavBarAlpha:fixedPosition];
    
    // floating view
    if (fixedPosition.y >= self.headerHeight - 64) {
        if (self.floatView.hidden) {
            self.floatView.hidden = NO;
        }
    } else {
        if (!self.floatView.hidden) {
            self.floatView.hidden = YES;
        }
    }
}

@end
