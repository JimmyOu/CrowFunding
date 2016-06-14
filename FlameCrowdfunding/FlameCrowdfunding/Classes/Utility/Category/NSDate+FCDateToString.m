//
//  NSDate+FCDateToString.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/5.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "NSDate+FCDateToString.h"

@implementation NSDate (FCDateToString)
+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterFullDate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"M/d/yy"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // local time error
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60) {
        return [NSString stringWithFormat:@"%ds",(int)(delta)];
    } else if (delta < 60 * 60) {
        return [NSString stringWithFormat:@"%dm", (int)(delta / 60.0)];
    } else if (delta < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%dh", (int)(delta / 60.0 / 60.0)];
    } else if (delta < 60 * 60 * 24 * 7) {
        return [NSString stringWithFormat:@"%dd", (int)(delta / 60.0 / 60.0 / 24.0)];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}

+ (NSString *)stringWithTimelineString:(NSString *)string {
    if (!string) return @" ";
    return nil;
    
}
@end
