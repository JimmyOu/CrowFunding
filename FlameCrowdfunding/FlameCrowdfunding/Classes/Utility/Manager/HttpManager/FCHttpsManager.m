//
//  FCHttpsManager.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCHttpsManager.h"
#import "FCHttpBaseService.h"
#import "FCUserInfoPM.h"
#import "FCDataManager.h"
#import "FCUserAccount.h"
#import "FCAccountTransaction.h"
#import "NSObject+YYModel.h"
#import "FCFundingItems.h"

static NSString *const kAccountGetTokenSDK = nil;
static NSString *const kAccountGetUserInfoSDK = nil;
static NSString *const kAccountGetUserAccountSDK = nil;
static NSString *const kAccountTransactionSDK = nil;
static NSString *const kUserMessageSDK = nil;
@implementation FCHttpsManager

+ (instancetype)shareHttpsManager {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)accountGetToken:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {
    [FCHttpBaseService asyncPost:kAccountGetTokenSDK
        postData:requestInfo startBlock:^{
        FCHandleBlock(start);
    } responsedBlock:^(NSDictionary *responseDic) {
        NSInteger errorCode = [[responseDic objectForKey:@"errorCode"] integerValue];
        if (errorCode != 0) {
            FCHandleBlock(success,NO,[responseDic objectForKey:@"errorInfo"]);
        }
        NSDictionary *userInfoDic = responseDic[@"data"];
        [FCUserInfoPM sharedInstance].userId = userInfoDic[@"userId"];
        [FCUserInfoPM sharedInstance].tokenId = userInfoDic[@"tokenId"];
        
        //将用户的密码账号保存本地
        [[FCDataManager sharedInstance] setData:requestInfo[@"loginName"] key:@"loginName"];
        [[FCDataManager sharedInstance] setData:requestInfo[@"loginPwd"] key:@"loginPwd"];
        
        // 成功的回调
        FCHandleBlock(success,YES,[responseDic objectForKey:@"errorInfo"]);
        
    } failuredBlock:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failure,status,errMsg);
    }];
}

- (void)accountGetUserInfo:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {
    [FCHttpBaseService asyncPost:kAccountGetUserInfoSDK postData:requestInfo startBlock:^{
        FCHandleBlock(start);
    } responsedBlock:^(NSDictionary *responseDic) {
        NSInteger errorCode = [[responseDic objectForKey:@"errorCode"] integerValue];
        if (errorCode != 0) {
            FCHandleBlock(success,NO,[responseDic objectForKey:@"errorInfo"]);
        }
        //更新用户数据信息
        [[FCUserInfoPM sharedInstance] setUserInfo:responseDic];
        //成功的回调
        FCHandleBlock(success,YES,[responseDic objectForKey:@"errorInfo"]);
    } failuredBlock:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failure,status,errMsg);
        
    }];
}

- (void)accountGetAccountInfo:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {
    [FCHttpBaseService asyncPost:kAccountGetUserAccountSDK postData:requestInfo startBlock:^{
        FCHandleBlock(start);
    } responsedBlock:^(NSDictionary *responseDic) {
        NSInteger errorCode = [[responseDic objectForKey:@"errorCode"] integerValue];
        if (errorCode != 0) {
            FCHandleBlock(success,NO,[responseDic objectForKey:@"errorInfo"]);
        }
        //设置账户信息
        [[FCUserAccount sharedInstance] setAccountInfo:responseDic];
        //成功的回调
        FCHandleBlock(success,YES,[responseDic objectForKey:@"errorInfo"]);
    } failuredBlock:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failure,status,errMsg);
    }];
}

- (void)accountTransaction:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {
    [FCHttpBaseService asyncPost:kAccountTransactionSDK postData:requestInfo startBlock:^{
        FCHandleBlock(start);
    } responsedBlock:^(NSDictionary *responseDic) {
        NSInteger errorCode = [[responseDic objectForKey:@"errorCode"] integerValue];
        if (errorCode != 0) {
            FCHandleBlock(success,NO,[responseDic objectForKey:@"errorInfo"]);
        }
    } failuredBlock:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failure,status,errMsg);
    }];
}

- (void)sendSMS:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {
    [FCHttpBaseService asyncPost:kUserMessageSDK postData:requestInfo startBlock:^{
        FCHandleBlock(start);
    } responsedBlock:^(NSDictionary *responseDic) {
        NSInteger errorCode = [[responseDic objectForKey:@"errorCode"] integerValue];
        if (errorCode != 0) {
            FCHandleBlock(success,NO,[responseDic objectForKey:@"errorInfo"]);
        }
    } failuredBlock:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failure,status,errMsg);
    }];

}

- (void)requestFundingItems:(NSDictionary *)requestInfo startBlock:(RequestStartBlock)start sccuess:(void (^)(BOOL, NSString * _Nonnull))success failureBlock:(RequestFailureBlock)failure {

}
@end
