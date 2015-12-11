//
//  RightDefaultTextField.m
//  mokoo
//
//  Created by Mac on 15/10/8.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RightDefaultTextField.h"

@implementation RightDefaultTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
//return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y , 50 , 5);//更好理解些
//
//    return inset;
   return CGRectInset(bounds, 6, 0);
}

@end
