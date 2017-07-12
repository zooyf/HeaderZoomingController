//
//  WHNavView.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import "WHNavView.h"

@implementation WHNavView

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
    
    [[UIColor whiteColor] set];
    
    [bezierPath fill];

    CGFloat onePX =  1 / [UIScreen mainScreen].scale;
    
    CGFloat lineY = rect.size.height - onePX;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint:CGPointMake(0, lineY)];
    
    [linePath addLineToPoint:CGPointMake(rect.size.width, lineY)];
    
    [[UIColor lightGrayColor] setStroke];
    
    [linePath stroke];
}


@end
