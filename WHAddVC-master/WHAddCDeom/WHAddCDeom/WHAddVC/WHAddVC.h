//
//  WHAddVC.h
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import <UIKit/UIKit.h>

@interface WHAddVC : UIViewController

/**
 快速创建WHAddVC

 @param title 导航栏标题
 @param topImage 顶部图片
 @param chooseTitles 中间三个按钮的文字(字符串数组)
 @param chooseControllers 三个控制器名字(字符串数组)
 @return WHAddVC
 */
+ (WHAddVC *)addVCWithTitle:(NSString *)title topImage:(UIImage *)topImage chooseTitles:(NSArray *)chooseTitles chooseControllers:(NSArray *)chooseControllers;


/** 顶部图片模糊效果,YES模糊,NO不模糊,默认不模糊 */
@property (nonatomic, assign) BOOL blur;

@end
