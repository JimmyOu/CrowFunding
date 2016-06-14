//
//  FCHttpsManager.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
// 直接面向用户的接口


#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^RequestStartBlock)(void);
typedef void (^ResponsedBlock)(id _Nullable responseData);
typedef void (^RequestFailureBlock)(NSInteger status, NSString * _Nullable errMsg);

@interface FCHttpsManager : NSObject


+ (instancetype)shareHttpsManager;
/**
 *  获取token和uid
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态请求x成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)accountGetToken:(NSDictionary *)requestInfo
          startBlock:(RequestStartBlock)start
             sccuess:(void(^)(BOOL,NSString *))success
        failureBlock:(RequestFailureBlock)failure;
/**
 *  用户(请求详细信息)
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态登录成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)accountGetUserInfo:(NSDictionary *)requestInfo
          startBlock:(RequestStartBlock)start
             sccuess:(void (^)(BOOL, NSString * _Nonnull))success
        failureBlock:(RequestFailureBlock)failure;

/**
 *  用户(账户信息)
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态登录成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)accountGetAccountInfo:(NSDictionary *)requestInfo
                startBlock:(RequestStartBlock)start
                   sccuess:(void (^)(BOOL, NSString * _Nonnull))success
              failureBlock:(RequestFailureBlock)failure;

/**
 *  账户转账
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态登录成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)accountTransaction:(NSDictionary *)requestInfo
                   startBlock:(RequestStartBlock)start
                      sccuess:(void (^)(BOOL, NSString * _Nonnull))success
                 failureBlock:(RequestFailureBlock)failure;

/**
 *  发送短信
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态登录成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)sendSMS:(NSDictionary *)requestInfo
                startBlock:(RequestStartBlock)start
                   sccuess:(void (^)(BOOL, NSString * _Nonnull))success
              failureBlock:(RequestFailureBlock)failure;

/**
 *  发送短信
 *
 *  @param requestInfo  请求参数对象
 *  @param start        开始Block回调
 *  @param success      得到返回的Block回调, BOOL状态登录成功为YES，失败为NO；失败对应会有相关错误文案，成功文案为nil
 *  @param failed       失败Block回调, 带错误文案
 */
- (void)requestFundingItems:(NSDictionary *)requestInfo
     startBlock:(RequestStartBlock)start
        sccuess:(void (^)(BOOL, NSString * _Nonnull))success
   failureBlock:(RequestFailureBlock)failure;

@end
NS_ASSUME_NONNULL_END