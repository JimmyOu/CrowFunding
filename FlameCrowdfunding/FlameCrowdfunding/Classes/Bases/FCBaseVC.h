//
//  FCBaseVC.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface FCBaseVC : UIViewController

@property (nonatomic, strong) UIView *contentView;              //内容视图，这个用于所有内容的填写（根据屏幕状态自动适配覆盖区域）

#pragma mark - 堆栈处理
/**
 *  视图入栈
 *
 *  @param viewController 入栈视图, 同时支持字符串和class的方式
 *  @param animated       是否带过渡动画
 *  @return 返回进栈视图
 */
- (nullable FCBaseVC *)pushViewController:(FCBaseVC *)viewController animated:(BOOL)animated;
- (nullable FCBaseVC *)pushViewControllerClass:(Class)class animated:(BOOL)animated;
- (nullable FCBaseVC *)pushViewControllerString:(NSString *)class animated:(BOOL)animated;

/**
 *  返回到rootVC
 *
 *  @param animated 是否带过渡动画
 *
 *  @return 返回过程pop出来的controllers
 */
- (nullable NSArray<__kindof FCBaseVC *> *)popToRootViewControllerAnimated:(BOOL)animated;

/** 2015-12-10 14:22:34
 *  @desc   返回到某一个视图
 *
 *  @param  终点视图(同时支持string和class)
 *  @param  是否带过渡动画
 *  @return 返回跳过的视图队列
 */
- (nullable NSArray<__kindof FCBaseVC *> *)popToViewController:(FCBaseVC *)viewController animated:(BOOL)animated;
- (nullable NSArray<__kindof FCBaseVC *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated;
- (nullable NSArray<__kindof FCBaseVC *> *)popToViewControllerString:(NSString *)class animated:(BOOL)animated;

/** 2015-12-10 14:30:18
 *  @desc   返回上一级视图
 *
 *  @param  是否带过渡动画
 *  @return 返回出栈视图
 */
- (nullable FCBaseVC *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.

- (nullable FCBaseVC *)pushViewController:(FCBaseVC *)viewController animated:(BOOL)animated showTabBar:(BOOL)showtabBar;

#pragma mark - 进度指示条
- (void)showHUDWithProgress:(CGFloat)progress title:(NSString *)hudStr;
- (void)showHUDWithString:(NSString *)hudStr;
- (void)showHUD;
- (void)hideHUD;

@end
NS_ASSUME_NONNULL_END
