//
//  SubTableViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/14.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "SubTableViewController.h"

@interface SubTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SubTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
