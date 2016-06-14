//
//  UIView+FCGesture.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/8.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FCGesture)
#pragma mark - 点击及长按事件
- (void)clicked:(nonnull void(^)( UIView * _Nullable view))clicked;
- (void)longPressed:(nonnull void(^)( UIView * _Nullable view))longPressed;
@end
