//
//  FCFundingItems.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
// 数据是每次十个的请求

#import <Foundation/Foundation.h>
@class FCFundingItem;
@class FCComment;
@interface FCFundingItems : NSObject
@property (nonatomic, strong) NSString *message;                //返回状态描述
@property (nonatomic, assign) NSInteger mobile_video_widht;     //video的宽度
@property (nonatomic, strong) NSArray <FCFundingItem *>*stories;                 //众筹项目
@property (nonatomic, strong) NSString *status;                 //状态码
@property (nonatomic, assign) NSInteger moblie_pic_height;      //图片高度
@property (nonatomic, assign) NSInteger mobile_video_height;    //video height
@property (nonatomic, assign) NSInteger mobile_pic_width;       //图片宽度
@end


@interface FCFundingItem : NSObject
@property (nonatomic, assign) NSInteger total;     //已筹金额
@property (nonatomic, strong) NSString *digest;    //项目简介
@property (nonatomic, strong) NSString *mobile_pic;//头像
@property (nonatomic, strong) NSString *name;       //项目名称
@property (nonatomic, assign) NSInteger joinnum;    //支持人数
@property (nonatomic, assign) NSInteger like_num;   //喜欢人数
@property (nonatomic, strong) NSString *mobile_video;//视频地址
@property (nonatomic, assign) NSInteger share_num;      //分享人数
@property (nonatomic, strong) NSString *marker_name;    //分类
@property (nonatomic, assign) NSInteger comm_num;       //评论人数
@property (nonatomic, strong) NSString *pic;            //项目图片
@property (nonatomic, strong) NSString *header;         //发起者头像
@property (nonatomic, assign) NSInteger funds;          //期望金额
@property (nonatomic, strong) NSString *nick;           //发起者名字
@property (nonatomic, assign) NSInteger days;           //众筹总天数
@property (nonatomic, assign) NSInteger remain;         //众筹剩余天数
@property (nonatomic, strong) NSString *create_time;    //众筹发起时间
@property (nonatomic, strong) NSArray <FCComment *>*comments;        //头几个评论

@property (nonatomic, strong) NSString *id;              //众筹id
@property (nonatomic, strong) NSString *user_id;         //userId
@property (nonatomic, strong) NSString *group_id;        //groupId
@end

@interface FCComment : NSObject
@property (nonatomic, strong) NSString *comments_header;    //评论者的头像
@property (nonatomic, strong) NSString *comments_create_time;   //评论时间
@property (nonatomic, strong) NSString *comments_content;       //评论内容
@end