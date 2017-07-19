//
//  YFNavView.m
//  HeaderZoomingController
//
//  Created by 于帆 on 2017/7/11.
//  Copyright © 2017年 JasonYu. All rights reserved.
//

#import "YFNavView.h"

@implementation YFNavView

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
    
    [[UIColor whiteColor] set];
    
    [bezierPath fill];
    
    CGFloat onePX =  0.5 / [UIScreen mainScreen].scale;
    
    CGFloat lineY = rect.size.height - onePX;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    [linePath setLineWidth:0.3];
    
    [linePath moveToPoint:CGPointMake(0, lineY)];
    
    [linePath addLineToPoint:CGPointMake(rect.size.width, lineY)];
    
    [[UIColor lightGrayColor] setStroke];
    
    [linePath stroke];
}


@end
