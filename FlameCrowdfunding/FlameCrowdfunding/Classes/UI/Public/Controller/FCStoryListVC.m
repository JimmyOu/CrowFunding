//
//  FCStoryListVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/9.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCStoryListVC.h"
#import "FCSearchKeyWord.h"
#import "FCStoryItem.h"
#import "FCKaiStartHttpManager.h"
#import "MJRefresh.h"
#import "FCKeyNameCell.h"
#import "UIControl+YYAdd.h"
@interface FCStoryListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <FCStoryItem *>*items;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *back;

@end
@implementation FCStoryListVC
#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadUI];
    [self loadData];
}
- (void)loadData {

    [[FCKaiStartHttpManager sharedInstance] getStoryItem: @{@"uid":_type.name} successBlock:^(id responseBody) {
            [self.items addObjectsFromArray:responseBody];
            [self.tableView reloadData];
    } failureBlock:^(NSString *error) {
        
    }];
}


- (void)loadUI {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.text = _type.name;
    _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 40);
    [self.contentView addSubview:_searchBar];
    
    CGRect tableViewFrame = CGRectMake(0, _searchBar.bottom , kScreenWidth, kScreenHeight - _searchBar.bottom );
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 90;
    [self.contentView addSubview:_tableView];
    
    CGFloat kSideMagin = 15;
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_back];
    [_back setBackgroundImage:[UIImage imageNamed:@"home_com reply_back"] forState:UIControlStateNormal];
    [_back setBackgroundImage:[UIImage imageNamed:@"home_com reply_back_p"] forState:UIControlStateHighlighted];
    _back.size = _back.currentBackgroundImage.size;
    _back.left = kSideMagin;
    _back.bottom = self.contentView.height - kSideMagin;
    __weak __typeof(self)weakSelf = self;
    [_back addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf popViewControllerAnimated:YES];
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"FCKeyNameCell";
    FCKeyNameCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[FCKeyNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    cell.item = self.items[indexPath.row];
    return cell;
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters
- (NSMutableArray<FCStoryItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
