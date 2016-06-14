//
//  FCFundingProgressVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/6.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCFundingProgressVC.h"
#import "FCKaiStartHttpManager.h"
#import "FCSupportResponse.h"
#import "UIControl+YYAdd.h"
#import "FCProgressCell.h"
#import "FCServiceCell.h"
#import "FCProgressCellLayout.h"
#import "FCServiceCellLayout.h"
#define kCellOutsideMagin  15
@interface FCFundingProgressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *back;

@property (nonatomic, strong) FCProgressCellLayout *progressLayout;
@property (nonatomic, strong) NSMutableArray <FCServiceCellLayout *> *serviceLayouts;
@end

@implementation FCFundingProgressVC

#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadUI];
    [self requestForData];
}
- (void)requestForData {
    NSDictionary *userInfo = @{@"id":_project_id};
    [self showHUD];
    [[FCKaiStartHttpManager sharedInstance] getSupportWithUserInfo:userInfo
                                SuccessBlock:^(FCSupportProgress * responseBody) {
                                    [self hideHUD];
                                    {
                                        _progressLayout = [[FCProgressCellLayout alloc] init];
                                        _progressLayout.progressData =responseBody;
                                        
                                        [self.serviceLayouts removeAllObjects];
                                        for ( FCService *service in responseBody.support_items) {
                                            FCServiceCellLayout *serviceLayout = [[FCServiceCellLayout alloc] init];
                                            serviceLayout.service = service;
                                            [self.serviceLayouts addObject:serviceLayout];
                                        }
                                    }
                                    [self.tableView reloadData];
        
    } failureBlock:^(NSString *error) {
        [self hideHUD];
        DebugLog(@"error%@",error);
    }];
}
- (void)loadUI {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.contentView.bounds;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];
    
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    [_back setBackgroundImage:[UIImage imageNamed:@"home_com reply_back"] forState:UIControlStateNormal];
    __weak __typeof(self)weakSelf = self;
    [_back addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    _back.size = _back.currentBackgroundImage.size;
    _back.left = kCellOutsideMagin;
    _back.bottom = self.contentView.height - kCellOutsideMagin;
    [self.contentView addSubview:_back];
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark – delegate (eg:UITableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       FCProgressCell *cell = [[FCProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.progressLayout = self.progressLayout;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString *FCServiceCellID = @"FCServiceCell";
        FCServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:FCServiceCellID];
//        if (!cell) {
            cell = [[FCServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FCServiceCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
        cell.serviceLayout = self.serviceLayouts[indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else { return self.serviceLayouts.count;}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return _progressLayout.cellHeight;
    else {
        FCServiceCellLayout *serviceLayout = _serviceLayouts[indexPath.row];
        return serviceLayout.cellHeight;
        return 300;
    }
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters

- (NSMutableArray<FCServiceCellLayout *> *)serviceLayouts {
    if (!_serviceLayouts) {
        _serviceLayouts = [NSMutableArray array];
    }
    return _serviceLayouts;
}

@end
