//
//  NSObject+FCUtility.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "NSObject+FCUtility.h"

@implementation NSObject (FCUtility)
- (BOOL)isNotEmpty {
    if (!self || [self isKindOfClass:[NSNull class]] ||
        ([self isKindOfClass:[NSString class]] && ([(id)self isEqualToString:@""] ||
                                                  [(id)self isEqualToString:@"(null)"] ||
                                                  [(NSString *)self length] < 1))) {
        return NO;
    }
    return YES;
    
}

- (BOOL)isEmpty {
    return ![self isNotEmpty];
}
@end
