//
//  FCServiceCell.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCServiceCell.h"
#import "FCServiceCellLayout.h"
#import "FCSupportResponse.h"
@interface FCServiceCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) UILabel *support;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subFromt;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UILabel *sendTime;
@property (nonatomic, strong) UILabel *supported;
@end
@implementation FCServiceCell {
    UIView *_lastSub;
}
- (void)setServiceLayout:(FCServiceCellLayout *)serviceLayout {
    _serviceLayout = serviceLayout;
    [self layout];
}
/**
 @property (nonatomic, assign) NSInteger total;
 @property (nonatomic, assign) NSInteger sort;
 @property (nonatomic, assign) NSInteger cost;   //花费
 @property (nonatomic, strong) NSString *title;  //名称
 @property (nonatomic, strong) NSString *digest; //简介
 @property (nonatomic, strong) NSString *id;
 @property (nonatomic, assign) NSInteger days;   //项目结束时间
 @property (nonatomic, assign) NSInteger supportnum;  //支持人数
 @property (nonatomic, assign) NSInteger num;    //限制人数（0：无限制，）
 */
- (void)layout {
    FCService *service = _serviceLayout.service;
    _icon = [[UIImageView alloc] init];
    _icon.frame = _serviceLayout.iconFrame;
    _icon.layer.cornerRadius = kMoneyIconWidth*0.5;
    _icon.clipsToBounds = YES;
    _icon.image = [UIImage imageNamed:@"home_return of support_rmb"];
    [self.contentView addSubview:_icon];
    
    _money = [UILabel new];
    _money.text = [NSString stringWithFormat:@"%d",(int)service.cost];
    _money.textColor = [UIColor blackColor];
    _money.font = [UIFont systemFontOfSize:kMoneyFont];
    _money.textAlignment = NSTextAlignmentLeft;
    _money.frame = _serviceLayout.moneyFrame;
    [self.contentView addSubview:_money];
    
    _support = [[UILabel alloc] init];
    
    _support.text = @"我要支持";
    _support.font = [UIFont systemFontOfSize:kSupportFont];
    _support.textColor = [UIColor greenColor];
    _support.textAlignment = NSTextAlignmentRight;
    _support.frame = _serviceLayout.supportFrame;
    [self.contentView addSubview:_support];
    
    _line = [UIView new];
    _line.backgroundColor = [UIColor blackColor];
    _line.alpha = 0.5;
    _line.frame = _serviceLayout.lineFrame;
    [self.contentView addSubview:_line];
    
    _title = [UILabel new];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.text = service.title;
    _title.font = [UIFont systemFontOfSize:kServiceTitleFont];
    _title.textColor = [UIColor blackColor];
    _title.frame = _serviceLayout.titleFrame;
    [self.contentView addSubview:_title];
    
    NSArray *strs = [service.digest componentsSeparatedByString:@"\r\n"];
    _subFromt = [UILabel new];
    _subFromt.textAlignment = NSTextAlignmentLeft;
    _subFromt.text = strs[0];
    _subFromt.numberOfLines = 0;
    _subFromt.font = [UIFont systemFontOfSize:kServiceContentFont];
    _subFromt.textColor = [UIColor blackColor];
    _subFromt.frame = _serviceLayout.subFromt;
    [self.contentView addSubview:_subFromt];
    
    _contentV = [UIView new];
    
    _contentV.frame = _serviceLayout.contentFrame;
    [self.contentView addSubview:_contentV];
    for (FCServiceSubLayout *layout in _serviceLayout.subLayouts) {
        CGFloat originx = 0;
        CGFloat originy = (_lastSub)?CGRectGetMaxY(_lastSub.frame):0;
        UILabel *str = [UILabel new];
        str.textAlignment = NSTextAlignmentLeft;
        str.text = layout.subStr;
        str.numberOfLines = 0;
        str.frame = layout.sub;
        str.origin = CGPointMake(originx, originy);
        str.font = [UIFont systemFontOfSize:kServiceContentFont];
        str.textColor = [UIColor blackColor];
        _lastSub =str;
        [_contentV addSubview:str];
    }
    
    _sendTime = [UILabel new];
    _sendTime.textAlignment = NSTextAlignmentLeft;
    _sendTime.text = [NSString stringWithFormat:@"项目结束%d天后发送",(int)service.days];
    _sendTime.textColor = [UIColor blackColor];
    _sendTime.font = [UIFont systemFontOfSize:kServiceContentFont];
    _sendTime.frame = _serviceLayout.sendTimeFrame;
    [self.contentView addSubview:_sendTime];
    
    _supported = [UILabel new];
    _supported.textAlignment = NSTextAlignmentRight;
    NSString *limit = service.days>0? [NSString stringWithFormat:@"已有%d人支持/限制%d人",(int)service.supportnum,(int)service.num]:@"无期限";
    _supported.text = limit;
    _supported.font = [UIFont systemFontOfSize:kServiceContentFont];
    _supported.textColor = [UIColor blackColor];
    _supported.frame = _serviceLayout.supportedFrame;
    [self.contentView addSubview:_supported];
    

}

@end
