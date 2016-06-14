//
//  NSString+FCDevideString.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "NSString+FCDevideString.h"

@implementation NSString (FCDevideString)
- (NSArray<NSString *> *)devideStringWithString:(NSString *)devide {
    return [self componentsSeparatedByString:devide];
}
@end
