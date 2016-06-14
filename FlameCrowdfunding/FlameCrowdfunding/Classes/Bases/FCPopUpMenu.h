//
//  FCPopUpMenu.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FCPopUpMenu : UIControl
@property (nonatomic, copy) void(^SelectedEndBlock)(NSInteger);

- (id) initWithFrame:(CGRect)frame
           direction:(CGFloat)directionInRadians
           iconArray:(NSArray *)icons;
@end
