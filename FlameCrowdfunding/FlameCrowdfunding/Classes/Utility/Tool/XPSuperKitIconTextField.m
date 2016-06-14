//
//  XPSuperKitIconTextField.m
//  自定义带图标的文本框
//  XPSuperKit
//
//  Created by 徐鹏 on 14/5/17.
//  Copyright (c) 2014年 blues(QQ:18390160) All rights reserved.
//

#import "XPSuperKitIconTextField.h"
#define kLeftPadding 0
#define kVerticalPadding 12
#define kHorizontalPadding 10

@interface XPSuperKitIconTextField (){
    XPSuperKitIconTextFieldType _type;
}

@end

@implementation XPSuperKitIconTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    UIEdgeInsets edge = [self edgeInsetsForType:_type];
    
    CGFloat x = bounds.origin.x + edge.left +kLeftPadding;
    CGFloat y = bounds.origin.y + kVerticalPadding;
    
    
    return CGRectMake(x,y,bounds.size.width - kHorizontalPadding*2, bounds.size.height - kVerticalPadding*2);
    
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)setupTextFieldWithIconName:(NSString *)name{
    [self setupTextFieldWithType:XPSuperKitIconTextFieldTypeDefault withIconName:name];
}
- (void)setupTextFieldWithType:(XPSuperKitIconTextFieldType)type withIconName:(NSString *)name{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    NSString *imageName = [self backgroundImageNameForType:type];
    CGRect imageViewFrame = [self iconImageViewRectForType:type];
    _type = type;
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:edge];
    
    [self setBackground:image];
    
    UIImage *icon = [UIImage imageNamed:name];
    
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    [iconImage setContentMode:UIViewContentModeCenter];
    self.leftView = iconImage;
    self.leftViewMode = UITextFieldViewModeAlways;

    [self setNeedsDisplay];
}
- (CGRect)iconImageViewRectForType:(XPSuperKitIconTextFieldType) type{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    if (type == XPSuperKitIconTextFieldTypeRound) {
        return CGRectMake(0, 0, edge.left*2, self.frame.size.height);
    }
    
    return CGRectMake(0, 0, edge.left, self.frame.size.height);
}
- (UIEdgeInsets)edgeInsetsForType:(XPSuperKitIconTextFieldType) type{
    if (type == XPSuperKitIconTextFieldTypeRound) {
        return UIEdgeInsetsMake(13, 13, 13, 13);
    }
    
    return UIEdgeInsetsMake(10, 43, 10, 19);
}

- (NSString *)backgroundImageNameForType:(XPSuperKitIconTextFieldType) type{
    if (type == XPSuperKitIconTextFieldTypeRound) {
        return @"round_textfield";
    }
    
    return @"text_field";
}

@end
