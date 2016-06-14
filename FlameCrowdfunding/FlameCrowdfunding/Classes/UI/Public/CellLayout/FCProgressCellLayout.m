//
//  FCProgressCellLayout.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCProgressCellLayout.h"
#import "FCSupportResponse.h"
#import "NSString+Size.h"
@implementation FCProgressCellLayout
- (void)setProgressData:(FCSupportProgress *)progressData {
    _progressData = progressData;
    [self layout];
}
/**
 @interface FCSupportProgress :NSObject
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
 
 @property (nonatomic, assign) CGFloat cellHeight;
 @property (nonatomic, assign) CGRect totalFrame;
 @property (nonatomic, assign) CGRect aimFrame;
 @property (nonatomic, assign) CGFloat strokeStart;
 @property (nonatomic, assign) CGFloat strokeEnd;
 @property (nonatomic, assign) CGRect progressVFrame;
 @property (nonatomic, assign) CGRect currentFrame;
 @property (nonatomic, assign) CGRect supportFrame;
 @property (nonatomic, assign) CGRect leftFrame;
 @property (nonatomic, assign) CGRect contentFrame;
 */
- (void)layout {
    _totalFrame = CGRectMake(kCellOutMaigin, kCellOutMaigin, kProgressCellWidth, 2*kTotalMoneyFont);
    _aimFrame = CGRectMake(0.5 * kScreenWidth, kCellOutMaigin, 0.5*kProgressCellWidth, 2*kAimMoneyFont);
    _progressVFrame = CGRectMake(kCellOutMaigin, CGRectGetMaxY(_totalFrame), kProgressCellWidth, kProgressHeight);
    _strokeStart = 0;
    _strokeEnd = _progressData.total / _progressData.funds;
    if (_strokeEnd >1)_strokeEnd =1;
    _currentFrame = CGRectMake(kCellOutMaigin, CGRectGetMaxY(_progressVFrame) +kCellInsideMagin *0.5, 0.3*kProgressCellWidth, 2*kProgressFont);
    _supportFrame = CGRectMake(kCellOutMaigin + 0.3*kProgressCellWidth, CGRectGetMaxY(_progressVFrame)+kCellInsideMagin*0.5, 0.3*kProgressCellWidth, 2*kProgressFont);
    _leftFrame = CGRectMake(kScreenWidth - 0.3*kProgressCellWidth - kCellOutMaigin, CGRectGetMaxY(_progressVFrame)+kCellInsideMagin*0.5, 0.3*kProgressCellWidth, 2*kProgressFont);
    
    FCNotice *notice = _progressData.notice[1];
    CGSize noticeSize = [notice.content boundingRectWithSize:CGSizeMake(kProgressCellWidth, CGFLOAT_MAX) withFont:[UIFont systemFontOfSize:kAimMoneyFont]];
    
    _contentFrame = CGRectMake(kCellOutMaigin, CGRectGetMaxY(_leftFrame) + kCellInsideMagin, kProgressCellWidth, noticeSize.height);
    
    
    _cellHeight = CGRectGetMaxY(_contentFrame) + kCellOutMaigin;
    
    
    
}
@end
