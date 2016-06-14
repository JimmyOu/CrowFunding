//
//  FCKaiStartManager.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/4.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCKaiStartManager.h"
#import "AFNetworking.h"
@interface FCKaiStartManager ()
//@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
//@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
//@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;
//@property (nonatomic, strong) AFJSONResponseSerializer *jsonResponseSerializer;

@end
@implementation FCKaiStartManager
+ (instancetype)sharedInstance {
    static id shareInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace = [[self alloc] init];
    });
    return shareInstace;
}

- (AFHTTPSessionManager *)baseHttpRequest {
    AFHTTPSessionManager *httpSessionManager = [[AFHTTPSessionManager alloc] init];
    [httpSessionManager.requestSerializer setTimeoutInterval:kTimeOut];
//    //header 设置
    [httpSessionManager.requestSerializer setValue:@"api.kaistart.com:8080" forHTTPHeaderField:@"Host"];
    [httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [httpSessionManager.requestSerializer setValue:@"32A4D5AA57A8FCCCE050840AF24258E6" forHTTPHeaderField:@"uid"];
    [httpSessionManager.requestSerializer setValue:@"1.7.1" forHTTPHeaderField:@"version"];
    [httpSessionManager.requestSerializer setValue:@"1" forHTTPHeaderField:@"type"];
    
    [httpSessionManager.requestSerializer setValue:@"zh-Hans-CN;q=1, en-CN;q=0.9, zh-Hant-CN;q=0.8" forHTTPHeaderField:@"Accept-Language"];
    [httpSessionManager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [httpSessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
    [httpSessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [httpSessionManager.requestSerializer setValue:@"kaiStart/1.7.1 (iPhone; iOS 9.3.2; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
    
    //response 设置
    httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    
    return httpSessionManager;
}
#pragma mark - 广告
- (void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager.requestSerializer setTimeoutInterval:kTimeOut];
    //response 设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:userInfo progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}
#pragma mark - 众筹项目
- (void)getPublicCrowfundingItems:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}

#pragma mark - 评论详情
- (void)getDetailComments:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    [manager.requestSerializer setValue:userInfo[@"pid"] forHTTPHeaderField:@"pid"];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}

- (void)getSupport:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}

- (void)getSearchIcons:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
    
}
- (void)getKeyWords:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}

- (void)getTypeCrowfundingItems:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    
    NSString *marker_id = userInfo[@"marker_id"];
    [manager.requestSerializer setValue:marker_id forHTTPHeaderField:@"marker_id"];
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];

}

- (void)getDetailFundingItem:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByRemovingPercentEncoding];
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];
}

- (void)getStoryByname:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FCHandleBlock(successBlock,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failureBlock,error.localizedDescription);
    }];

}
@end
