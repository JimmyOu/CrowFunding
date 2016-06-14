//
//  UIView+FCGesture.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/8.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "UIView+FCGesture.h"
#import <objc/runtime.h>
static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;
@implementation UIView (FCGesture)
#pragma mark - 点击及长按事件
- (void)clicked:(nonnull void(^)(UIView *view))clicked
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        if ([self isMemberOfClass:[UILabel class]] || [self isMemberOfClass:[UIImageView class]]) {
            self.userInteractionEnabled = YES;
        }
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, clicked, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(UIView *) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action) {
            action(self);
        }
    }
}

- (void)longPressed:(nonnull void(^)(UIView *view))longPressed;
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        if ([self isMemberOfClass:[UILabel class]] || [self isMemberOfClass:[UIImageView class]]) {
            self.userInteractionEnabled = YES;
        }
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, longPressed, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void(^action)(UIView *) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        if (action) {
            action(self);
        }
    }
}

@end
