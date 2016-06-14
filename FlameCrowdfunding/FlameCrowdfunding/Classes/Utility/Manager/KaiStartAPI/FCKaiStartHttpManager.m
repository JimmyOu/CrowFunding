//
//  FCKaiStartHttpManager.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/4.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FCKaiStartHttpManager.h"
#import "FCFundingItems.h"
#import "FCDetailComment.h"
#import "NSObject+YYModel.h"
#import "FCSupportResponse.h"
#import "FCSearchType.h"
#import "FCSearchKeyWord.h"
#import "FCDetailFundingItem.h"
#import "FCStoryItem.h"

@implementation FCKaiStartHttpManager
+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (UIImage *)getAdvImage {
    CGFloat scale = [UIScreen mainScreen].scale;
    int scaleW = (int)scale * kScreenWidth;
    int scaleH = (int)scale * kScreenHeight;
    NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",scaleW,@"%2A",scaleH];
   __block UIImage *image = nil;
    [[FCKaiStartManager sharedInstance] getAdvLoadingImage:nil url:urlStr successBlock:^(id responseBody) {
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataArray[0]objectForKey:@"imageUrl"]]];
            image = [UIImage imageWithData:data];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];   // 保存文件的名称
            [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        });
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取启动图片失败%@",error);
    }];
    return image;

}
- (void)getPublicItemsSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = @"http://api.kaistart.com:8080/crowdfundingservice/app/story/lists?size=10";
    [[FCKaiStartManager sharedInstance] getPublicCrowfundingItems:nil url:url successBlock:^(id responseBody) {
        FCFundingItems *items = [FCFundingItems modelWithDictionary:responseBody];
        FCHandleBlock(successBlock,items);
    } failureBlock:^(NSString *error) {
        DebugLog(@"请求数据出错：%@",error) ;
    }];
    
    
}


- (void)getDetailCommentsWithUserInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = @"http://api.kaistart.com:8080/crowdfundingservice/app/story/commentsbycreatetime?size=20";
    [[FCKaiStartManager sharedInstance] getDetailComments:userInfo url:url successBlock:^(id responseBody) {
        NSMutableArray *comments_multi = [NSMutableArray arrayWithCapacity:20];
        NSArray *comments = (NSArray *)responseBody[@"comments"];
        for (NSDictionary *comment in comments) {
            FCDetailComment *detailComment = [FCDetailComment modelWithDictionary:comment];
            [comments_multi addObject:detailComment];
        }
        FCHandleBlock(successBlock,comments_multi);
    } failureBlock:^(NSString *error) {
        DebugLog(@"请求详细评论失败%@",error);
    }];

}

- (void)getSupportWithUserInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *id = userInfo[@"id"];
   NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/story/support/%@",id];
    [[FCKaiStartManager sharedInstance] getSupport:userInfo url:url successBlock:^(NSDictionary* responseBody) {
        FCSupportProgress *support = [FCSupportProgress modelWithDictionary:responseBody];
        FCHandleBlock(successBlock,support);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取support数据失败%@",error);
    }];
}

- (void)getAppMarkerAllInfo:(NSDictionary *)userInfo SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/marker/all"];
    [[FCKaiStartManager sharedInstance] getSearchIcons:userInfo url:url successBlock:^(id responseBody) {
        NSMutableArray *mult = [NSMutableArray array];
        NSArray *types = responseBody[@"marker"];
        for (NSDictionary *type in types) {
            FCSearchType *typeModel = [FCSearchType modelWithDictionary:type];
            [mult addObject:typeModel];
        }
        FCHandleBlock(successBlock,mult);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取appMarkers数据失败%@",error);
    }];
}

- (void)getAppKeyWordsInfo:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/story/type/list"];
    [[FCKaiStartManager sharedInstance] getKeyWords:nil url:url successBlock:^(id responseBody) {
        NSMutableArray *mult = [NSMutableArray array];
        NSArray *types = responseBody[@"list"];
        for (NSDictionary *type in types) {
            FCSearchKeyWord *typeModel = [FCSearchKeyWord modelWithDictionary:type];
            [mult addObject:typeModel];
        }
        FCHandleBlock(successBlock,mult);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取keywords数据失败%@",error);
    }];
}

- (void)getItemsWithType:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/story/lists?size=10"];
    [[FCKaiStartManager sharedInstance] getTypeCrowfundingItems:userInfo url:url successBlock:^(id responseBody) {
        FCFundingItems *items = [FCFundingItems modelWithDictionary:responseBody];
        FCHandleBlock(successBlock,items);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取getItemsWithType数据失败%@",error);
        
    }];
}

- (void)getFundingItemDetail:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *uid = userInfo[@"uid"];
    //346C9CD59366A7C6E050190AFD0102E8
    NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/story/detail/%@",uid];
    [[FCKaiStartManager sharedInstance] getDetailFundingItem:userInfo url:url successBlock:^(NSDictionary * responseBody) {
        FCDetailFundingItem *detailItem = [FCDetailFundingItem modelWithDictionary:responseBody[@"detail"]];
        FCHandleBlock(successBlock,detailItem);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取getFundingItemDetail数据失败%@",error);
    }];
}
- (void)getStoryItem:(NSDictionary *)userInfo successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    NSString *uid = userInfo[@"uid"];
    //%E5%A5%BD%E7%8E%A9
    NSString *url = [NSString stringWithFormat:@"http://api.kaistart.com:8080/crowdfundingservice/app/story/getstorybyname?key=%@",uid];
    [[FCKaiStartManager sharedInstance] getStoryByname:userInfo url:url successBlock:^(NSDictionary * responseBody) {
        NSArray *storyItems = responseBody[@"stories"];
        NSMutableArray *mul_model = [NSMutableArray array];
        for (NSDictionary *dic in storyItems) {
            FCStoryItem *storyItem = [FCStoryItem modelWithDictionary:dic];
            [mul_model addObject:storyItem];
        }
        FCHandleBlock(successBlock,mul_model);
    } failureBlock:^(NSString *error) {
        DebugLog(@"获取getStoryItem数据失败%@",error);
    }];
}
@end
