//
//  FCKaiStartManager.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/4.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kTimeOut 30
typedef void(^SuccessBlock)(id responseBody);
typedef void (^FailureBlock)(NSString *error);
@interface FCKaiStartManager : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 获取广告页图片
- (void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - Public众筹项目
- (void)getPublicCrowfundingItems:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - 评论详情
- (void)getDetailComments:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - 支持
- (void)getSupport:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark- search 界面的背景图
- (void)getSearchIcons:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock )successBlock failureBlock:(FailureBlock)failure;
#pragma mark- search keywords
- (void)getKeyWords:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
#pragma mark - 根据选择的type查找对应的items
- (void)getTypeCrowfundingItems:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark - fundingItem详细信息
- (void)getDetailFundingItem:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
#pragma mark - keyword information
- (void)getStoryByname:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock )failureBlock;
@end
