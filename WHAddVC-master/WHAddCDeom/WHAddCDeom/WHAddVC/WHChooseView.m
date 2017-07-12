
//
//  WHChooseView.m
//  WHAddVCDeom
//  https://github.com/remember17/WHAddVC
//  Created by 吴浩 on 2017/6/26.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/187c53796a8a

#import "WHChooseView.h"
#import "Masonry.h"
#import "UIColor+WHColor.h"
#import "WHAddVC.h"

@interface WHChooseView()

@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;
@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *preButton;
@property (nonatomic, weak) UIView *singleLine;

@end

@implementation WHChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self setupButton];
    
    [self setupSingleLine];
    
    [self clickButton:_firstButton];
}

- (void)setupSingleLine {
    UIView *singleLine = [[UIView alloc] init];
    _singleLine = singleLine;
    singleLine.backgroundColor = [UIColor wh_colorWithHex:0xB63923];
    [self addSubview:singleLine];
    
    [singleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(_firstButton);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(5);
    }];
}

- (void)setupButton {
    NSArray *titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseKey"];
    int index = 0;
    for (NSString *title in titleArray) {
        UIButton *button = [self buttonWithTile:title];
        button.tag = index++;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    _firstButton = self.buttonArray[0];
    
    [self.buttonArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.equalTo(self);
    }];
    
    [self.buttonArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[0]);
        make.leading.equalTo(self.buttonArray[0].mas_trailing);
        make.size.equalTo(self.buttonArray[0]);
    }];
    
    [self.buttonArray[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonArray[1]);
        make.leading.equalTo(self.buttonArray[1].mas_trailing);
        make.size.equalTo(self.buttonArray[1]);
        make.trailing.equalTo(self);
    }];
    
    [self layoutIfNeeded];
}

- (void)clickButton:(UIButton *)button {
    _preButton.selected = NO;
    button.selected = YES;
    _preButton = button;
    
    [_singleLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_firstButton).offset(button.tag * _firstButton.frame.size.width);
    }];
    
    [UIView animateWithDuration:.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (_chooseBlock) {
        _chooseBlock(button.tag);
    }
}

- (UIButton *)buttonWithTile:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return button;
}

- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = offsetX;
    [_singleLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_firstButton).offset(offsetX);
    }];
    NSInteger index = offsetX / _firstButton.frame.size.width + 0.5;
    _preButton.selected = NO;
    self.buttonArray[index].selected = YES;
    _preButton = self.buttonArray[index];
}

- (NSMutableArray<UIButton *> *)buttonArray {
    if (nil == _buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
