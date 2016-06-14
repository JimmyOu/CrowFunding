//
//  FCPublicCell.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/22.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCFundingItem;
//@class FCPublicCellLayout;
@interface FCPublicCell : UITableViewCell
@property (nonatomic, strong) FCFundingItem *fundingItem;
@property (nonatomic, copy) void(^tapFundingDetailBlock)();    //点击众筹详情
@property (nonatomic, copy) void(^tapCommentsDetailBlock)();   //点击评论详情
@end
