//
//  FCSearchPublicVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/8.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCSearchPublicVC.h"
#import "FCKaiStartHttpManager.h"
#import "FCFundingItems.h"
#import "MJRefresh.h"
#import "UIControl+YYAdd.h"
#import "FCFundingItems.h"
@interface FCSearchPublicVC ()
@property (nonatomic, strong) UIButton *back;
@end
@implementation FCSearchPublicVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    [_back setBackgroundImage:[UIImage imageNamed:@"home_com reply_back"] forState:UIControlStateNormal];
    _back.size = _back.currentBackgroundImage.size;
    CGFloat kMagin = 15;
    _back.left = kMagin;
    _back.bottom = kScreenHeight - kMagin;
    [self.view addSubview:_back];
    __weak __typeof(self)weakSelf = self;
    [_back addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf popViewControllerAnimated:YES];
    }];
}

- (void)requestDataWithPage:(NSInteger)currentPage {
    __weak __typeof(self)weakSelf = self;
    
    [[FCKaiStartHttpManager sharedInstance] getItemsWithType:_userInfo successBlock:^(FCFundingItems * responseBody) {
        // 上拉刷新需要删掉所有数据
        [weakSelf.tableView headerEndRefreshing];
        weakSelf.fundingItems = responseBody;
        [weakSelf.items addObjectsFromArray:responseBody.stories];
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSString *error) {
        [weakSelf.tableView headerEndRefreshing];
        
    }];
    
    
//    [[FCKaiStartHttpManager sharedInstance]getPublicItemsSuccessBlock:^(FCFundingItems * responseBody) {
//        // 上拉刷新需要删掉所有数据
//        [weakSelf.tableView headerEndRefreshing];
//        weakSelf.fundingItems = responseBody;
//        [weakSelf.items addObjectsFromArray:responseBody.stories];
//        [weakSelf.tableView reloadData];
//    } failureBlock:^(NSString *error) {
//        
//    }];
}
@end
