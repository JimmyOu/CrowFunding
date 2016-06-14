//
//  FCDataManager.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/11.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCDataMacro.h"
@interface FCDataManager : NSObject
+ (instancetype)sharedInstance;
- (void)removeDataByKey:(NSString *)key;
- (id)dataByKey:(NSString *)key;
- (void)setData:(id )data key:(NSString *)key;
@end
