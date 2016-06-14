//
//  FCUserInfoPM.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//  个人信息(官方账户)

#import <Foundation/Foundation.h>
extern NSString *const kUserInfoName;
extern NSString *const kUserInfoPassword;

@interface FCUserInfoPM : NSObject

@property (nonatomic, strong) NSString *tokenId;                          //用户Token
@property (nonatomic, strong) NSString *userId;                           //用户ID

//个人标示
@property (nonatomic, assign,getter = isLogin) BOOL login;
@property (nonatomic, strong) NSString *loginName;                        //登录用户名
@property (nonatomic, strong) NSString *photo;                            //头像
@property (nonatomic, strong) NSString *loginPwd;                         //登录密码
@property (nonatomic, strong) NSString *status;                           //状态
@property (nonatomic, assign) BOOL mobileFlag;                            //手机标识符
@property (nonatomic, assign) BOOL identityFlag;                          //实名认证标识符
@property (nonatomic, assign) BOOL tradepwdFlag;                          //交易密码标示符
@property (nonatomic, assign) BOOL bankcardFlag;                          //绑定银行卡标示符


@property (nonatomic, assign) BOOL needRequiredInfo;

+ (instancetype)sharedInstance;

/**
 *  @desc   清除用户所有数据
 */
- (void)emptyAllUserData;
- (void)setUserInfo:(NSDictionary *)userInfo;
@end
