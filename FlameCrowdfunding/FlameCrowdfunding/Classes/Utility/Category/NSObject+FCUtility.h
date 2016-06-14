//
//  NSObject+FCUtility.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FCUtility)
//用于参数容错校验
- (BOOL)isNotEmpty;
- (BOOL)isEmpty;
@end
