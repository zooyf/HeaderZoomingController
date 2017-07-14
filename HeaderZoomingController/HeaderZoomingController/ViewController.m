//
//  ViewController.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/11.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "ViewController.h"
#import "YFBaseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[YFBaseViewController class]]) {
        YFBaseViewController *baseVC = (YFBaseViewController *)segue.destinationViewController;
        baseVC.title = @"Hello YF";
        baseVC.headerHeight = 300;
    }
    
}

@end
