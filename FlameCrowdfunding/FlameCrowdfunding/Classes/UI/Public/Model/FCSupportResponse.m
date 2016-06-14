//
//  FCSupportResponse.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCSupportResponse.h"
#import "NSObject+YYModel.h"

@implementation FCSupportProgress
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"notice" : [FCNotice class],
              @"support_items" : [FCService class]};
}
@end

@implementation FCNotice


@end
@implementation FCService



@end
