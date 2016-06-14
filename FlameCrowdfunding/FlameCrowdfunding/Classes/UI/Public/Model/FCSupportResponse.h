//
//  FCSupportResponse.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCNotice;
@class FCService;
@interface FCSupportProgress :NSObject
@property (nonatomic, assign) CGFloat total;           //已经筹
@property (nonatomic, assign) NSInteger support_num;   //支持人数
@property (nonatomic, assign) NSInteger remain;       //剩余天数
@property (nonatomic, strong) NSString *end_date;     //结束时间
@property (nonatomic, assign) NSInteger funds;        //需要众筹
@property (nonatomic, assign) NSInteger likes_num;    //喜欢的人数
@property (nonatomic, strong) NSArray <FCNotice * >*notice;  //提示[1]
@property (nonatomic, strong) NSArray <FCService *>*support_items;    //支持的服务

@end

@interface FCNotice :NSObject
@property (nonatomic, strong) NSString *content;    //内容
@property (nonatomic, strong) NSString *title;      //标题
@end

@interface FCService :NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger cost;   //花费
@property (nonatomic, strong) NSString *title;  //名称
@property (nonatomic, strong) NSString *digest; //简介
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger days;   //项目结束时间
@property (nonatomic, assign) NSInteger supportnum;  //支持人数
@property (nonatomic, assign) NSInteger num;    //限制人数（0：无限制，）
@end
