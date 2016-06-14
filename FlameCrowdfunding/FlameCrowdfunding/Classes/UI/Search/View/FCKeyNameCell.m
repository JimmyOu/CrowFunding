//
//  FCKeyNameCell.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/6/9.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCKeyNameCell.h"
#import "UIImageView+WebCache.h"
#import "FCStoryItem.h"
#import "NSString+Size.h"
#define kcellHeight 90
#define kcellOutsideMagin 10
#define kcellInsideMagin 10
#define kImageWidth (kcellHeight - 2*kcellOutsideMagin)
#define kProgressWidth (kScreenWidth - 3*kcellOutsideMagin - kImageWidth)
#define knameFontSize 9
#define kprogressFontSize 8
@interface FCKeyNameCell ()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
//@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *digest;

/*******progress*******/
@property (nonatomic, strong) UILabel *curentProgress;
@property (nonatomic, strong) UILabel *currentFund;
@property (nonatomic, strong) UILabel *supportingNum;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UIView *progressV;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end
@implementation FCKeyNameCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setItem:(FCStoryItem *)item {
    _item = item;
    [self updateUI];
}
- (void)setUpUI {
    _image = [[UIImageView alloc] init];
    _image.contentMode = UIViewContentModeScaleToFill;
    _image.frame = CGRectMake(kcellOutsideMagin, kcellOutsideMagin, kImageWidth, kImageWidth);
    [self.contentView addSubview:_image];
    
    _name = [UILabel new];
    _name.textColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.7];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.font = [UIFont systemFontOfSize:knameFontSize];
    _name.frame = CGRectMake(_image.right + kcellOutsideMagin, _image.top, kProgressWidth, 2*knameFontSize);
    [self.contentView addSubview:_name];
    
    _digest = [UILabel new];
    _digest.textColor = [UIColor blackColor];
    _digest.textAlignment = NSTextAlignmentLeft;
    _digest.font = [UIFont systemFontOfSize:knameFontSize];
    _digest.frame = CGRectMake(_name.left, _name.bottom, kProgressWidth, 2*knameFontSize);
    [self.contentView addSubview:_digest];
    
    _curentProgress = [UILabel new];
    _curentProgress.textAlignment = NSTextAlignmentLeft;
    _curentProgress.textColor = [UIColor lightGrayColor];
    _curentProgress.font = [UIFont systemFontOfSize:kprogressFontSize];
    _curentProgress.frame = CGRectMake(_name.left, _digest.bottom, kProgressWidth*0.25, 2*kprogressFontSize);
    [self.contentView addSubview:_curentProgress];
    
    _currentFund = [UILabel new];
    _currentFund.textAlignment = NSTextAlignmentLeft;
    _currentFund.textColor = [UIColor lightGrayColor];
    _currentFund.font = [UIFont systemFontOfSize:kprogressFontSize];
    _currentFund.frame = CGRectMake(_curentProgress.right, _digest.bottom, kProgressWidth*0.25, 2*kprogressFontSize);
    [self.contentView addSubview:_currentFund];
    
    _supportingNum = [UILabel new];
    _supportingNum.textAlignment = NSTextAlignmentLeft;
    _supportingNum.textColor = [UIColor lightGrayColor];
    _supportingNum.font = [UIFont systemFontOfSize:kprogressFontSize];
    _supportingNum.frame = CGRectMake(_currentFund.right, _digest.bottom, kProgressWidth*0.25, 2*kprogressFontSize);
    [self.contentView addSubview:_supportingNum];
    
    _state = [UILabel new];
    _state.textAlignment = NSTextAlignmentRight;
    _state.textColor = [UIColor lightGrayColor];
    _state.font = [UIFont systemFontOfSize:kprogressFontSize];
    _state.frame = CGRectMake(_supportingNum.right, _digest.bottom, kProgressWidth*0.25, 2*kprogressFontSize);
    [self.contentView addSubview:_state];
    
    CGFloat progressH = 4;
    _progressV = [UIView new];
    _progressV.backgroundColor = [UIColor lightGrayColor];
    _progressV.frame = CGRectMake(_name.left, _state.bottom, kProgressWidth, progressH);
    [self.contentView addSubview:_progressV];
    
    _progressLayer = [CAShapeLayer new];
    _progressLayer.lineWidth = progressH ;
    _progressLayer.strokeColor = [UIColor greenColor].CGColor;
    _progressLayer.strokeStart = 0;
    _progressLayer.frame = _progressV.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0.5*_progressV.height)];
    [path addLineToPoint:CGPointMake(_progressV.width, 0.5*_progressV.height)];
    _progressLayer.path = path.CGPath;
    [_progressV.layer addSublayer:_progressLayer];
    
}
/**
 @property (nonatomic, strong) NSString *share_num;
 @property (nonatomic, strong) NSString *mobile_video;
 @property (nonatomic, strong) NSString *progress;
 @property (nonatomic, assign) NSInteger total;
 @property (nonatomic, strong) NSString *group_id;
 @property (nonatomic, strong) NSString *pic;
 @property (nonatomic, strong) NSString *header;
 @property (nonatomic, strong) NSString *mobile_pic;
 @property (nonatomic, strong) NSString *id;
 @property (nonatomic, assign) NSInteger funds;
 @property (nonatomic, assign) NSInteger remain;
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, assign) NSInteger joinnum;
 @property (nonatomic, strong) NSString *create_time;
 @property (nonatomic, strong) NSString *user_id;
 */
- (void)updateUI {
     [_image sd_setImageWithURL:[NSURL URLWithString:_item.mobile_pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    NSMutableAttributedString *name_time = [[NSMutableAttributedString alloc]
                                            initWithString:[NSString stringWithFormat:@"%@  ",_item.nick]
                                            attributes:@{
                            NSFontAttributeName : [UIFont systemFontOfSize:knameFontSize],
                            NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:1 alpha:0.7],
                                                        }];
    NSAttributedString *time = [[NSAttributedString alloc] initWithString:_item.create_time
                                                    attributes:@{
                                                    NSFontAttributeName : [UIFont systemFontOfSize:knameFontSize],
                                                    NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                                    }];
    [name_time appendAttributedString:time];
    _name.attributedText = name_time;
    
    _digest.text = _item.name;
    
    _curentProgress.text = [NSString stringWithFormat:@"%.2f%%",100*((CGFloat)_item.total /_item.funds)];
    
    _currentFund.text = [NSString stringWithFormat:@"已筹%@元",[NSString shortedNumberDesc:_item.total]];
    
    _supportingNum.text = [NSString stringWithFormat:@"%d人支持",(int)_item.joinnum];
    
    _state.text = (_item.remain > 0? [NSString stringWithFormat:@"还剩%d天",(int)_item.remain]:@"已结束");
    
    CGFloat progress = ((CGFloat)_item.total /_item.funds) < 1 ?:1;
    _progressLayer.strokeEnd = progress;
    

}


@end
