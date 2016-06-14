//
//  FCPublicCell.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/22.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "FCPublicCell.h"
#import "UIFont+CustomFonts.h"
#import "UIColor+CustomColors.h"
#import "FCFundingItems.h"
#import "YYKit.h"
#import "NSString+Size.h"

static const NSInteger kCellInsideMagin = 5;
static const NSInteger kCellOutsideMagin = 10;
#define kImageSize CGSizeMake(kScreenWidth - kCellOutsideMagin*2,150)

@interface FCPublicCell()

/************** fundingItemView ****************/
@property (nonatomic, strong) UIView *fundingItemView;
@property (nonatomic, strong) UILabel *organizator;
@property (nonatomic, strong) UIImageView *favor;
@property (nonatomic, strong) UILabel *favorNum;
@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *digest;

/************** commentsView ****************/
@property (nonatomic, strong) UIView *commentsView;
@property (nonatomic, strong) UIView *lineTop;
@property (nonatomic, strong) UIImageView *comment1_header;
@property (nonatomic, strong) UILabel *comment1_content;
@property (nonatomic, strong) UIImageView *comment2_header;
@property (nonatomic, strong) UILabel *comment2_content;
@property (nonatomic, strong) UILabel *commentsNum;
@property (nonatomic, strong) UIView *linebottom;


@end
@implementation FCPublicCell

- (void)loadUI {
    
    
    /****** setUp subViews of fundingItemView ******/
    _fundingItemView = [[UIView alloc] init];
    _fundingItemView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_fundingItemView];
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    UITapGestureRecognizer *tapFundingItem = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        FCHandleBlock(_tapFundingDetailBlock);
    }];
    [_fundingItemView addGestureRecognizer:tapFundingItem];
    
    
    _organizator = [[UILabel alloc] init];
    _organizator.backgroundColor = [UIColor whiteColor];
    _organizator.font = [UIFont appFontSize12];
    _organizator.textColor = [UIColor customGrayColor];
    _organizator.textAlignment = NSTextAlignmentLeft;
    [_fundingItemView addSubview:_organizator];
    _organizator.frame = CGRectMake(kCellOutsideMagin, kCellOutsideMagin, 0.5*kScreenWidth, 13);
    
    _favorNum = [[UILabel alloc] init];
    _favorNum.font = [UIFont appFontSize12];
    _favorNum.textColor = [UIColor customGrayColor];
    _favorNum.textAlignment = NSTextAlignmentRight;
    [_fundingItemView addSubview:_favorNum];
    
    _favor = [[UIImageView alloc] init];
    _favor.image = [UIImage imageNamed:@"home_like"];
    _favor.size = _favor.image.size;
    [_fundingItemView addSubview:_favor];
    
    _webImageView = [YYAnimatedImageView new];
    _webImageView.size = kImageSize;
    _webImageView.clipsToBounds = YES;
    _webImageView.contentMode = UIViewContentModeScaleAspectFill;
    _webImageView.backgroundColor = [UIColor whiteColor];
    [_fundingItemView addSubview:_webImageView];
    _webImageView.top = _organizator.bottom + kCellInsideMagin;
    _webImageView.left = kCellOutsideMagin;
    
    
    
    //prorgess of dowloading fundingImage
    CGFloat lineHeight = 4;
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.size = CGSizeMake(_webImageView.width, lineHeight);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, _progressLayer.height/2)];
    [path addLineToPoint:CGPointMake(_webImageView.width, _progressLayer.height*0.5)];
    _progressLayer.lineWidth = lineHeight;
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0 green:0.64 blue:1 alpha:0.7].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    [_webImageView.layer addSublayer:_progressLayer];
    
    _name  = [[UILabel alloc] init];
    _name.backgroundColor = [UIColor  whiteColor];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.font = [UIFont boldSystemFontOfSize:14];
    _name.textColor = [UIColor blackColor];
    [_fundingItemView addSubview:_name];

    
    _digest  = [[UILabel alloc] init];
    _digest.numberOfLines = 4;
    _digest.font = [UIFont appFontSize12];
    _digest.textColor = [UIColor customGrayColor];
    [_fundingItemView addSubview:_digest];
    
    
    /******           end         ******/
    /****** setUp subViews of commetsView ******/
    _commentsView = [[UIView alloc] init];
    _commentsView.backgroundColor = [UIColor whiteColor];
    

    [self.contentView addSubview:_commentsView];
    UITapGestureRecognizer *tapCommentsDetail = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        FCHandleBlock(_tapCommentsDetailBlock);
    }];
    [_commentsView addGestureRecognizer:tapCommentsDetail];
    _lineTop = [[UIView alloc] init];
    _lineTop.backgroundColor = [UIColor lightGrayColor];
    _lineTop.alpha = 0.7;
    _lineTop.size = CGSizeMake(kScreenWidth - 2 *kCellOutsideMagin, 0.5);
    [_commentsView addSubview:_lineTop];
    _lineTop.top =  kCellInsideMagin;
    _lineTop.left = kCellOutsideMagin;
    
    
    _comment1_header = [[UIImageView alloc] init];
    _comment1_header.clipsToBounds = YES;
    _comment1_header.layer.cornerRadius = 10;
    _comment1_header.size = CGSizeMake(20, 20);
    [_commentsView addSubview:_comment1_header];
    _comment1_header.top = _lineTop.bottom + kCellInsideMagin;
    _comment1_header.left = kCellOutsideMagin;

    
    _comment1_content = [[UILabel alloc] init];
    _comment1_content.font = [UIFont appFontSize12];
    _comment1_content.textColor = [UIColor customGrayColor];
    _comment1_content.textAlignment = NSTextAlignmentLeft;
    [_commentsView addSubview:_comment1_content];
   
    
    _comment2_header = [[UIImageView alloc] init];
    _comment2_header.clipsToBounds = YES;
    _comment2_header.layer.cornerRadius = 10;
    _comment2_header.size = _comment1_header.size;
    [_commentsView addSubview:_comment2_header];
    _comment2_header.top = _comment1_header.bottom + kCellInsideMagin;
    _comment2_header.left = _comment1_header.left;
    
    
    _comment2_content = [[UILabel alloc] init];
    _comment2_content.font = [UIFont appFontSize12];
    _comment2_content.textColor = [UIColor customGrayColor];
    _comment2_content.textAlignment = NSTextAlignmentLeft;
    [_commentsView addSubview:_comment2_content];
    
    
    _commentsNum = [[UILabel alloc] init];
    _commentsNum.font = [UIFont appFontSize12];
    _commentsNum.textColor = [UIColor customGrayColor];
    [_commentsView addSubview:_commentsNum];
    
    _linebottom = [[UIView alloc] init];
    _linebottom.backgroundColor = [UIColor lightGrayColor];
    _linebottom.alpha = 0.7;
    [_commentsView addSubview:_linebottom];
    _linebottom.left = _lineTop.left;
    
    _linebottom.size = _lineTop.size;
    
    
    
    /******           end         ******/

}

