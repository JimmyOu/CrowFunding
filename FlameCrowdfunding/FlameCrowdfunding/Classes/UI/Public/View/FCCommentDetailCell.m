//
//  FCCommentDetailCell.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/6.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCCommentDetailCell.h"
#import "UIImageView+YYWebImage.h"
#import "UIFont+CustomFonts.h"
#import "NSDate+FCDateToString.h"
#import "FCDetailComment.h"
#import "FCDetailCommentsLayout.h"
#import "FCChildCommentLayout.h"
static const CGFloat kHeadIconHeight = 20;
@interface FCCommentDetailCell ()
/*         main  comment           */
@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *response;
@property (nonatomic, strong) UIButton *report;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIView *line;

/*          child comment           */
@property (nonatomic, strong) UIView *childCommentsView;
@end
@implementation FCCommentDetailCell {
    UIView *_lastChildV;
    CGFloat _childVsHeightCount;
}
- (void)setDetailCommentLayout:(FCDetailCommentsLayout *)detailCommentLayout {
    if (_detailCommentLayout != detailCommentLayout) {
        _detailCommentLayout = detailCommentLayout;
                [self setUpUI];
//                [self updateUI];
    }
}
/**
 @interface FCDetailComment : NSObject
 @property (nonatomic, strong) NSString *content;            //内容
 @property (nonatomic, strong) NSString *id;                 //评论id
 @property (nonatomic, strong) NSString *nick;               //评论者
 @property (nonatomic, assign) NSInteger rn;                 //index
 @property (nonatomic, strong) NSString *project_id;         //projet id
 @property (nonatomic, strong) NSString *create_time;        //评论产生时间
 @property (nonatomic, strong) NSString *from_user;          //
 @property (nonatomic, strong) NSString *header;             //评论者的头像
 @property (nonatomic, strong) NSArray <FCChildComment *> *childs;  //评论中回答评论的人
 @end
 @interface FCChildComment : NSObject
 @property (nonatomic, strong) NSString *child_header;          // 头像
 @property (nonatomic, strong) NSString *child_content;          //内容
 @property (nonatomic, strong) NSString *child_time;             //回答时间
 @property (nonatomic, strong) NSString *child_id;               //评论id
 @property (nonatomic, strong) NSString *child_nick;             //from nick
 @property (nonatomic, strong) NSString *child_to_nick;          //to nick
 @property (nonatomic, strong) NSString *child_user;             //评论者id
 @property (nonatomic, strong) NSString *child_to_header;
 @end
 */
