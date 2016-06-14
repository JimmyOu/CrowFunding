//
//  FCKaiStartHttpManager.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/4.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCKaiStartManager.h"
@class UIImage;
@interface FCKaiStartHttpManager : NSObject
+ (instancetype)sharedInstance;
//启动图片
- (UIImage *)getAdvImage;
//public crowdFunding
- (void)getPublicItemsSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//评论详情
- (void)getDetailCommentsWithUserInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock ;

//支持
- (void)getSupportWithUserInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//search 上的图标和背景图
- (void)getAppMarkerAllInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//search上的图标
- (void)getAppKeyWordsInfo:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//type to items
- (void)getItemsWithType:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//项目详情
- (void)getFundingItemDetail:(NSDictionary *)uerInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//get storyItem
- (void)getStoryItem:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
