//
//  UILeftTitleButton.h
//  mokoo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILeftTitleButton : UIButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect;
- (CGRect)titleRectForContentRect:(CGRect)contentRect;

@end
