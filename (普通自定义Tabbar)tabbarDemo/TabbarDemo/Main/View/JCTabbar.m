//
//  JCTabbar.m
//  TabbarDemo
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "JCTabbar.h"
#import "UIView+Extension.h"

@interface JCTabbar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation JCTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        // 添加一个按钮到tabbar中
//        UIButton *plusBtn = [[UIButton alloc] init];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
//        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
//        plusBtn.size = plusBtn.currentBackgroundImage.size;
//        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:plusBtn];
//        self.plusBtn = plusBtn;
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
#warning [super layoutSubviews] 一定要调用
    [super layoutSubviews];
    
    if (!_plusBtn) {
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;

    }
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.1;
    self.plusBtn.centerY = self.height * 0.3;
    
    // 2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置宽度
            child.width = tabbarButtonW;
            // 设置x
            child.x = (tabbarButtonIndex + 1) * tabbarButtonW;
            
            // 增加索引
            tabbarButtonIndex++;
//            if (tabbarButtonIndex == 2) {
//                tabbarButtonIndex++;
//            }
        }
    }
}
@end
