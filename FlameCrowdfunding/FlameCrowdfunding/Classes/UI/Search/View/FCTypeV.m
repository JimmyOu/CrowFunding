//
//  FCTypeV.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCTypeV.h"
#import "FCSearchType.h"
#import "UIImageView+YYWebImage.h"
#import "UIView+FCGesture.h"
@interface FCTypeV ()
@property (nonatomic, strong) FCSearchType *type;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *title;
@end
@implementation FCTypeV
- (instancetype)initWithType:(FCSearchType *)type frame:(CGRect)rect {
    if (self =  [super initWithFrame:rect]) {
        _type = type;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    [_imageV setImageWithURL:[NSURL URLWithString:_type.mobile_bg] options:YYWebImageOptionProgressiveBlur];
    [_imageV clicked:^(UIView * _Nullable view) {
        NSDictionary *userInfo = @{@"marker_id":_type.id};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"kLoadItemsWithTypeNotification" object:nil userInfo:userInfo];
    }];
    [self addSubview:_imageV];
    
    _iconV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_iconV setImageWithURL:[NSURL URLWithString:_type.mobile_icon] options:YYWebImageOptionProgressiveBlur];
    _iconV.centerX = self.width * 0.5;
    _iconV.centerY = self.height * 0.5;
    [self addSubview:_iconV];
    
    _title = [[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:12];
    _title.textColor = [UIColor blackColor];
    _title.text = _type.name;
    [_title sizeToFit];
    _title.centerX = self.width * 0.5;
    _title.top = _iconV.bottom ;
    [self addSubview:_title];
}

@end
