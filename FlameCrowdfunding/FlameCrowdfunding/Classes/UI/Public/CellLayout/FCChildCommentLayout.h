//
//  FCChildCommentLayout.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//
#define  kCommentLeft  50
#define  kCommentOutSideMagin  15
#define  kCommentInsideMagin  10
#define kCommentContentFont  9
#define KCommentWidth (kScreenWidth - kCommentLeft - kCommentOutSideMagin)
#import <Foundation/Foundation.h>
@class FCChildComment;
@interface FCChildCommentLayout : NSObject
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect time;

@property (nonatomic, strong) FCChildComment *comment;
@end
