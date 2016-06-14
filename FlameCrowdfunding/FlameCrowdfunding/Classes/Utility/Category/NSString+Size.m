//
//  NSString+Size.m
//  meituan
//
//  Created by jinzelu on 15/7/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    if (number <= 999) return [NSString stringWithFormat:@"%d",(int)number];
    if (number <= 9999) return [NSString stringWithFormat:@"%d,%3.3d",(int)(number / 1000), (int)(number % 1000)];
    if (number < 1000 * 1000) return [NSString stringWithFormat:@"%.1fK", number / 1000.0];
    if (number < 1000 * 1000 * 1000) return [NSString stringWithFormat:@"%.1fM", number / 1000.0 / 1000.0];
    return [NSString stringWithFormat:@"%.1fB", number / 1000.0 / 1000.0 / 1000.0];
}

@end
