//
//  FCDataManager.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCDataManager.h"

@implementation FCDataManager
+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)removeDataByKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}
- (id)dataByKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
   return  [userDefault dataForKey:key];
    
}
- (void)setData:(id)data key:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:key];
    [userDefault synchronize];
}
@end
