//
//  FCDetailCommentsLayout.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kOutSideMagin 15
#define kInsdeSideMagin 10
#define kIconW 20

@class FCChildCommentLayout;
@class FCDetailComment;
@interface FCDetailCommentsLayout : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) FCDetailComment *detailComment;

// detail
@property (nonatomic, assign) CGRect iconframe;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect responseFrame;
@property (nonatomic, assign) CGRect reportFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect lineFrame;


//child
@property (nonatomic, strong) NSArray <FCChildCommentLayout *>*childs;





@end
