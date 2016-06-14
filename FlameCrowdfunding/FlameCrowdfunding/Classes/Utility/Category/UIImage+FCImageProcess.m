//
//  UIImage+FCImageProcess.m
//  FlameCrowdfunding
//
//  Created by JimmyOu on 16/5/10.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "UIImage+FCImageProcess.h"

@implementation UIImage (FCImageProcess)
- (UIImage *)imageToScale:(CGFloat)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(scaleSize*self.size.width, scaleSize*self.size.height));
    [self drawInRect:CGRectMake(0, 0, scaleSize*self.size.width, scaleSize*self.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)resizeImageToSize:(CGSize)size {

    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
- (UIImage *)capture:(UIView *)view {

    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
