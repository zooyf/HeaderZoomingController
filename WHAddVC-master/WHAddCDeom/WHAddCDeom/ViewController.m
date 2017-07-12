//
//  ViewController.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import "ViewController.h"
#import "UIButton+WHButton.h"
#import "WHAddVC.h"
#import "TestViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 快速创建button
    // http://www.jianshu.com/p/c935314b078e
    UIButton *button = [UIButton wh_buttonWithTitle:@"Enter" backColor:[UIColor blackColor] backImageName:nil titleColor:[UIColor whiteColor] fontSize:14 frame:CGRectMake(0, 0, 100, 50) cornerRadius:10];
    
    button.center = self.view.center;
    
    [self.view addSubview:button];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
}

-(void)test {

    // 一行代码创建WHAddVC
    WHAddVC *addVC = [WHAddVC addVCWithTitle:@"TEST" topImage:[UIImage imageNamed:@"test"] chooseTitles:@[@"One",@"Two",@"Three"] chooseControllers:@[@"FirstViewController",@"SecondViewController",@"ThirdViewController"]];
    
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)xxx {
    TestViewController *testVC;
    
}

@end
