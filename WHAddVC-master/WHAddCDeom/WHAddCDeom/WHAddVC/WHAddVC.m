//
//  WHAddVC.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import "WHAddVC.h"
#import "UIColor+WHColor.h"
#import "UIImage+WHImage.h"
#import "WHNavView.h"
#import "WHChooseView.h"
#import "Masonry.h"

@interface WHAddVC () <UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) WHChooseView *chooseView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak)  UIScrollView *scrollView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) WHNavView *navView;
@property (nonatomic, assign) CGFloat naviBarAlpha;
@property (nonatomic, assign) CGFloat barRenderValue;
@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) NSArray *chooseControllers;

@end

@implementation WHAddVC

+ (WHAddVC *)addVCWithTitle:(NSString *)title topImage:(UIImage *)topImage chooseTitles:(NSArray *)chooseTitles chooseControllers:(NSArray *)chooseControllers {
    WHAddVC *addVC = [[WHAddVC alloc] init];
    addVC.topTitle = title;
    addVC.topImage = topImage;
    addVC.chooseControllers = chooseControllers;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chooseKey"];
    [[NSUserDefaults standardUserDefaults] setObject:chooseTitles forKey:@"chooseKey"];
    return addVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始设置
    [self setInit];
    
    // 顶部图片
    [self setupImageView];
    
//    // 选择控制器
//    [self setupChooseView];
//    
//    // ScrollView
//    [self setupScrollView];
//    
//    // 添加子控制器
//    [self addChildrenController];
    
    // 添加手势
    [self addPanGesture];
}

- (void)setInit {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.barRenderValue = 1;
    self.title = _topTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:0]}];
}

- (void)setupImageView {
    UIImage *topImage = [UIImage new];
    topImage = self.blur ? [_topImage blur] : _topImage;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:topImage];
    _imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}

- (void)setupChooseView {
    WHChooseView *chooseView = [[WHChooseView alloc] init];
    _chooseView = chooseView;
    chooseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chooseView];
    
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    __weak typeof(self) weakSelf = self;
    chooseView.chooseBlock = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(index *weakSelf.scrollView.frame.size.width, 0) animated:YES];
    };
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc ] init];
    _scrollView = scrollView;
    _scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    UIView *containerView = [[UIView alloc] init];
    _containerView = containerView;
    containerView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView).multipliedBy(3);
        make.height.equalTo(scrollView);
    }];
}


- (void)addChildrenController {
    
    Class First = NSClassFromString(_chooseControllers[0]);
    Class Second = NSClassFromString(_chooseControllers[1]);
    Class Third = NSClassFromString(_chooseControllers[2]);
    
    UIViewController *firstVC = [[First alloc] init];
    UIViewController *secondVC = [[Second alloc] init];
    UIViewController *thirdVC = [[Third alloc] init];
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    [self addChildViewController:thirdVC];
    
    [_containerView addSubview:firstVC.view];
    [_containerView addSubview:secondVC.view];
    [_containerView addSubview:thirdVC.view];
    
    [firstVC didMoveToParentViewController:self];
    [secondVC didMoveToParentViewController:self];
    [thirdVC didMoveToParentViewController:self];
    
    [firstVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(_containerView);
        make.width.equalTo(_scrollView);
        make.bottom.equalTo(self.view);
    }];
    
    [secondVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.leading.equalTo(firstVC.view.mas_trailing);
        make.size.equalTo(_scrollView);
    }];
    
    [thirdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.leading.equalTo(secondVC.view.mas_trailing);
        make.size.equalTo(_scrollView);
    }];
}

- (void)addPanGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x / 3;
        _chooseView.offsetX = offsetX;
    }
}

- (void)setNaviBarAlpha:(CGFloat)naviBarAlpha {
    _naviBarAlpha = naviBarAlpha;
    self.navView.alpha = naviBarAlpha;
}

- (void)setBarRenderValue:(CGFloat)barRenderValue {
    _barRenderValue = barRenderValue;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithWhite:barRenderValue alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:barRenderValue alpha:1]}];
}

- (WHNavView *)navView {
    if (nil == _navView) {
        WHNavView *naviBarView = [[WHNavView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        _navView = naviBarView;
        [self.view addSubview:naviBarView];
    }
    return _navView;
}

@end
