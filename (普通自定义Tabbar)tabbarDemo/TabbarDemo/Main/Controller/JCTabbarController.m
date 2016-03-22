//
//  JCTabbarController.m
//  course
//
//  Created by TsoiKaShing on 15/11/21.
//  Copyright © 2015年 Yes_3D. All rights reserved.
//

#import "JCTabbarController.h"
#import "JCNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "JCTabbar.h"

@interface JCTabbarController ()<JCTabBarDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) JCTabbarController *tabBarController;
@end
@implementation JCTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // 1.初始化子控制器
    FirstViewController *home = [[FirstViewController alloc] init];
    [self addChildVc:home title:@"主页" image:@"state_5" selectedImage:@"state_5"];
    
    SecondViewController *list = [[SecondViewController alloc] init];
    [self addChildVc:list title:@"榜单" image:@"state_5" selectedImage:@"state_5"];
    
    ThirdViewController *mine = [[ThirdViewController alloc] init];
    [self addChildVc:mine title:@"我的" image:@"state_5" selectedImage:@"state_5"];
    
    FourViewController *device = [[FourViewController alloc] init];
    [self addChildVc:device title:@"设备" image:@"state_5" selectedImage:@"state_5"];
    
    JCTabbar *tabBar = [[JCTabbar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childVc.tabBarController.tabBar setBarTintColor:[UIColor redColor]];
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    if ([childVc isKindOfClass:[MessageViewController class]]) {
//        UITabBarItem * item = childVc.tabBarItem;
//        item.badgeValue=[NSString stringWithFormat:@"%d",3];
//    }
    
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = RGBA(240, 88, 112, 1);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    

    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    JCNavigationController *nav = [[JCNavigationController alloc] initWithRootViewController:childVc];
//    [nav.navigationBar setBarTintColor:NavgationBarColor];
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [nav.navigationBar setTitleTextAttributes:disableTextAttrs];
    
    // 添加为子控制器
    [self addChildViewController:nav];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = self.tabBarController;
}

-(void)tabBarDidClickPlusButton:(JCTabbar *)tabBar 
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showFromTabBar:tabBar];
}
@end
