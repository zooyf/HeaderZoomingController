//
//  SubViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/14.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL favor;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hello YF";
    self.headerHeight = 300;
    self.gradBarColorEnabled = YES;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_dianzan_n"] style:UIBarButtonItemStylePlain target:self action:@selector(favorAction:)];
    // Do any additional setup after loading the view.
}

- (void)favorAction:(UIBarButtonItem *)barButtonItem {
    _favor = !_favor;
    if (_favor) {
        [barButtonItem setTintColor:[UIColor redColor]];
        [barButtonItem setImage:[UIImage imageNamed:@"btn_dianzan_h"]];
    } else {
        [barButtonItem setTintColor:nil];
        [barButtonItem setImage:[UIImage imageNamed:@"btn_dianzan_n"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}

@end
