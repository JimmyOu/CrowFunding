//
//  AppDelegate.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/5.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//
//test FCPublicVC
#import "FCPublicVC.h"
#import "FCSearchVC.h"

#import "AppDelegate.h"
#import "FCTabBarController.h"
#import "FCKaiStartHttpManager.h"
@interface AppDelegate ()
@property (nonatomic, strong) FCTabBarController *tabBarVC;
@property (nonatomic, strong) UIImageView *advImage;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //tabBarVC 初始化
    _tabBarVC = [FCTabBarController sharedInstance];
    
    //test FCPublicVC
//    FCPublicVC *public = [[FCPublicVC alloc] init];
//    FCSearchVC *search = [[FCSearchVC alloc] init];
    self.window.rootViewController = _tabBarVC;
    [self.window makeKeyAndVisible];
    
    //testAPI
//    NSDictionary *userInfo = @{@"pid":@"330B05F4992551E2E050840AF2423F1E"};
//    [[FCKaiStartHttpManager sharedInstance] getDetailCommentsWithUserInfo:userInfo SuccessBlock:NULL failureBlock:NULL];
//    NSDictionary *userInfo = @{@"id":@"346C9CD59366A7C6E050190AFD0102E8"};
//    [[FCKaiStartHttpManager sharedInstance] getSupportWithUserInfo:userInfo SuccessBlock:NULL failureBlock:NULL];
    
    //广告页
    [self initAdvView];

    return YES;
}

- (void)initAdvView {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //如果存在广告页
    BOOL existImag = [fileManager fileExistsAtPath:filePath];
    if (existImag) {
//        DebugLog(@"已存在启动图片");
        //存在image
        _advImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_advImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        [self.window addSubview:_advImage];
        [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           //加载启动广告保存本地沙盒
            [self getLoadingImage];
        });
    } else {
//        DebugLog(@"不存在启动图片");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getLoadingImage];
        });
    }
    
}
- (void)getLoadingImage {
    [[FCKaiStartHttpManager sharedInstance] getAdvImage];
}
- (void)removeAdvImage {
    [UIView animateWithDuration:0.3f animations:^{
        _advImage.transform = CGAffineTransformMakeScale(0.3, 0.3);
        _advImage.alpha = 0;
    } completion:^(BOOL finished) {
        [_advImage removeFromSuperview];
    }];
}

@end
