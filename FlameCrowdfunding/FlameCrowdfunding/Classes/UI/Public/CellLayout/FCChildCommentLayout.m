//
//  FCChildCommentLayout.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCChildCommentLayout.h"
#import "FCDetailComment.h"
#import "NSAttributedString+atrributeStringToSize.h"


@implementation FCChildCommentLayout
- (void)setComment:(FCChildComment *)comment {
    _comment = comment;
    [self layout];
}
- (void)layout {
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:@" 回复 "
                                                                                   attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFont],
                                                                                                 NSForegroundColorAttributeName:[UIColor lightGrayColor] }];
    NSString *fromStr = _comment.child_nick? :@" ";
    NSAttributedString *from = [[NSAttributedString alloc] initWithString:fromStr
                                                               attributes:@{
                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:kCommentContentFont],
                                                                            NSForegroundColorAttributeName:[UIColor blackColor]
                                                                            }];
    NSString *toStr = _comment.child_to_nick? :@" ";
    NSAttributedString *to = [[NSAttributedString alloc] initWithString:toStr
                                                             attributes:
                              @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:kCommentContentFont],
                                 NSForegroundColorAttributeName:[UIColor blackColor]
                                 }];
    NSAttributedString *digest = [[NSAttributedString alloc] initWithString:_comment.child_content
                                                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFont],
                                                                               NSForegroundColorAttributeName:[UIColor lightGrayColor] }];
    [contentStr insertAttributedString:from atIndex:0];
    [contentStr appendAttributedString:to];
    [contentStr appendAttributedString:digest];
    CGSize strSize = [contentStr boundingRectWithSize:CGSizeMake(KCommentWidth, NSIntegerMax)];
    _contentRect = CGRectMake(0,0, strSize.width, strSize.height);
    
    _time = CGRectMake(0, strSize.height + 10, KCommentWidth, 15);


}
@end
