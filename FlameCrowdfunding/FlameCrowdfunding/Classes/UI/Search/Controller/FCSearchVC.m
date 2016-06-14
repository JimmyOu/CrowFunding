//
//  FCSearchVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCSearchVC.h"
#import "FCSearchType.h"
#import "FCSearchTypeV.h"
#import "FCSearchKeyWord.h"
#import "FCKaiStartHttpManager.h"
#import "FCSearchPublicVC.h"
#import "FCStoryListVC.h"

@interface FCSearchVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray <FCSearchType *>*searchTypes;
@property (nonatomic, strong) NSArray <FCSearchKeyWord *> *keyWords;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)  FCSearchTypeV *typesView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation FCSearchVC


#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
    [self requestData];
}
- (void)requestData {
    [self showHUD];

    [[FCKaiStartHttpManager sharedInstance] getAppMarkerAllInfo:nil SuccessBlock:^(NSArray *responseBody) {
        [self hideHUD];
        _searchTypes = responseBody;
        _headerView = [self headerViewForTableView];
        [self.tableView reloadData];
    } failureBlock:^(NSString *error) {
        [self hideHUD];
    }];
    
    [[FCKaiStartHttpManager sharedInstance]getAppKeyWordsInfo:nil successBlock:^(NSArray * responseBody) {
        [self hideHUD];
        _keyWords = responseBody;
        [self.tableView reloadData];
    } failureBlock:^(NSString *error) {
        [self hideHUD];
    }];
}
- (void)setUpUI {
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 40);
    [self.contentView addSubview:_searchBar];

    CGRect tableViewFrame = CGRectMake(0, _searchBar.bottom , kScreenWidth, kScreenHeight - _searchBar.bottom );
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 30;
    [self.contentView addSubview:_tableView];
    
    
}

- (UIView *)headerViewForTableView {
    CGFloat topMagin = 15;
    CGFloat kTitleFontSize = 20;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth +topMagin+kTitleFontSize )];
    _typesView = [[FCSearchTypeV alloc] initWithTypes:self.searchTypes frame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    [headerView addSubview:_typesView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"热门关键词";
    title.font = [UIFont systemFontOfSize:13];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.origin = CGPointMake(topMagin, topMagin + _typesView.height);
    [title sizeToFit];
    [headerView addSubview:title];
    
    return headerView;
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_pushToPublicVC:) name:@"kLoadItemsWithTypeNotification" object:nil];
}
- (void)_pushToPublicVC:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    FCSearchPublicVC *publicVC = [[FCSearchPublicVC alloc] init];
    publicVC.userInfo = userInfo;
    [self pushViewController:publicVC animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark – delegate (eg:UITableViewDelegate)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    FCSearchKeyWord *keyword = _keyWords[indexPath.row];
    cell.textLabel.text = keyword.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FCSearchKeyWord *type = _keyWords[indexPath.row];
    FCStoryListVC *listVC = [FCStoryListVC new];
    listVC.type = type;
    [self pushViewController:listVC animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keyWords.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return _headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _headerView.height ;
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters


@end
