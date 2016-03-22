//
//  JCTabbar.h
//  TabbarDemo
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JCTabbar;

#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议

@protocol JCTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(JCTabbar *)tabBar;

@end

@interface JCTabbar : UITabBar

@property (nonatomic, weak) id<JCTabBarDelegate> delegate;

@end
