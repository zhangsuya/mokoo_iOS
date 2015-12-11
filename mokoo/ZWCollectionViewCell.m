//
//  ZWCollectionViewCell.m
//  瀑布流demo
//
//  Created by yuxin on 15/6/6.
//  Copyright (c) 2015年 yuxin. All rights reserved.
//

#import "ZWCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageBlur.h"
//#import "UIImage+WebCache.h"
@implementation ZWCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setShop:(HomeModel *)shop
{
    _shop = shop;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:_shop.model_img]];
//    [self insertColorGradientByUIImageView:self.shopImage];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.shopName.text = _shop.city;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_shop.user_img]];
    [self.shopImage addSubview:self.avatarImageView];
    if ([_shop.is_verify isEqualToString:@"0"]) {
        self.vImageView.hidden = YES;
    }
    [self.shopImage addSubview:self.vImageView];
    [self.nameLabel setText:_shop.nick_name];
    [self.shopImage addSubview:self.nameLabel];
    [self.shopImage addSubview:self.locationImageView];
    [self.locationLabel setText:_shop.city];
    [self.shopImage addSubview:self.locationLabel];

}


- (UIImage*) BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame
{
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        
        [ar addObject:(id)c.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    
    
    start = CGPointMake(0.0, frame.size.height);
    
    end = CGPointMake(frame.size.width, 0.0);
    
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
    
    
}
- (UIImage *) addImageToImage:(UIImage *)img withImage2:(UIImage *)img2 andRect:(CGRect)cropRect{
    
    CGSize size = CGSizeMake(self.shopImage.image.size.width, self.shopImage.image.size.height);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [img drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img2 drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
- (UIImage *)roundedRectImageFromImage:(UIImage *)image withRadious:(CGFloat)radious {
    
    if(radious == 0.0f)
        return image;
    
    if( image != nil) {
        
        CGFloat imageWidth = image.size.width;
        CGFloat imageHeight = image.size.height;
        
        CGRect rect = CGRectMake(0.0f, 0.0f, imageWidth, imageHeight);
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        const CGFloat scale = window.screen.scale;
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        CGContextSaveGState(context);
        CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM (context, radious, radious);
        
        CGFloat rectWidth = CGRectGetWidth (rect)/radious;
        CGFloat rectHeight = CGRectGetHeight (rect)/radious;
        
        CGContextMoveToPoint(context, rectWidth, rectHeight/2.0f);
        CGContextAddArcToPoint(context, rectWidth, rectHeight, rectWidth/2.0f, rectHeight, radious);
        CGContextAddArcToPoint(context, 0.0f, rectHeight, 0.0f, rectHeight/2.0f, radious);
        CGContextAddArcToPoint(context, 0.0f, 0.0f, rectWidth/2.0f, 0.0f, radious);
        CGContextAddArcToPoint(context, rectWidth, 0.0f, rectWidth, rectHeight/2.0f, radious);
        CGContextRestoreGState(context);
        CGContextClosePath(context);
        CGContextClip(context);
        
        [image drawInRect:CGRectMake(0.0f, 0.0f, imageWidth, imageHeight)];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    } 
    return nil;
}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    
//    UIImage *croppedImg = nil;
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.imageView];
//    
//    double ratioW=imageView.image.size.width/imageView.frame.size.width ;
//    
//    double ratioH=imageView.image.size.height/imageView.frame.size.height;
//    
//    currentPoint.x *= ratioW;
//    currentPoint.y *= ratioH;
//    
//    double circleSizeW = 30 * ratioW;
//    double circleSizeH = 30 * ratioH;
//    
//    
//    currentPoint.x = (currentPoint.x - circleSizeW/2<0)? 0 : currentPoint.x - circleSizeW/2;
//    currentPoint.y = (currentPoint.y - circleSizeH/2<0)? 0 : currentPoint.y - circleSizeH/2;
//    
//    
//    CGRect cropRect = CGRectMake(currentPoint.x , currentPoint.y,   circleSizeW,  circleSizeH);
//    
//    NSLog(@"x %0.0f, y %0.0f, width %0.0f, height %0.0f", cropRect.origin.x, cropRect.origin.y,   cropRect.size.width,  cropRect.size.height );
//    
//    croppedImg = [self croppIngimageByImageName:self.imageView.image toRect:cropRect];
//    
//    // Blur Effect
//    croppedImg = [croppedImg imageWithGaussianBlur9];
//    
//    // Contrast Effect
//    // croppedImg = [croppedImg imageWithContrast:50];
//    
//    
//    
//    croppedImg = [self roundedRectImageFromImage:croppedImg withRadious:4];
//    
//    imageView.image = [self addImageToImage:imageView.image withImage2:croppedImg andRect:cropRect];
//} 

@end
