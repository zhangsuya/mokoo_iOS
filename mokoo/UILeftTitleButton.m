//
//  UILeftTitleButton.m
//  mokoo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "UILeftTitleButton.h"

@implementation UILeftTitleButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(30, 9, self.bounds.size.width/2, self.bounds.size.height);//图片的位置大小
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(60, 9, self.bounds.size.width/2, self.bounds.size.height);//文本的位置大小
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
