//
//  FCUserAccount.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//  用户账户信息（官方账户）

#import <Foundation/Foundation.h>

@interface FCUserAccount : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *frozenAmount;
@property (nonatomic, strong) NSString *currency;

+ (instancetype)sharedInstance;
- (void)setAccountInfo:(NSDictionary *)accountInfo;
@end
