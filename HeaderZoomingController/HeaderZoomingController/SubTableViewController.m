//
//  SubTableViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/14.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "SubTableViewController.h"
#import "UIScrollView+PullBig.h"

@interface SubTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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

@implementation SubTableViewController
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBigView:self.headerZoomingView withHeaderView:self.headerView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell%ld", indexPath.row];
    
    if (indexPath.row == 4) {
        cell.contentView.backgroundColor = [UIColor redColor];
    } else {
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavBarAlpha:scrollView.contentOffset];
}

@end
