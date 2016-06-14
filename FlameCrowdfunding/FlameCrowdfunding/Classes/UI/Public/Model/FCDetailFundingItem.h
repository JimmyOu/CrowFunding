//
//  FCDetailFundingItem.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/8.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCDetailFundingItem : NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *progress;
@property (nonatomic, strong) NSString *mobile_pic;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *end_date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *iscollected;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *like_num;
@property (nonatomic, strong) NSString *support_num;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *web_video_pic;
@property (nonatomic, strong) NSString *marker_name;
@property (nonatomic, assign) NSInteger isLike;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *comments_num;
@property (nonatomic, strong) NSString *group_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger funds;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *remain;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, assign) NSInteger *news_num;
@end
