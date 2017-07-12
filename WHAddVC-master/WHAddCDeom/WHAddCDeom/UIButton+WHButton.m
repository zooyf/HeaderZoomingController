//
//  UIButton+WHButton.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import "UIButton+WHButton.h"

@implementation UIButton (WHButton)

+(instancetype)wh_buttonWithTitle:(NSString *)title backColor:(UIColor *)backColor backImageName:(NSString *)backImageName titleColor:(UIColor *)color fontSize:(int)fontSize frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button sizeToFit];
    button.frame=frame;
    button.layer.cornerRadius=cornerRadius;
    button.clipsToBounds=YES;
    return button;
}

@end
