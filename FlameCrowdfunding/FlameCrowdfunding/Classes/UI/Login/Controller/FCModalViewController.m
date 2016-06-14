//
//  FCModalViewController.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/13.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCModalViewController.h"
#import "Masonry.h"
#import "FCUserCenterVC.h"
#import "FCNotificationVC.h"

#import "FCDataManager.h"
#import "PasswordStrengthIndicatorView.h"
@interface FCModalViewController ()

@property(nonatomic) UITextField *accountTextField;
@property(nonatomic) UITextField *passwordTextField;
@property(nonatomic) PasswordStrengthIndicatorView *passwordStrengthIndicatorView;
@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation FCModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10;
    self.view.backgroundColor = [UIColor colorWithRed:170 green:170 blue:170 alpha:1];
    
    [self addDismissButton];
    [self addAccountTextField];
    [self addPasswordTextField];
    [self addPasswordStrengthView];
    [self addLoginBtn];

}
#pragma mark - Private Interface methods
- (void)addAccountTextField {
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    self.accountTextField = [UITextField new];
    self.accountTextField.leftView = leftPaddingView;
    self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    self.accountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.accountTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    self.accountTextField.secureTextEntry = NO;
    self.accountTextField.layer.cornerRadius = 2.f;
    self.accountTextField.placeholder = @"账号";
    [self.accountTextField becomeFirstResponder];
    [self.view addSubview:self.accountTextField];
    
    CGFloat kMagin = 5;
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMagin);
        make.right.mas_equalTo(-kMagin);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(36);
    }];
    


    
}
- (void)addPasswordTextField
{
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    self.passwordTextField = [UITextField new];
    self.passwordTextField.leftView = leftPaddingView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.layer.cornerRadius = 2.f;
    self.passwordTextField.placeholder = @"密码";
    [self.passwordTextField becomeFirstResponder];
    [self.passwordTextField addTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    CGFloat kMagin = 5;
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMagin);
        make.right.mas_equalTo(-kMagin);
        make.top.mas_equalTo(self.accountTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(36);
    }];

}

- (void)addPasswordStrengthView
{
    self.passwordStrengthIndicatorView = [PasswordStrengthIndicatorView new];
    [self.view addSubview:self.passwordStrengthIndicatorView];
    
    CGFloat kMagin = 5;
    [self.passwordStrengthIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMagin);
        make.right.mas_equalTo(-kMagin);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(10);
    }];
    

}

- (void)textFieldDidChange:(UITextField *)sender
{
    if (sender.text.length < 1) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusNone;
        return;
    }
    
    if (sender.text.length < 4) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusWeak;
        return;
    }
    
    if (sender.text.length < 8) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusFair;
        return;
    }
    
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusStrong;
}


- (void)addDismissButton
{
   _dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _dismissBtn.translatesAutoresizingMaskIntoConstraints = NO;

    [_dismissBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _dismissBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    [_dismissBtn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [_dismissBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dismissBtn];
    
    [_dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
}
- (void)addLoginBtn {
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
//    loginBtn.tintColor = [UIColor colorWithRed:355 green:355 blue:355 alpha:1];
    [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_dismissBtn);
        make.bottom.mas_equalTo(_dismissBtn.mas_top).offset(-50);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];

    
}
- (void)login:(UIButton *)btn {
    if ([self.accountTextField.text isEqualToString:@"JimmyOu"]&&[self.passwordTextField.text isEqualToString:@"1994"]) {
        [self dismissViewControllerAnimated:NO completion:^{
            if ([_toVC isEqualToString:@"NotificationVC"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginToNotificationVC" object:nil];
                
            }else if ([_toVC isEqualToString:@"UserCenter"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginToUserCenterVC" object:nil];
            }
        }];
    }
    
}
- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


@end
