//
//  FCNavigationVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCNavigationVC.h"

@interface FCNavigationVC ()

@end

@implementation FCNavigationVC

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if (kIOSVersion >= 7.0) {
            self.navigationBar.barTintColor = [UIColor colorWithRed:0.925 green:0.459 blue:0.180 alpha:1];
        } else {
            self.navigationBar.tintColor = [UIColor colorWithRed:0.925 green:0.459 blue:0.180 alpha:1];
            
        UIView *statusV = [[UIView alloc] initWithFrame:(CGRect){0, -20, kScreenWidth, 20}];
        [statusV setBackgroundColor:[UIColor blackColor]];
        [self.navigationBar addSubview:statusV];
    }
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
        return UIStatusBarStyleLightContent;
    
}


@end
