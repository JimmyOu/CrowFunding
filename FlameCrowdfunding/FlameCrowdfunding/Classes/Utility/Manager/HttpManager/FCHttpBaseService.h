//
//  FCHtttpBaseService.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
// 基础网络请求类

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
#define kHttpFailedErrorCode            -9999
#define kHttpFailedErrorMsg             @"服务异常，请稍后重试"

@interface FCHttpBaseService : NSObject
/**
 *  异步http请求    get
 *
 *  @param url       请求url
 *  @param postData  请求所带的参数
 *  @param start     请求开始回调
 *  @param responsed 请求正常响应回调
 *  @param failed    请求失败或者异常回调
 */
+ (void)asynGet:(NSString *)url queryParams:(NSDictionary *)params startBlock:(RequestStartBlock)start responsedBlock:(ResponsedBlock)responsed failuredBlock:(RequestFailureBlock)failed;

/**
 *  异步http请求
 *
 *  @param url       请求url
 *  @param postData  请求所带的参数
 *  @param start     请求开始回调
 *  @param responsed 请求正常响应回调
 *  @param failed    请求失败或者异常回调
 */
+ (void)asyncPost:(NSString *)url postData:(NSDictionary *)postData startBlock:(RequestStartBlock)start responsedBlock:(ResponsedBlock)responsed failuredBlock:(RequestFailureBlock)failed;
@end

NS_ASSUME_NONNULL_END