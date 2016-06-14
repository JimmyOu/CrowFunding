//
//  FCFundingItems.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCFundingItems.h"
#import "NSObject+YYModel.h"
@implementation FCFundingItems
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"stories" : [FCFundingItem class] };
}
@end

@implementation FCFundingItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"comments" : [FCComment class] };
}
@end

@implementation FCComment

@end
