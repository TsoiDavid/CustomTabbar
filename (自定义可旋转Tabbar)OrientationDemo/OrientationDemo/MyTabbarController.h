//
//  MyTabbarController.h
//  OrientationDemo
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabbarController : UITabBarController

@property (nonatomic, strong) UIView* myTabbar;
//是否在旋屏的时候隐藏tabbar
@property (nonatomic, assign) BOOL shouldHideTabbarWhenRotation;
@property (nonatomic, assign) BOOL shouldHideNavigationWhenRotation;
@end
