//
//  ThirdViewController.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    
    imageView.frame = self.view.frame;
    
    [self.view addSubview:imageView];
}

@end
