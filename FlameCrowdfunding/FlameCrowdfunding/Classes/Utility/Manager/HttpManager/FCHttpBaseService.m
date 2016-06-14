//
//  FCHtttpBaseService.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
// http请求的基类，提供一些请求元操作

#import "FCHttpBaseService.h"
#import "FCAFHttp.h"
@implementation FCHttpBaseService
+ (void)asynGet:(NSString *)url queryParams:(NSDictionary *)params startBlock:(RequestStartBlock)start responsedBlock:(ResponsedBlock)responsed failuredBlock:(RequestFailureBlock)failed {
    FCHandleBlock(start);
}
+ (void)asyncPost:(NSString *)url postData:(NSDictionary *)postData startBlock:(RequestStartBlock)start responsedBlock:(ResponsedBlock)responsed failuredBlock:(RequestFailureBlock)failed {
    FCHandleBlock(start);
    [[FCAFHttp sharedAFHttp] asyncPost:url postParams:postData success:^(id  _Nullable responseData) {
        FCHandleBlock(responsed,responseData);
    } failure:^(NSInteger status, NSString * _Nullable errMsg) {
        FCHandleBlock(failed, status, errMsg);
    }];
}
@end
