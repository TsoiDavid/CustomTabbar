//
//  MyTabbarController.m
//  OrientationDemo
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 admin. All rights reserved.
//
#define iPhoneH self.view.frame.size.height
#define iPhoneW self.view.frame.size.width
#define TabbarH 49
#define RandomColor [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];
//特殊按钮在第几个按钮
#define SpecialButtonTag 0
//允许第几个控制器页面旋转
#define AllowRotationViewControllerIndex 0

#import "MyTabbarController.h"
#import "UIView+Extension.h"
#import "AppDelegate.h"

@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    [self createCustomTabbar];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.myTabbarController = self;
}
- (void)setShouldHideNavigationWhenRotation:(BOOL)shouldHideNavigationWhenRotation {
    
    _shouldHideNavigationWhenRotation = NO;
    
    if (shouldHideNavigationWhenRotation) _shouldHideNavigationWhenRotation = shouldHideNavigationWhenRotation;
}
- (void)setShouldHideTabbarWhenRotation:(BOOL)shouldHideTabbarWhenRotation {
    
    _shouldHideTabbarWhenRotation = NO;
    
    if (shouldHideTabbarWhenRotation) _shouldHideTabbarWhenRotation = shouldHideTabbarWhenRotation;
}
- (void)createCustomTabbar {
    
    _myTabbar = [[UIView alloc]init];
    _myTabbar.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_myTabbar];
 
    for (int i = 0; i < self.viewControllers.count + 1; i ++) {

    UIView *tabbarItem = [[UIView alloc]init];
    tabbarItem.backgroundColor = RandomColor;
    tabbarItem.tag = 100 + i;
    [_myTabbar addSubview:tabbarItem];
    
       if (i == SpecialButtonTag && SpecialButtonTag < self.viewControllers.count) {
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [tabbarItem addSubview:plusBtn];
        plusBtn.tag = 1000 + i;
       } else {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTabbarItem:)];
        [tabbarItem addGestureRecognizer:tap];
       }
    }
    
}

#pragma 点击事件
- (void)clickTabbarItem:(UITapGestureRecognizer *)tap {
    if (tap.view.tag != 0) {
        self.selectedIndex = tap.view.tag - 101;
    }
}
- (void)plusClick {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
//    [actionSheet showFromTabBar:tabBar];
    [actionSheet showFromTabBar:self.tabBar];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _myTabbar.frame = CGRectMake(0, iPhoneH - TabbarH, iPhoneW, TabbarH);
    
    //按钮宽度
    CGFloat tabbarItemW = iPhoneW/(self.viewControllers.count + 1);
    CGFloat tabbarItemH = TabbarH;
    for (int i = 0; i < self.viewControllers.count + 1; i ++) {
        
        UIView *tabbarItem = [self.view viewWithTag:100 + i];
        tabbarItem.frame = CGRectMake(i * tabbarItemW, 0, tabbarItemW, tabbarItemH);
        
        if (i == SpecialButtonTag && SpecialButtonTag < self.viewControllers.count) {
            // 添加一个按钮到tabbar中
            UIButton *plusBtn = (UIButton *)[self.view viewWithTag:1000 + i];
            plusBtn.frame = CGRectMake((tabbarItemW - plusBtn.width)/2, (tabbarItemH - plusBtn.height)/2, plusBtn.width, plusBtn.height);
        }
    }

    
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerNotification];
}
- (void)registerNotification {
    //注册旋转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    //移除旋转通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)orientChange:(NSNotification *)noti {
    
    if (self.selectedIndex == AllowRotationViewControllerIndex) {
        UINavigationController *currentNavigation = (UINavigationController *)self.selectedViewController;
        
        if (_shouldHideTabbarWhenRotation) {
            //旋转的时候把自定义tabbar隐藏
            if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
                self.myTabbar.hidden = NO;
                [currentNavigation setNavigationBarHidden:NO animated:YES];
            } else {
                self.myTabbar.hidden = YES;
                [currentNavigation setNavigationBarHidden:YES animated:YES];
            }
        } else {
            self.myTabbar.hidden = NO;
        }
    }
}
//旋屏设置
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