- (void)setFundingItem:(FCFundingItem *)fundingItem {
    if (_fundingItem!=fundingItem) {
        _fundingItem = fundingItem;
        [self loadUI];
        [self updateUI];
    }
}
- (void)updateUI {
    _organizator.text = [NSString stringWithFormat:@"发起人:%@",_fundingItem.nick];
    _favorNum.text = [NSString stringWithFormat:@"%d",(int)_fundingItem.like_num];
    //set _favorNum frame
    [_favorNum sizeToFit];
    _favorNum.right = kScreenWidth - 2*kCellOutsideMagin;
    _favorNum.top = _organizator.top;
    //set _favor frame
    _favor.right =_favorNum.left - kCellInsideMagin;
    _favor.top = _favorNum.top;
    
    
    [self _setImageURL:[NSURL URLWithString:_fundingItem.pic]];
    _name.text = _fundingItem.name;
    _name.top = _webImageView.bottom + kCellOutsideMagin;
    _name.left = _name.right = kCellOutsideMagin;
    [_name sizeToFit];
    
    _digest.text = _fundingItem.digest;
    _digest.size = [_digest.text boundingRectWithSize:CGSizeMake(kScreenWidth - 2*kCellOutsideMagin, NSIntegerMax) withFont:[UIFont appFontSize12]];
    _digest.top = _name.bottom + kCellOutsideMagin;
    _digest.left = _digest.right = kCellOutsideMagin;
    
    //reset fundView
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    _fundingItemView.frame = CGRectMake(0, 0, kScreenWidth, _digest.bottom);
    
   __block FCComment *comment1 = nil;
    __block FCComment *comment2 = nil;
[_fundingItem.comments enumerateObjectsUsingBlock:^(FCComment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (idx == 0)comment1 = _fundingItem.comments[0];
    if (idx == 1)comment2 = _fundingItem.comments[1];
}];
    
    
    
    [_comment1_header setImageWithURL:[NSURL URLWithString:comment1.comments_header] options:YYWebImageOptionIgnoreDiskCache];
    _comment1_content.text = comment1.comments_content;
    _comment1_content.top = _comment1_header.top;
    _comment1_content.left = _comment1_header.right + kCellInsideMagin;
    _comment1_content.size = CGSizeMake(kScreenWidth - 2 * kCellOutsideMagin - _comment1_header.right, _comment1_header.height);
    _comment1_content.numberOfLines = 1;
    
    [_comment2_header setImageWithURL:[NSURL URLWithString:comment2.comments_header] options:YYWebImageOptionIgnoreDiskCache];
    _comment2_content.text = comment2.comments_content;
    _comment2_content.left = _comment2_header.right + kCellInsideMagin;
    _comment2_content.size = CGSizeMake(kScreenWidth - 2 * kCellOutsideMagin - _comment2_header.right, _comment1_header.height);
    _comment2_content.numberOfLines = 1;
    _comment2_content.top = _comment2_header.top;

    _commentsView.frame = CGRectMake(0, _fundingItemView.bottom + kCellOutsideMagin, kScreenWidth, 80);
    _linebottom.bottom = _commentsView.height - kCellInsideMagin ;
    _commentsNum.text = [NSString stringWithFormat:@"%d条评论",(int)_fundingItem.comm_num];
    //set _commetsNum frame
    [_commentsNum sizeToFit];
    _commentsNum.right = kScreenWidth - kCellOutsideMagin;
    _commentsNum.bottom = _commentsView.height - kCellOutsideMagin;
    

    


}

- (void)_setImageURL:(NSURL *)imageUrl {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    __weak typeof(self) _self = self;
    [_webImageView setImageWithURL:imageUrl placeholder:[UIImage imageNamed:@"Freeze"] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionShowNetworkActivity|YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (expectedSize > 0 && receivedSize > 0) {
            CGFloat progress = (CGFloat)receivedSize/expectedSize;
            progress = progress < 0 ? 0:progress > 1 ? 1 : progress;
            if (_self.progressLayer.hidden) {
                _self.progressLayer.hidden = NO; }
            _self.progressLayer.strokeEnd = progress;
            
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (stage == YYWebImageStageFinished) {
            _self.progressLayer.hidden = YES;
        }
    }];
    
}

@end
