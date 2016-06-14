//
//  FCTabBarController.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCPopUpMenu;
@interface FCTabBarController : UITabBarController
@property (nonatomic, strong) FCPopUpMenu *popUp;

+ (instancetype)sharedInstance;
@end
