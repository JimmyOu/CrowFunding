//
//  NSDate+FCDateToString.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/5.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FCDateToString)
/// Convert date to friendly description.
+ (NSString *)stringWithTimelineDate:(NSDate *)date;
+ (NSString *)stringWithTimelineString:(NSString *)string;
@end
