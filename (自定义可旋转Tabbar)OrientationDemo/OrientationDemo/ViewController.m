//
//  ViewController.m
//  OrientationDemo
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.myTabbarController.shouldHideTabbarWhenRotation = YES;
    appDelegate.myTabbarController.shouldHideNavigationWhenRotation = YES;

}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
