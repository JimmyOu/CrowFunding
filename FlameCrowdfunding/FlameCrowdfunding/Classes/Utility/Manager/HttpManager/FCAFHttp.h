//
//  FCAFHttp.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//  这这层是对AFNetworking的一层封装,在这一层加上defaultParams《token，id》

#import <Foundation/Foundation.h>
//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);
NS_ASSUME_NONNULL_BEGIN
@interface FCAFHttp : NSObject

+ (instancetype)sharedAFHttp;

- (void)asyncPost:(nonnull NSString *)url
       postParams:(nullable NSDictionary<NSString *, NSString *> *)params
          success:(ResponsedBlock)success failure:(RequestFailureBlock)failure;

- (void)asyncGet:(nonnull NSString *)url queryParams:(nullable NSDictionary<NSString *, NSString *> *)params
         success:(ResponsedBlock)success failure:(RequestFailureBlock)failure;



#pragma mark － 一般数据请求
- (void)getFoundingItems:(NSDictionary *)userInfo url:(NSURL *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
NS_ASSUME_NONNULL_END
