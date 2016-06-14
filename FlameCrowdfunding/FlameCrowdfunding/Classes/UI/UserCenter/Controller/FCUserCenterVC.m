//
//  FCUserCenterVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/18.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCUserCenterVC.h"

@interface FCUserCenterVC ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) UIView  *headView;
@end

@implementation FCUserCenterVC

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
}
- (void)setUpUI {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.contentView.bounds;
    _tableView.top = 20;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];
    
    
}
- (UIView *)headerView {
    _headView = [UIView new];
    UIImageView *iconV = [[UIImageView alloc] init];
    iconV.image = [UIImage imageNamed:@"kai_head"];
    iconV.size = CGSizeMake(50, 50);
    iconV.top = 15;
    iconV.centerX = kScreenWidth * 0.5;
    [_headView addSubview:iconV];
    UILabel *name = [UILabel new];
    name.text = @"JimmyOu";
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:12];
    name.frame = CGRectMake(0, 0, kScreenWidth, 2*12);
    name.centerX = 0.5*kScreenWidth;
    name.top = CGRectGetMaxY(iconV.frame);
    [_headView addSubview:name];
    
    UILabel *descrip = [UILabel new];
    descrip.text = @"我是一只小青龙，小呀小青龙";
    descrip.textColor = [UIColor lightGrayColor];
    descrip.textAlignment = NSTextAlignmentCenter;
    descrip.font = [UIFont systemFontOfSize:10];
    descrip.frame = CGRectMake(0, 0, kScreenWidth, 2*10);
    descrip.centerX = 0.5*kScreenWidth;
    descrip.top = CGRectGetMaxY(name.frame);
    [_headView addSubview:descrip];
    
    UIView *mask = [UIView new];
    mask.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1];
    mask.frame = CGRectMake(0, CGRectGetMaxY(descrip.frame),kScreenWidth, 10);
    [_headView addSubview:mask];
    _headView.size = CGSizeMake(kScreenWidth, CGRectGetMaxY(mask.frame));
    return _headView;

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark – delegate (eg:UITableViewDelegate)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *text = self.cells[indexPath.section][indexPath.row];
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row ==0){
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(15, 44-1,kScreenWidth - 30 , 1);
        line.backgroundColor = [UIColor blackColor];
        [cell addSubview:line];
        line.alpha = 0.3;
    }
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0){
        return [self headerView].height;
    }
    else return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0){
        return [self headerView];
    }
    return nil;
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters
- (NSArray *)cells {
    if (!_cells) {
        _cells = @[@[@"我的钱包",@"我的订单"],@[@"我的群组",@"我的项目"],@[@"账号管理",@"设置"]];
    }
    return _cells;
}

@end
