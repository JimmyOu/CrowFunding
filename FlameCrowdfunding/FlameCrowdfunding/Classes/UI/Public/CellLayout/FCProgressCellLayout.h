//
//  FCProgressCellLayout.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCellOutMaigin 15
#define kCellInsideMagin 10
#define kTotalMoneyFont 12
#define kAimMoneyFont 9
#define kProgressFont 5
#define kProgressHeight 5
#define kProgressCellWidth (kScreenWidth - 2 *kCellOutMaigin)

@class FCSupportProgress;
@interface FCProgressCellLayout : NSObject
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect totalFrame;
@property (nonatomic, assign) CGRect aimFrame;
@property (nonatomic, assign) CGFloat strokeStart;
@property (nonatomic, assign) CGFloat strokeEnd;
@property (nonatomic, assign) CGRect progressVFrame;
@property (nonatomic, assign) CGRect currentFrame;
@property (nonatomic, assign) CGRect supportFrame;
@property (nonatomic, assign) CGRect leftFrame;
@property (nonatomic, assign) CGRect contentFrame;

@property (nonatomic, strong) FCSupportProgress *progressData;
@end
