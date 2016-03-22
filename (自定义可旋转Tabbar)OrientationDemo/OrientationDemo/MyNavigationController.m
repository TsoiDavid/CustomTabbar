//
//  MyNavigationController.m
//  OrientationDemo
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MyNavigationController.h"
#import "ViewController.h"
@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    if ([self.topViewController isKindOfClass:[ViewController class]]){
      return [self.topViewController shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.topViewController isKindOfClass:[ViewController class]]){
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if ([self.topViewController isKindOfClass:[ViewController class]]){
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
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
