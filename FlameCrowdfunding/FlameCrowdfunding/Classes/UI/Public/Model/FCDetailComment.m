//
//  FCDetailComment.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCDetailComment.h"

@implementation FCDetailComment
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"childs" : [FCChildComment class] };
}
@end
@implementation FCChildComment

@end