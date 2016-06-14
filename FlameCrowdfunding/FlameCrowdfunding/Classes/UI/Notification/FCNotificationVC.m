//
//  FCNotificationVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/8.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCNotificationVC.h"
#import "YYKit.h"

@interface FCNotificationVC ()
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) YYAnimatedImageView *animatedV;
@property (nonatomic, strong) UILabel *label;
@end
@implementation FCNotificationVC
#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadUI];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}
- (void)loadUI {

    self.contentView.backgroundColor = [UIColor colorWithRed:231.0/255 green:236.0/255 blue:238.0/255 alpha:1];
    _animatedV = [YYAnimatedImageView new];
    _animatedV.size = CGSizeMake(kScreenWidth, 0.5*kScreenWidth);
    _animatedV.origin = CGPointMake(0, 50);
    _animatedV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_animatedV];
    NSString *url = @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif";
    [_animatedV setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation];
    
    _label = [UILabel new];
    _label.frame = CGRectMake(0, CGRectGetMaxY(_animatedV.frame) , kScreenWidth, 40);
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor lightGrayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"No NotificationHere";
    _label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _label.userInteractionEnabled = YES;
    [self.contentView addSubview:_label];


}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark – delegate (eg:UITableViewDelegate)
#pragma mark – event (eg:button clicked)
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters

@end
