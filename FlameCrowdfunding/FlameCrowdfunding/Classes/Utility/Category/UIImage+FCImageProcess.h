//
//  UIImage+FCImageProcess.h
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FCImageProcess)
//等比缩放
- (UIImage *)imageToScale:(CGFloat)scaleSize;
//自定义长宽
- (UIImage *)resizeImageToSize:(CGSize)size;
- (UIImage *)capture:(UIView *)view;
@end
