//
//  NSAttributedString+atrributeStringToSize.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/6.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "NSAttributedString+atrributeStringToSize.h"

@implementation NSAttributedString (atrributeStringToSize)
- (CGSize)boundingRectWithSize:(CGSize)size {
   return  [self boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine |
                                      NSStringDrawingUsesLineFragmentOrigin |
                                      NSStringDrawingUsesFontLeading
                              context:nil].size;
}
@end
