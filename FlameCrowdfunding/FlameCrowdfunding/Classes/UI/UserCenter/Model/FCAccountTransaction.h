//
//  FCAccountTransaction.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/12.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//  交易信息（官方账户）

#import <Foundation/Foundation.h>
@interface FCAccountTransaction : NSObject

@property (nonatomic, strong) NSString *zzNo;               //转入转出订单号
@property (nonatomic, strong) NSString *userId;             //userId用户编号

@end
