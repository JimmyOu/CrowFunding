//
//  FCSearchTypeV.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/7.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCSearchTypeV.h"
#import "FCSearchType.h"
#import "FCTypeV.h"
@interface FCSearchTypeV ()
@property (nonatomic, strong) NSArray <FCSearchType *> *types;
@end
@implementation FCSearchTypeV

- (instancetype)initWithTypes:(NSArray *)types frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _types = types;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    CGFloat topMagin = 15;
    CGFloat sideMagin = topMagin;
    CGFloat insideMagin = 8;
    
    CGFloat typeWidth = (self.width - 2*insideMagin - 2*sideMagin)/3;
    CGFloat typeHeight= typeWidth;
    for (int i = 0; i < _types.count; i++) {
        FCSearchType *type= _types[i];
        CGFloat typeVx = sideMagin + (i % 3)*(insideMagin + typeWidth);
        CGFloat typeVy = sideMagin + (i / 3)*(insideMagin + typeHeight);
        FCTypeV *typeV = [[FCTypeV alloc] initWithType:type frame:CGRectMake(typeVx, typeVy, typeWidth, typeHeight)];
        [self addSubview:typeV];
    }
}

@end
