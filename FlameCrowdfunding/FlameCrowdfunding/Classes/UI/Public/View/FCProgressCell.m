//
//  FCProgressCell.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCProgressCell.h"
#import "FCProgressCellLayout.h"
#import "FCSupportResponse.h"
@interface FCProgressCell ()
@property (nonatomic, strong) UILabel *total;
@property (nonatomic, strong) UILabel *aim;
@property (nonatomic, strong) UIView *progressV;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *current;
@property (nonatomic, strong) UILabel *support;
@property (nonatomic, strong) UILabel *left;
@property (nonatomic, strong) UILabel *content;
@end
@implementation FCProgressCell

- (void)setProgressLayout:(FCProgressCellLayout *)progressLayout {
    _progressLayout = progressLayout;
    [self loadUI];
}
/**
 *  @interface FCSupportProgress :NSObject
 @property (nonatomic, assign) CGFloat total;           //已经筹
 @property (nonatomic, assign) NSInteger support_num;   //支持人数
 @property (nonatomic, assign) NSInteger remain;       //剩余天数
 @property (nonatomic, strong) NSString *end_date;     //结束时间
 @property (nonatomic, assign) NSInteger funds;        //需要众筹
 @property (nonatomic, assign) NSInteger likes_num;    //喜欢的人数
 @property (nonatomic, strong) NSArray <FCNotice * >*notice;  //提示[1]
 @property (nonatomic, strong) NSArray <FCService *>*support_items;    //支持的服务
 
 @end
 
 @interface FCNotice :NSObject
 @property (nonatomic, strong) NSString *content;    //内容
 @property (nonatomic, strong) NSString *title;      //标题
 @end

 */
-(void) loadUI {
    FCSupportProgress *progress = _progressLayout.progressData;
    _total = [[UILabel alloc] init];
    _total.font = [UIFont systemFontOfSize:kTotalMoneyFont];
    _total.textColor = [UIColor blackColor];
    _total.textAlignment = NSTextAlignmentLeft;
    _total.text = [NSString stringWithFormat:@"众筹总额: ¥%d",(int)progress.total];
    _total.frame = _progressLayout.totalFrame;
    [self.contentView addSubview:_total];
    
    _aim = [[UILabel alloc] init];
    _aim.font = [UIFont systemFontOfSize:kAimMoneyFont];
    _aim.textAlignment = NSTextAlignmentRight;
    _aim.textColor = [UIColor blackColor];
    _aim.alpha = 0.8;
    _aim.text = [NSString stringWithFormat:@"目标金额: ¥%ld",progress.funds];
    _aim.frame = _progressLayout.aimFrame;
    _aim.centerY = _total.centerY;
    [self.contentView addSubview:_aim];
    
    _progressV = [[UIView alloc] init];
    _progressV.backgroundColor = [UIColor lightGrayColor];
    _progressV.frame = _progressLayout.progressVFrame;
    [self.contentView addSubview:_progressV];
    
    
    UIView *subProgress = [UIView new];
    subProgress.backgroundColor = [UIColor greenColor];
    subProgress.frame = _progressV.bounds;
    subProgress.width = _progressV.width*_progressLayout.strokeEnd;
    [_progressV addSubview:subProgress];
    

    _current = [UILabel new];
    _current.frame = _progressLayout.currentFrame;
    _current.font  = [UIFont systemFontOfSize:kProgressFont];
    _current.textAlignment = NSTextAlignmentLeft;
    _current.textColor = [UIColor lightGrayColor];
    _current.text = [NSString stringWithFormat:@"%.2f%%",_progressLayout.strokeEnd*100];
    [self.contentView addSubview:_current];
    
    _support = [UILabel new];
    _support.frame = _progressLayout.supportFrame;
    _support.font = [UIFont systemFontOfSize:kProgressFont];
    _support.textAlignment = NSTextAlignmentCenter;
    _support.textColor = [UIColor lightGrayColor];
    _support.text = [NSString stringWithFormat:@"%d人支持",(int)progress.support_num];
    [self.contentView addSubview:_support];
    
    
    _left = [UILabel new];
    _left.frame = _progressLayout.leftFrame;
    _left.font = [UIFont systemFontOfSize:kProgressFont];
    _left.textAlignment = NSTextAlignmentRight;
    _left.textColor = [UIColor lightGrayColor];
    _left.text = [NSString stringWithFormat:@"剩余%d天",(int)progress.remain];
    [self.contentView addSubview:_left];
    
    _content = [UILabel new];
    _content.frame = _progressLayout.contentFrame;
    _content.font = [UIFont systemFontOfSize:kAimMoneyFont];
    _content.textColor = [UIColor lightGrayColor];
    _content.textAlignment = NSTextAlignmentLeft;
    _content.numberOfLines = 0;
    FCNotice *notice = progress.notice[1];
    _content.text = notice.content;
    [self.contentView addSubview:_content];
    
}

@end
