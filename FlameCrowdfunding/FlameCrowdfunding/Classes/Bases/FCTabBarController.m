//
//  FCTabBarController.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCTabBarController.h"
#import "FCPopUpMenu.h"
#import "FCPublicVC.h"
#import "FCSearchVC.h"
#import "FCLoginVC.h"
#import "FCUserCenterVC.h"
#import "FCNavigationVC.h"
#import "FCNotificationVC.h"
#import "FCDataManager.h"
@interface FCTabBarController ()
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation FCTabBarController
+ (instancetype)sharedInstance {
    static  id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];

   

}
- (void)initialize {
    //移除系统的tabBar
    [self.tabBar removeFromSuperview];
    NSArray *icons = @[[UIImage imageNamed:@"home"],[UIImage imageNamed:@"find"],[UIImage imageNamed:@"message"],[UIImage imageNamed:@"mine"]];
    
    //添加自定义的动画menu
    _popUp = [[FCPopUpMenu alloc]initWithFrame:CGRectMake(0,kScreenHeight - 100, kScreenWidth, 100)
                                                 direction:M_PI
                                                 iconArray:icons];
//    _popUp.backgroundColor = [UIColor redColor];
    _popUp.backgroundColor = [UIColor clearColor];
    __weak __typeof(self)weakSelf = self;
    _popUp.SelectedEndBlock = ^(NSInteger index){
        weakSelf.selectedIndex = index;
    };
    [self.view addSubview:_popUp];
    
    //判断用户是否登陆了
//    BOOL login = [[FCDataManager sharedInstance] dataByKey:kIsLogin];
//    FCBaseVC *notificationVC = nil;
//    FCBaseVC *userCenterVC = nil;
//    if (login == NO) {
//        FCLoginVC *login1 = [[FCLoginVC alloc] init];
//        login1.toClass = @"NotificationVC";
//        notificationVC = login1;
//        
//        
//        FCLoginVC *login2 = [[FCLoginVC alloc] init];
//        login2.toClass = @"UserCenter";
//        userCenterVC = login2;
//    }else {
//        notificationVC = [FCNotificationVC new];
//        userCenterVC = [[FCUserCenterVC alloc] init];
//    
//    }
    //添加viewControllers
    FCPublicVC *publicVC = [[FCPublicVC alloc] init];
    FCSearchVC *searchVC = [[FCSearchVC alloc] init];
//    FCLoginVC *loginVC = [[FCLoginVC alloc] init];
  FCNotificationVC  *notificationVC = [FCNotificationVC new];
   FCUserCenterVC *userCenterVC = [[FCUserCenterVC alloc] init];
    [self addChildViewControllers:@[publicVC,searchVC,notificationVC,userCenterVC]];
    
}
- (void)addChildViewControllers:(NSArray *)rootVCs {
    NSMutableArray *mul_navis = [NSMutableArray arrayWithCapacity:4];
    for (UIViewController *vc in rootVCs) {
        FCNavigationVC *baseNavi = [[FCNavigationVC alloc] initWithRootViewController:vc];
        [mul_navis addObject:baseNavi];
    }
    self.viewControllers = mul_navis;
}
#pragma mark - animation
@end
