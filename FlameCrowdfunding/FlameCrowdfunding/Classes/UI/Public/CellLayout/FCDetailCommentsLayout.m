//
//  FCDetailCommentsLayout.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCDetailCommentsLayout.h"
#import "FCChildCommentLayout.h"
#import "FCChildCommentLayout.h"
#import "FCDetailComment.h"
#import "NSString+Size.h"
/**
 @property (nonatomic, assign) CGFloat cellHeight;
 @property (nonatomic, strong) FCDetailComment *detailComment;
 
 // detail
 @property (nonatomic, assign) CGRect iconframe;
 @property (nonatomic, assign) CGRect nameFrame;
 @property (nonatomic, assign) CGRect responseFrame;
 @property (nonatomic, assign) CGRect reportFrame;
 @property (nonatomic, assign) CGRect timeFrame;
 @property (nonatomic, assign) CGRect lineFrame;
 
 
 //child
 @property (nonatomic, strong) NSArray <FCChildCommentLayout *>*childs;

 */
@implementation FCDetailCommentsLayout
- (void)setDetailComment:(FCDetailComment *)detailComment {
    _detailComment = detailComment;
    [self layout];
}
- (void)layout {
    _iconframe = CGRectMake(kOutSideMagin, kOutSideMagin, kIconW, kIconW);
    _nameFrame = CGRectMake(CGRectGetMaxX(_iconframe) + kOutSideMagin, _iconframe.origin.y + (20 -15) *0.5, KCommentWidth, 15);
    
    CGFloat kButtonWidth = 30;
    CGFloat kButtonHeight = 15;
    CGFloat kbuttomTop =  _iconframe.origin.y+(20 -15) *0.5;
    _reportFrame = CGRectMake(kScreenWidth - kOutSideMagin - kButtonWidth,kbuttomTop, kButtonWidth, kButtonHeight);
    _responseFrame = CGRectMake(kScreenWidth - 2*(kOutSideMagin + kButtonWidth),kbuttomTop, kButtonWidth, kButtonHeight);
    
    _timeFrame = CGRectMake(CGRectGetMaxX(_iconframe) + kOutSideMagin, CGRectGetMaxY(_iconframe), KCommentWidth, 10);
    
    CGSize contentSize= [_detailComment.content boundingRectWithSize:CGSizeMake(KCommentWidth, NSIntegerMax) withFont:[UIFont systemFontOfSize:12]];
    
    _contentFrame = CGRectMake(kCommentLeft, CGRectGetMaxY(_timeFrame) + kInsdeSideMagin ,  contentSize.width, contentSize.height);
    _lineFrame = CGRectMake(kCommentLeft, CGRectGetMaxY(_contentFrame) + kOutSideMagin, KCommentWidth, 1);
    
    NSMutableArray *mul_childs = [NSMutableArray array];
    for (int i = 0; i < _detailComment.childs.count ; i++) {
        FCChildComment * child = _detailComment.childs[i];
        FCChildCommentLayout *childLayout = [[FCChildCommentLayout alloc] init];
        childLayout.comment = child;
        [mul_childs addObject:childLayout];
    }
    _childs = mul_childs;
    
    CGFloat childHeight = 0;
    for (FCChildCommentLayout *childLayout in _childs) {
      childHeight +=  kInsdeSideMagin+ CGRectGetMaxY(childLayout.time);
    }
    _cellHeight = CGRectGetMaxY(_lineFrame) +  childHeight;
    
    
}
@end
