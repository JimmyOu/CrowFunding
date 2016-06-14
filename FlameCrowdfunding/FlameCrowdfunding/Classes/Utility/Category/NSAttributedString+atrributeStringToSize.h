//
//  NSAttributedString+atrributeStringToSize.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/6.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (atrributeStringToSize)
- (CGSize )boundingRectWithSize:(CGSize )size;
@end
