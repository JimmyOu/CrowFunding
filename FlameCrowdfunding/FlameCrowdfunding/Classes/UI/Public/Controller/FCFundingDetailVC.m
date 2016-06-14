//
//  FCFundingsDetailVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/2.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCFundingDetailVC.h"
#import "FCKaiStartHttpManager.h"
#import "UIControl+YYAdd.h"
#import "FCDetailFundingItem.h"
#import "UIButton+WebCache.h"
#import "UIColor+YYAdd.h"
#import "WMPlayer.h"
#import "UIImage+YYAdd.h"
#define     kSideMagin 15
#define contenWith  kScreenWidth - 2*kSideMagin
#define postTimeFont  10
@interface FCFundingDetailVC ()
@property (nonatomic, strong) FCDetailFundingItem *fundingItem;
@property (nonatomic, strong) UILabel *postTime;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) WMPlayer *player;
@property (nonatomic, strong) UIButton *playerBtn;
@property (nonatomic, strong) UIWebView  *webView;

@property (nonatomic, strong) UIButton *like;
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UIButton *support;
@property (nonatomic, strong) UIButton *group;
@property (nonatomic, strong) UIButton *more;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FCFundingDetailVC
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUI];
    [self requestdata];
}
- (void)requestdata {
    [self showHUD];
    [[FCKaiStartHttpManager sharedInstance] getFundingItemDetail:@{@"uid":_id}
                                        successBlock:^(FCDetailFundingItem * responseBody) {
                                            _fundingItem = responseBody;
                                            [self hideHUD];
                                            [self updateUI];
    } failureBlock:^(NSString *error) {
        [self hideHUD];
        
    }];
}
- (void)updateUI {
    _postTime.text = [NSString stringWithFormat:@"%@  前结束",_fundingItem.end_date];
    _titleLable.text = _fundingItem.name;
    [_playerBtn setImage:[UIImage imageNamed:@"video_play_btn_bg"] forState:UIControlStateNormal];
    [_playerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_fundingItem.mobile_pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logo"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [_webView loadHTMLString:@"abc</br>abc</br>abc</br>abc</br>" baseURL:nil];
    NSString *str = _fundingItem.content;
  

}
- (void)loadUI {

    _postTime = [UILabel new];
    _postTime.textAlignment = NSTextAlignmentLeft;
    _postTime.font = [UIFont systemFontOfSize:postTimeFont];
    _postTime.textColor = [UIColor lightGrayColor];
    _postTime.frame = CGRectMake(kSideMagin, kSideMagin, contenWith, 2*postTimeFont);
    [self.contentView addSubview:_postTime];
    
    CGFloat postTitleFont = 14;
    _titleLable = [UILabel new];
    _titleLable.textAlignment = NSTextAlignmentLeft;
    _titleLable.font = [UIFont systemFontOfSize:postTitleFont];
    _titleLable.textColor = [UIColor blackColor ];
    _titleLable.frame = CGRectMake(kSideMagin, CGRectGetMaxY(_postTime.frame), contenWith, 2*postTitleFont);
    [self.contentView addSubview:_titleLable];
    
    
 
    _playerBtn = [[UIButton alloc] init];
    _playerBtn.adjustsImageWhenHighlighted = NO;
    _playerBtn.frame = CGRectMake(kSideMagin, CGRectGetMaxY(_titleLable.frame) , contenWith, 0.5*contenWith);
    [_playerBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    
    __weak __typeof(self)weakSelf = self;
    [_playerBtn addTarget:self action:@selector(playMovie:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_playerBtn];
    
    
    _webView = [[UIWebView alloc] init];
    
    _webView.frame = CGRectMake(kSideMagin, CGRectGetMaxY(_playerBtn.frame) + kSideMagin, contenWith, kScreenHeight - _webView.bottom - kSideMagin);
    
    [self.contentView addSubview:_webView];
    
    
    
    _back = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_back];
    [_back setBackgroundImage:[UIImage imageNamed:@"home_com reply_back"] forState:UIControlStateNormal];
    _back.size = _back.currentBackgroundImage.size;
    _back.left = kSideMagin;
    _back.bottom = self.contentView.height - kSideMagin;
    [_back addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    
    _like = [UIButton buttonWithType:UIButtonTypeCustom];
    [_like setBackgroundImage:[UIImage imageNamed:@"home_story details_like"] forState:UIControlStateNormal];
    [self.contentView addSubview:_like];
    _like.size = _like.currentBackgroundImage.size;
    _like.bottom = _back.bottom;
    _like.centerX = 0.25 * self.contentView.width;
    
    _support = [UIButton buttonWithType:UIButtonTypeCustom];
    [_support setBackgroundImage:[UIImage imageNamed:@"home_com reply_support"] forState:UIControlStateNormal];
    [self.contentView addSubview:_support];
    _support.size = _support.currentBackgroundImage.size;
    _support.bottom = _back.bottom;
    _support.centerX = 0.5 * self.contentView.width;
    
    _group = [UIButton buttonWithType:UIButtonTypeCustom];
    [_group setBackgroundImage:[UIImage imageNamed:@"find_team"] forState:UIControlStateNormal];
    [self.contentView addSubview:_group];
    _group.size = _group.currentBackgroundImage.size;
    _group.bottom = _back.bottom;
    _group.centerX = 0.75 * self.contentView.width;
    
    _more = [UIButton buttonWithType:UIButtonTypeCustom];
    [_more setBackgroundImage:[UIImage imageNamed:@"find_more_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:_more];
    _more.size = _more.currentBackgroundImage.size;
    _more.bottom = _back.bottom;
    _more.right = self.contentView.width - kSideMagin;
    
}
- (void)dealloc {
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self releasePlayer];
}
- (void)releasePlayer {
    [_player.player.currentItem cancelPendingSeeks];
    [_player.player.currentItem.asset cancelLoading];
    
    [_player.player pause];
    [_player removeFromSuperview];
    [_player.playerLayer removeFromSuperlayer];
    [_player.player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    _player.player = nil;
    _player.currentItem = nil;
    
    _player.playOrPauseBtn = nil;
    _player.playerLayer = nil;
}

- (void)playMovie:(UIButton *)btn {

    if (!_player) {
        _player = [[WMPlayer alloc] initWithFrame:_playerBtn.bounds videoURLStr:_fundingItem.video];
        [_player.player play];
        [_playerBtn addSubview:_player];
    
    }else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
