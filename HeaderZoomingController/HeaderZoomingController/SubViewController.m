//
//  SubViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/14.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()<UIScrollViewDelegate>

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}

@end
