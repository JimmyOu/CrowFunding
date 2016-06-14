//
//  FCCommentsDetailVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/2.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//
#import "FCCommentsDetailVC.h"
#import "FCDetailComment.h"
#import "UIControl+YYAdd.h"
#import "FCFundingProgressVC.h"
#import "FCKaiStartHttpManager.h"
#import "FCCommentDetailCell.h"
#import "FCDetailCommentsLayout.h"
@interface FCCommentsDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *commentsTable;
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) UIButton *support;

/*         data         */
@property (nonatomic, strong) NSMutableArray <FCDetailCommentsLayout *>*commentsLayouts;
@end

@implementation FCCommentsDetailVC

#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadUI];
    [[FCKaiStartHttpManager sharedInstance] getDetailCommentsWithUserInfo:@{@"pid":_uid}
                                                        SuccessBlock:^(NSArray <FCDetailComment *>*responseBody) {
                                                                 DebugLog(@"获取详细评论成功");
                                                                 [self.commentsLayouts removeAllObjects];
                                                            for (FCDetailComment *comment in responseBody) {
                                                                FCDetailCommentsLayout *layout = [[FCDetailCommentsLayout alloc] init];
                                                                layout.detailComment = comment;
                                                                [self.commentsLayouts addObject:layout];
                                                            }
            
                                                            [self.commentsTable reloadData];
                                                             } failureBlock:^(NSString *error) {
                                                                 DebugLog(@"获取详细评论失败%@",error);
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
- (void)loadUI {
    _commentsTable = [[UITableView alloc] init];
    [self.contentView addSubview:_commentsTable];
    _commentsTable.delegate = self;
    _commentsTable.dataSource = self;
    _commentsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentsTable.frame = self.contentView.bounds;
    
    
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
    
    _support = [UIButton buttonWithType:UIButtonTypeCustom];
    [_support setBackgroundImage:[UIImage imageNamed:@"home_com reply_support"] forState:UIControlStateNormal];
    [_support setBackgroundImage:[UIImage imageNamed:@"home_com reply_support_p"] forState:UIControlStateHighlighted];
    [_support addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        FCDetailCommentsLayout *layout = weakSelf.commentsLayouts[0];
        FCFundingProgressVC *progressVC = [[FCFundingProgressVC alloc] init];
        progressVC.project_id = layout.detailComment.project_id;
        [weakSelf pushViewController:progressVC animated:YES];
    }];
    _support.size = _support.currentBackgroundImage.size;
    _support.bottom = _back.bottom;
    _support.centerX = self.contentView.width * 0.5;
    [self.contentView addSubview:_support];
    
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_comment];
    [_comment setBackgroundImage:[UIImage imageNamed:@"home_com reply_comment"] forState:UIControlStateNormal];
    _comment.size = _comment.currentBackgroundImage.size;
    _comment.right = self.contentView.width -kSideMagin;
    _comment.bottom = _support.bottom;
    
    
}
#pragma mark – delegate (eg:UITableViewDelegate)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  self.commentsLayouts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"FCCommentDetailCell";
    FCCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[FCCommentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailCommentLayout = self.commentsLayouts[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _commentsLayouts[indexPath.row].cellHeight;
}
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters
- (NSMutableArray<FCDetailCommentsLayout *> *)commentsLayouts {
    if (!_commentsLayouts) {
        _commentsLayouts = [NSMutableArray array];
    }
    return _commentsLayouts;
}

@end
