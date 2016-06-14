//
//  FCAFHttp.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCAFHttp.h"
#import "AFNetworking.h"
#import "FCUserInfoPM.h"
#import "NSObject+YYModel.h"
typedef void(^ProgressBlock)(double progress);
static NSInteger const kHttpTimeoutValue = 10;
@interface FCAFHttp ()
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *defaultParams;
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer *jsonResponseSerializer;
@property (nonatomic, copy) ProgressBlock progressBlock;

@end
@implementation FCAFHttp
+ (instancetype)sharedAFHttp {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        _progressBlock = nil;
        
        //request
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kHttpTimeoutValue;
        
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        _jsonRequestSerializer.timeoutInterval = kHttpTimeoutValue;
        [_jsonRequestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        //response
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        _jsonResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",
                                                          @"text/javascript", @"text/html", @"text/plain", nil];
        [self _setDefaultParams];
    }
    return self;
}
- (void)asyncPost:(NSString *)url postParams:(NSDictionary<NSString *,NSString *> *)params success:(ResponsedBlock)success failure:(RequestFailureBlock)failure {
    
    [self _setDefaultParams];
    
    NSMutableDictionary *paramsDict = nil;
    if ([_defaultParams isNotEmpty]) {
        paramsDict = [NSMutableDictionary dictionaryWithDictionary:_defaultParams];
    }
    if (params) {
        if ([paramsDict isEmpty]) {
            paramsDict = [NSMutableDictionary dictionaryWithDictionary:params];
        } else {
            [paramsDict addEntriesFromDictionary:params];
        }
    }
    
    _httpSessionManager.requestSerializer = _httpRequestSerializer;
    _httpSessionManager.responseSerializer = _jsonResponseSerializer;
    
    [_httpSessionManager POST:url parameters:paramsDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        FCHandleBlock(success, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failure, error.code, error.localizedDescription);
    }];

}
- (void)asyncGet:(NSString *)url queryParams:(NSDictionary<NSString *,NSString *> *)params success:(ResponsedBlock)success failure:(RequestFailureBlock)failure {
    _httpSessionManager.requestSerializer = _httpRequestSerializer;
    _httpSessionManager.responseSerializer = _jsonResponseSerializer;

    [_httpSessionManager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        FCHandleBlock(success, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FCHandleBlock(failure, error.code, error.localizedDescription);
    }];
    

}
- (void)_setDefaultParams {
    BOOL reset = NO;
    if ([_defaultParams isEmpty]) {
        reset = YES;
    } else {
        NSString *uid = [_defaultParams objectForKey:@"userId"];
        NSString *token = [_defaultParams objectForKey:@"tokenId"];
        if (![uid isEqualToString:[FCUserInfoPM sharedInstance].userId]||![token isEqualToString:[FCUserInfoPM sharedInstance].tokenId]) {
            reset = YES;
        }
    }
    
    if (reset) {
        _defaultParams = @{@"tokenId":[FCUserInfoPM sharedInstance].tokenId,
                           @"userId":[FCUserInfoPM sharedInstance].userId};
    }
    
}
#pragma mark - 众筹items
- (void)getFoundingItems:(NSDictionary *)userInfo url:(NSURL *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {

}
@end
