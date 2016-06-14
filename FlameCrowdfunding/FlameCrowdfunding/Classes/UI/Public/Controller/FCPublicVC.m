//
//  FCPublicVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCPublicVC.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "FCKaiStartHttpManager.h"
#import "FCBaseVC.h"

#import "FCPublicCell.h"
#import "FCCommentsDetailVC.h"
#import "FCFundingDetailVC.h"
#import "FCFundingItems.h"

@interface FCPublicVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation FCPublicVC
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (instancetype)init {
    if (self = [super init]) {
        _currentPage = 1;
    }
    return self;
}
#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadUI];
    [self addConstraints];
    
    __weak __typeof(self)weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        //上拉刷新
        [weakSelf requestDataWithPage:weakSelf.currentPage];
    }];
    [self.tableView addFooterWithCallback:^{
        //下拉刷新
        weakSelf.currentPage++;
        [weakSelf requestDataWithPage:weakSelf.currentPage];
    }];
    
    //马上进入刷新
    [self.tableView headerBeginRefreshing];
}
- (void)loadUI {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];
}
- (void)addConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _currentPage = 1;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor redColor];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark – delegate (eg:UITableViewDelegate)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"FCPublicCell";
    FCPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[FCPublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.fundingItem = self.items[indexPath.row];
    @weakify(self)
    cell.tapFundingDetailBlock = ^(){
    @strongify(self)
//        FCFundingItem *item = _items[indexPath.row];
//        FCFundingDetailVC *fundingVC = [[FCFundingDetailVC alloc] init];
//        fundingVC.id = item.id;
//        [self pushViewController:fundingVC animated:YES];
    };
    cell.tapCommentsDetailBlock = ^(){
        @strongify(self)
        FCFundingItem *item = _items[indexPath.row];
        FCCommentsDetailVC *commentDetailVC = [[FCCommentsDetailVC alloc] init];
        commentDetailVC.uid = item.id;
        [self pushViewController:commentDetailVC animated:YES];
    };
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.fundingItems.moblie_pic_height;
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
- (void)requestDataWithPage:(NSInteger)currentPage {
    __weak __typeof(self)weakSelf = self;
    
    [[FCKaiStartHttpManager sharedInstance]getPublicItemsSuccessBlock:^(FCFundingItems * responseBody) {
        // 上拉刷新需要删掉所有数据
        [weakSelf.tableView headerEndRefreshing];
        weakSelf.fundingItems = responseBody;
        [weakSelf.items addObjectsFromArray:responseBody.stories];
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSString *error) {
        
    }];
    
}
#pragma mark – getters and setters

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end
