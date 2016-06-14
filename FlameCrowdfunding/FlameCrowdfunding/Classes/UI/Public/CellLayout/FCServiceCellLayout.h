//
//  FCServiceCellLayout.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCService;

#define kServiceCellOutSideMagin 15
#define kServiceCellInsideMagin 10
#define kServiceCellWidth (kScreenWidth - 2 *kServiceCellOutSideMagin)
#define kMoneyIconWidth 12
#define kMoneyFont 12
#define kSupportFont 12
#define kServiceTitleFont 12
#define kServiceContentFont 10
#define kSendTimeFont 10
#define kSupportedFont 10
@class FCServiceSubLayout;
@interface FCServiceCellLayout : NSObject
@property (nonatomic, strong) FCService *service;
@property (nonatomic, assign) NSInteger cellHeight;

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect moneyFrame;
@property (nonatomic, assign) CGRect supportFrame;
@property (nonatomic, assign) CGRect lineFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect sendTimeFrame;
@property (nonatomic, assign) CGRect supportedFrame;
@property (nonatomic, assign) CGRect subFromt;
@property (nonatomic, strong) NSArray <FCServiceSubLayout *>*subLayouts;
@end

@interface FCServiceSubLayout : NSObject
@property (nonatomic, strong) NSString *subStr;
@property (nonatomic, assign) CGRect sub;
@end
