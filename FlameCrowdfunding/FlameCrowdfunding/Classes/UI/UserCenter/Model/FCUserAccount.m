//
//  FCUserAccount.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCUserAccount.h"

@implementation FCUserAccount
+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)setAccountInfo:(NSDictionary *)accountInfo {
    [self setValuesForKeysWithDictionary:accountInfo];
}
@end
