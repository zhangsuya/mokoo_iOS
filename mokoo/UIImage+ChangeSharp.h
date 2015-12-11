//
//  UIImage+ChangeSharp.h
//  mokoo
//
//  Created by Mac on 15/8/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ChangeSharp)
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
@end
