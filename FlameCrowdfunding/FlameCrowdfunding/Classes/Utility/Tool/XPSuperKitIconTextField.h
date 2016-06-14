//
//  XPSuperKitIconTextField.h
//  自定义带图标的文本框
//  XPSuperKit
//
//  Created by 徐鹏 on 14/5/17.
//  Copyright (c) 2014年 blues(QQ:18390160) All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    XPSuperKitIconTextFieldTypeDefault,
    XPSuperKitIconTextFieldTypeRound
}XPSuperKitIconTextFieldType;

@interface XPSuperKitIconTextField : UITextField

@end


@interface UITextField ()
- (void)setupTextFieldWithIconName:(NSString *)name;
- (void)setupTextFieldWithType:(XPSuperKitIconTextFieldType)type withIconName:(NSString *)name;
@end
