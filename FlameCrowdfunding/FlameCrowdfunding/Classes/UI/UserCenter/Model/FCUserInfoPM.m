//
//  FCUserInfoPM.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCUserInfoPM.h"
#import "FCDataManager.h"
NSString *const kUserInfoName = @"loginName";
NSString *const kUserInfoPassword = @"loginPwd";
@implementation FCUserInfoPM

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAllInfo];
    }
    return self;
}
- (void)initAllInfo {
    _login = NO;
    _loginName = nil;
    _loginPwd = nil;
    _photo = nil;
    _tokenId = nil;
    _userId = nil;
    _needRequiredInfo = YES;
    _mobileFlag = NO;
    _identityFlag = NO;
    _tradepwdFlag = NO;
    _bankcardFlag = NO;
    
}

- (void)emptyAllUserData {
    [self initAllInfo];
    [[FCDataManager sharedInstance] removeDataByKey:kUserInfoName];
    [[FCDataManager sharedInstance] removeDataByKey:kUserInfoPassword];
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    [self setValuesForKeysWithDictionary:userInfo[@"data"]];

}


@end
