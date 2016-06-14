//
//  UIFont+CustomFonts.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/13.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "UIFont+CustomFonts.h"

@implementation UIFont (CustomFonts)
+ (UIFont *)appFontSize16 {
    return [UIFont systemFontOfSize:(isIPhone4 | isIPhone5) ? 13 : 16];
}

+ (UIFont *)appFontSize15 {
    return [UIFont systemFontOfSize:(isIPhone4 | isIPhone5) ? 12 : 15];
}

+ (UIFont *)appFontSize14 {
    return [UIFont systemFontOfSize:(isIPhone4 | isIPhone5) ? 12 : 14];
}

+ (UIFont *)appFontSize12 {
    return [UIFont systemFontOfSize:(isIPhone4 | isIPhone5) ? 10 : 12];
}
@end
