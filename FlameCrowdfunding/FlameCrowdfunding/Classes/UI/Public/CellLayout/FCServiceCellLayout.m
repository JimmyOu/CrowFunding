//
//  FCServiceCellLayout.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCServiceCellLayout.h"
#import "FCSupportResponse.h"
#import "NSString+Size.h"
@implementation FCServiceSubLayout
- (void)setSubStr:(NSString *)subStr {
    _subStr = subStr;
    CGSize size = [subStr boundingRectWithSize:CGSizeMake(kServiceCellWidth, CGFLOAT_MAX) withFont:[UIFont systemFontOfSize:kServiceContentFont]];
    _sub.size = size;
}
@end
@implementation FCServiceCellLayout


- (void)setService:(FCService *)service {
    _service = service;
    [self layout];
}

/**
 *  #define kServiceCellOutSideMagin 15
 #define kServiceCellInsideMagin 10
 #define kServiceCellWidth (kScreenWidth - 2 *kServiceCellOutSideMagin)
 #define kMoneyIcon 12
 #define kMoneyFont 12
 #define kSupportFont 12
 #define kServiceTitleFont 12
 #define kServiceContentFont 10
 #define kSendTimeFont 10
 #define kSupportedFont 10
*/
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
/**
 *  @property (nonatomic, assign) CGRect iconFrame;
 @property (nonatomic, assign) CGRect nameFrame;
 @property (nonatomic, assign) CGRect supportFrame;
 @property (nonatomic, assign) CGRect lineFrame;
 @property (nonatomic, assign) CGRect titleFrame;
 @property (nonatomic, assign) CGRect contentFrame;
 @property (nonatomic, assign) CGRect sendTimeFrame;
 @property (nonatomic, assign) CGRect supportedFrame;
 @property (nonatomic, assign) CGRect subFromt;
 @property (nonatomic, strong) NSArray <FCServiceSubLayout *>*subLayouts;
 */
- (void)layout {
    _iconFrame = CGRectMake(kServiceCellOutSideMagin, kServiceCellOutSideMagin, kMoneyIconWidth, kMoneyIconWidth);
    _moneyFrame = CGRectMake(CGRectGetMaxX(_iconFrame) +kServiceCellInsideMagin, CGRectGetMinY(_iconFrame), 0.5*kServiceCellWidth, kMoneyFont);
    _supportFrame = CGRectMake(kScreenWidth - kServiceCellOutSideMagin - 0.3 *kServiceCellWidth , CGRectGetMinY(_moneyFrame), 0.3*kServiceCellWidth, 12);
    _lineFrame = CGRectMake(kServiceCellOutSideMagin, CGRectGetMaxY(_iconFrame)+kServiceCellInsideMagin, kServiceCellWidth, 1);
    _titleFrame = CGRectMake(kServiceCellOutSideMagin, CGRectGetMaxY(_lineFrame), kServiceCellWidth, 2*kServiceTitleFont);
    NSString *content = _service.digest;
    NSArray *strs = [content componentsSeparatedByString:@"\r\n"];
    if (strs.count) {
        NSString *subStr = strs[0];
        CGSize subSize = [subStr boundingRectWithSize:CGSizeMake(kServiceCellWidth, NSIntegerMax) withFont:[UIFont systemFontOfSize:kServiceContentFont]];
        _subFromt = CGRectMake(kServiceCellOutSideMagin, CGRectGetMaxY(_titleFrame), kServiceCellWidth, subSize.height);
        NSMutableArray *subLayouts = [NSMutableArray array];
        if (strs.count > 1) {
            for (int i = 1; i<strs.count; i++) {
                FCServiceSubLayout *layout = [[FCServiceSubLayout alloc] init];
                layout.subStr = strs[i];
                [subLayouts addObject:layout];
            }
        }
        _subLayouts = subLayouts;
    }
    CGFloat contentHeight =  kServiceCellOutSideMagin;
    for (FCServiceSubLayout *layout in _subLayouts) {
        contentHeight += CGRectGetHeight(layout.sub);
    }
    _contentFrame = CGRectMake(kServiceCellOutSideMagin, CGRectGetMaxY(_subFromt), kServiceCellWidth, contentHeight);
    _sendTimeFrame = CGRectMake(kServiceCellOutSideMagin, CGRectGetMaxY(_contentFrame), 0.5*kServiceCellWidth, 2*kSendTimeFont);
    _supportedFrame = CGRectMake( kScreenWidth- kServiceCellWidth*0.5 - kServiceCellOutSideMagin,  CGRectGetMaxY(_contentFrame), kServiceCellWidth*0.5, 2*kSendTimeFont);
    
    
    _cellHeight = CGRectGetMaxY(_supportedFrame);
    
}
@end



