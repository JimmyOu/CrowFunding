//
//  FCStoryItem.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/9.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCStoryItem : NSObject
@property (nonatomic, strong) NSString *share_num;
@property (nonatomic, strong) NSString *mobile_video;
@property (nonatomic, strong) NSString *progress;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *group_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *mobile_pic;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger funds;
@property (nonatomic, assign) NSInteger remain;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger joinnum;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *nick;
@end
