//
//  FCPublicVC.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCBaseVC.h"
@class FCFundingItem;
@class FCFundingItems;
@interface FCPublicVC : FCBaseVC
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray < FCFundingItem*>*items;  //对应cell
@property (nonatomic, strong) FCFundingItems *fundingItems;           //除了cell，还有行高等信息
- (void)requestDataWithPage:(NSInteger)currentPage;
@end
