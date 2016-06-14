//
//  FCLoginVC.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/13.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCLoginVC.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import "FCModalViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "FCNotificationVC.h"
#import "FCUserCenterVC.h"
@interface FCLoginVC()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImageView *imageView;           //背景图
@property (nonatomic, strong) UIButton *loginBtn;               //登录按钮
@property (nonatomic, strong) UIButton *registBtn;              //注册按钮
@property (nonatomic, strong) UILabel *info;                    //”如果有账号“
@property (nonatomic, strong) UILabel *appName;
@property (nonatomic, strong) UILabel *descrip;                 //app 描述
@property (nonatomic, strong) AVPlayer *avplayer;               //背景播放视频
@property (nonatomic, strong) UIView *movieView;                //播放视频的背景
@end
@implementation FCLoginVC

#pragma mark – VC life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
    [self addConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToNotification) name:@"LoginToNotificationVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToUserCenter) name:@"LoginToUserCenterVC" object:nil];
    
}
- (void)loginToNotification {
    [self pushViewController:[FCNotificationVC new] animated:NO showTabBar:YES];
}
- (void)loginToUserCenter {
    [self pushViewController:[FCUserCenterVC new] animated:NO showTabBar:YES];

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer play];
    self.avplayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(helpPlayerItemDidReachEnd:)
                                            name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
}
- (void)helpPlayerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *playerItem = [notification object];
    [playerItem seekToTime:kCMTimeZero];
}
- (void)addConstraints {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _imageView.userInteractionEnabled = YES;
    
    CGSize loginSize = CGSizeMake(100, 30);
    CGFloat bottom = 100;
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(loginSize);
        make.centerX.mas_equalTo(_imageView);
        make.bottom.mas_equalTo(-bottom);
    }];
    
    CGFloat magin = 5;
    [_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_info.size);
        make.centerX.mas_equalTo(_loginBtn);
        make.bottom.mas_equalTo(_loginBtn.mas_top).offset(-magin);
    }];
    
    [_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_loginBtn);
        make.centerX.mas_equalTo(_loginBtn);;
        make.bottom.mas_equalTo(_info.mas_top).offset(-magin);
    }];
    
    [_appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_appName.size);
        make.center.mas_equalTo(self.view);
    }];
    [_descrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_descrip.size);
        make.top.mas_equalTo(_appName.mas_bottom).offset(magin);
        make.centerX.mas_equalTo(_appName.mas_centerX);
        
    }];
}
- (void)setUpUI {
//    背景图片
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"guide_background"];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
//    //添加视频背景
    self.movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.movieView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.movieView];
    NSURL *movieURL = [[NSBundle mainBundle] URLForResource:@"ocean" withExtension:@"mp4"];
    self.avplayer = [[AVPlayer alloc] initWithURL:movieURL];
    AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setFrame:self.movieView.bounds];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.movieView.layer addSublayer:avPlayerLayer];
    
    
    //login
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.backgroundColor = [UIColor customGreenColor];
    _loginBtn.titleLabel.font = [UIFont appFontSize14];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    //register
    _registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registBtn.backgroundColor = [UIColor customGreenColor];
    _registBtn.titleLabel.font = [UIFont appFontSize14];
    [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    
    //info
    _info = [[UILabel alloc] init];
    _info.text = @"已经有账户了？";
    _info.font = [UIFont appFontSize12];
    _info.textColor = [UIColor customGrayColor];
    [_info sizeToFit];
    [self.view addSubview:_info];
    
    //appName
    _appName = [[UILabel alloc] init];
    _appName.text = @"火焱众筹";
    _appName.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    _appName.textColor = [UIColor customGrayColor];
    [_appName sizeToFit];
    [self.view addSubview:_appName];
    
    //descrip
    _descrip = [[UILabel alloc] init];
    _descrip.text = @"帮您实现梦想";
    _descrip.font = [UIFont appFontSize12];
    _descrip.textColor = [UIColor customGrayColor];
    [_descrip sizeToFit];
    [self.view addSubview:_descrip];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.avplayer pause];
}

#pragma mark – delegate (eg:UITableViewDelegate)
#pragma mark – event (eg:button clicked)
- (void)loginClicked:(UIButton *)login {
    
    FCModalViewController *modalVC = [FCModalViewController new];
    modalVC.toVC = _toClass;
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modalVC animated:YES completion:NULL];

}
- (void)registerClicked:(UIButton *)regist {
    
}

#pragma mark - UIViewControllerTransitioningDelegate
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}
#pragma mark – public method
#pragma mark – private method
#pragma mark – getters and setters

@end
