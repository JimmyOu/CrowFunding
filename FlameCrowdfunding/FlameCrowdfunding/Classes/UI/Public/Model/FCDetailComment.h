//
//  FCDetailComment.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//评论详情

#import <Foundation/Foundation.h>
@class FCChildComment;
@interface FCDetailComment : NSObject
@property (nonatomic, strong) NSString *content;            //内容
@property (nonatomic, strong) NSString *id;                 //评论id
@property (nonatomic, strong) NSString *nick;               //评论者
@property (nonatomic, assign) NSInteger rn;                 //index
@property (nonatomic, strong) NSString *project_id;         //projet id
@property (nonatomic, strong) NSString *create_time;        //评论产生时间
@property (nonatomic, strong) NSString *from_user;          //评论者
@property (nonatomic, strong) NSString *header;             //评论者的头像
@property (nonatomic, strong) NSArray <FCChildComment *> *childs;  //评论中回答评论的人
@end
@interface FCChildComment : NSObject
@property (nonatomic, strong) NSString *child_header;          // 头像
@property (nonatomic, strong) NSString *child_content;          //内容
@property (nonatomic, strong) NSString *child_time;             //回答时间
@property (nonatomic, strong) NSString *child_id;               //评论id
@property (nonatomic, strong) NSString *child_nick;             //from nick
@property (nonatomic, strong) NSString *child_to_nick;          //to nick
@property (nonatomic, strong) NSString *child_user;             //评论者id
@property (nonatomic, strong) NSString *child_to_header;
@end