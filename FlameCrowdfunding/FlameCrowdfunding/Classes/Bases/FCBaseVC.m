//
//  FCBaseVC.m
//  FlameCrowdfunding
//所有VC的一个基类
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCBaseVC.h"
#import "MBProgressHUD.h"
#import "FCTabBarController.h"
#import "FCPopUpMenu.h"

@interface FCBaseVC ()
@property (nonatomic, weak) MBProgressHUD *hud;
@end

@implementation FCBaseVC
- (void)viewDidLoad {
    [super viewDidLoad];
//    //关闭系统自动下移
    if (kIOSVersion >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    CGFloat offsetY = (kIOSVersion >= 7.0) ? 64 : 0;
    CGFloat offsetY = 0;

    _contentView = [[UIView alloc] initWithFrame:(CGRect){0, offsetY, self.view.width, self.view.height - offsetY}];
    [_contentView setBackgroundColor:[UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:1]];
    [self.view addSubview:_contentView];
}
#pragma mark - 视图堆栈相关方法
- (nullable FCBaseVC *)pushViewController:(FCBaseVC *)viewController animated:(BOOL)animated {
    if (self.navigationController) {
        FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
        popUp.hidden = YES;
        if ([[self.navigationController viewControllers] containsObject:viewController]) {
            [self popToViewController:viewController animated:animated];
        } else {
        [self.navigationController pushViewController:viewController animated:animated];
            }
        return viewController;
    } else {
        return nil;
    }
}

- (nullable FCBaseVC *)pushViewControllerClass:(Class)class animated:(BOOL)animated {
    return [self pushViewController:[[class alloc] init] animated:animated];
};

- (nullable FCBaseVC *)pushViewControllerString:(NSString *)class animated:(BOOL)animated {
    return [self pushViewControllerClass:NSClassFromString(class) animated:animated];
};

- (nullable NSArray<__kindof FCBaseVC *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.navigationController) {
        FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
        popUp.hidden = NO;
        return [self.navigationController popToRootViewControllerAnimated:animated];
    } else {
        return nil;
    }
}
- (nullable NSArray<__kindof FCBaseVC *> *)popToViewController:(FCBaseVC *)viewController animated:(BOOL)animated {
    if (self.navigationController) {
        if ([[self.navigationController viewControllers] containsObject:viewController]) {
            if (viewController == [self.navigationController viewControllers][0]) {
                FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
                popUp.hidden = NO;
            }
            return [self.navigationController popToViewController:viewController animated:animated];
        } else {
            NSAssert(NO, @"pop的VC不存在，请确保pop的VC已在堆栈中");
            return nil;
        }
    } else {
        return nil;
    }
}

- (nullable NSArray<__kindof FCBaseVC *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated {
    if (self.navigationController) {
        for (FCBaseVC *baseVC in [self.navigationController viewControllers]) {
            if ([baseVC isKindOfClass:class]) {
                if (baseVC == [self.navigationController viewControllers][0]) {
                    FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
                    popUp.hidden = NO;
                }
                return [self popToViewController:baseVC animated:animated];
            }
        }
        return nil;
    } else {
        return nil;
    }
}

- (nullable NSArray<__kindof FCBaseVC *> *)popToViewControllerString:(NSString *)class animated:(BOOL)animated {
    return [self popToViewControllerClass:NSClassFromString(class) animated:animated];
};

- (nullable FCBaseVC *)popViewControllerAnimated:(BOOL)animated {
    if (self.navigationController) {
        if ([self.navigationController viewControllers].count == 2) {
            FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
            popUp.hidden = NO;
        }
        return (FCBaseVC *)[self.navigationController popViewControllerAnimated:animated];
    } else {
        return nil;
    }
}
- (FCBaseVC *)pushViewController:(FCBaseVC *)viewController animated:(BOOL)animated showTabBar:(BOOL)showtabBar {
    if (self.navigationController) {
        FCPopUpMenu *popUp = [FCTabBarController sharedInstance].popUp;
        popUp.hidden = !showtabBar;
        if ([[self.navigationController viewControllers] containsObject:viewController]) {
            [self popToViewController:viewController animated:animated];
        } else {
            [self.navigationController pushViewController:viewController animated:animated];
        }
        return viewController;
    } else {
        return nil;
    }

}

#pragma mark - 进度指示条
- (void)showHUD {
    UIView *showingView = (self.navigationController.view)?self.navigationController.view:self.view;
    _hud = [MBProgressHUD showHUDAddedTo:showingView animated:YES];
}
- (void)hideHUD {
    if (_hud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [_hud hideAnimated:YES];
        });
    }
}
- (void)showHUDWithString:(NSString *)str {
    UIView *showingView = (self.navigationController.view)?self.navigationController.view:self.view;
    _hud = [MBProgressHUD showHUDAddedTo:showingView animated:YES];
    _hud.label.text = str?:@"Lording...";
}


- (void)showHUDWithProgress:(CGFloat)progress title:(NSString *)hudStr {
    UIView *showingView = (self.navigationController.view)?self.navigationController.view:self.view;
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:showingView animated:YES];
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.label.text = hudStr?:@"Lording...";
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        if(progress < 1){
        [MBProgressHUD HUDForView:showingView].progress = progress;
        }else{
         [[MBProgressHUD HUDForView:showingView] hideAnimated:YES];
        }
        
    });
}


@end
