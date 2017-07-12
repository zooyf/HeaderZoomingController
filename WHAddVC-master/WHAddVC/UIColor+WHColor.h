//
//  UIColor+WHColor.h
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/27.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import <UIKit/UIKit.h>

@interface UIColor (WHColor)

/**
 * 使用16进制数字创建颜色
 * http://www.jianshu.com/p/c935314b078e
 */
+ (instancetype)wh_colorWithHex:(uint32_t)hex;

/**
 * 十六进制字符串显示颜色
 * http://www.jianshu.com/p/c935314b078e
 */
+ (UIColor *)wh_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