- (void)updateUI {
    FCDetailComment *comment = _detailCommentLayout.detailComment;
    [_headIcon setImageWithURL:[NSURL URLWithString:comment.header] options:YYWebImageOptionProgressiveBlur];
    _headIcon.frame = _detailCommentLayout.iconframe;
    
    _name.text = comment.nick;
    _name.frame = _detailCommentLayout.nameFrame;
    
    _time.text = comment.create_time;
    _time.frame = _detailCommentLayout.timeFrame;
    
    _content.text = comment.content;
    _content.frame = _detailCommentLayout.contentFrame;
    
    _response.frame = _detailCommentLayout.responseFrame;
    _report.frame = _detailCommentLayout.reportFrame;
    _line.frame = _detailCommentLayout.lineFrame;
    
    
}
- (void)setUpUI {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.size = CGSizeMake(kHeadIconHeight, kHeadIconHeight);
        _headIcon.layer.cornerRadius = 0.5*kHeadIconHeight;
        _headIcon.clipsToBounds = YES;
        
        [self.contentView addSubview:_headIcon];

    }
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor blackColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont appFontSize12];
        [self.contentView addSubview:_name];
    }
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = [UIFont systemFontOfSize:8];
        [self.contentView addSubview:_time];
    }
    if (!_response) {
        _response = [[UIButton alloc] init];
        [_response setTitle:@"回复" forState:UIControlStateNormal];
        _response.titleLabel.font = [UIFont systemFontOfSize:10];
        [_response setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _response.adjustsImageWhenHighlighted = NO;
        [self.contentView addSubview:_response];
    }
    if (!_report) {
        _report = [[UIButton alloc] init];
        [_report setTitle:@"举报" forState:UIControlStateNormal];
        _report.titleLabel.font = [UIFont systemFontOfSize:10];
        [_report setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _report.adjustsImageWhenHighlighted = NO;
        [self.contentView addSubview:_report];
    }
    if (!_content) {
        _content = [UILabel new];
        _content.textColor = [UIColor blackColor];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.font = [UIFont appFontSize12];
        _content.numberOfLines = 0;
        [self.contentView addSubview:_content];
    }
    
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_line];
    }
    
    [self updateUI];
    
    if (_detailCommentLayout.detailComment.childs.count) {
        //先把上一个cell的childView去掉
        [_childCommentsView removeFromSuperview];
        _childCommentsView = nil;
        _lastChildV = nil;
        _childVsHeightCount = 0;
        _childCommentsView = [[UIView alloc] init];
        // 向里面添加childV;
        for (int i = 0; i < _detailCommentLayout.detailComment.childs.count ; i++) {
            FCChildCommentLayout *childLayout =  _detailCommentLayout.childs[i];
            UIView *childV = [self addChilidVs:childLayout];
//            childV.backgroundColor = [UIColor redColor];
            _childVsHeightCount += childV.height;
            CGFloat childVy = (_lastChildV)? CGRectGetMaxY(_lastChildV.frame)+ kInsdeSideMagin: kInsdeSideMagin;
            CGFloat childVx = kCommentLeft;
            childV.origin = CGPointMake(childVx, childVy);
            [_childCommentsView addSubview:childV];
            _lastChildV =childV;
        }
        _childCommentsView.frame = CGRectMake(0, CGRectGetMaxY(_line.frame), kScreenWidth, _childVsHeightCount);
        [self addSubview:_childCommentsView];
    }
}

- (UIView *)addChilidVs:(FCChildCommentLayout *)childLayout {
    UIView *childV =[[UIView alloc] init];
    UILabel *content = [[UILabel alloc] init];
    content.textAlignment = NSTextAlignmentLeft;
    content.textColor = [UIColor blackColor];
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:@" 回复 "
                                                                                   attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFont],
                                                                                                 NSForegroundColorAttributeName:[UIColor lightGrayColor] }];
    NSString *fromStr = childLayout.comment.child_nick ? :@" ";
    NSAttributedString *from = [[NSAttributedString alloc] initWithString:fromStr
                                                               attributes:@{
                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:kCommentContentFont],
                                                                            NSForegroundColorAttributeName:[UIColor blackColor]
                                                                            }];
    NSString *toStr = childLayout.comment.child_to_nick ? : @" ";
    NSAttributedString *to = [[NSAttributedString alloc] initWithString:toStr
                                                             attributes:
                              @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:kCommentContentFont],
                                 NSForegroundColorAttributeName:[UIColor blackColor]
                                 }];
    NSAttributedString *digest = [[NSAttributedString alloc] initWithString:childLayout.comment.child_content
                                                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFont],
                                                                               NSForegroundColorAttributeName:[UIColor lightGrayColor] }];
    [contentStr insertAttributedString:from atIndex:0];
    [contentStr appendAttributedString:to];
    [contentStr appendAttributedString:digest];
    content.attributedText = contentStr;
    content.frame = childLayout.contentRect;
//    content.backgroundColor = [UIColor blueColor];
    content.numberOfLines = 0;
    [childV addSubview:content];
    
    UILabel *time = [[UILabel alloc] init];
    time.textAlignment = NSTextAlignmentLeft;
    time.font = [UIFont systemFontOfSize:8];
    time.textColor = [UIColor lightGrayColor];
    time.text = childLayout.comment.child_time;
    time.frame = childLayout.time;
    [childV addSubview:time];
    
    childV.frame = CGRectMake(0, 0, KCommentWidth, CGRectGetMaxY(time.frame));
    
    return childV;
    
}

@end
