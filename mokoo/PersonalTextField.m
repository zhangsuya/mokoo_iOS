//
//  PersonalTextField.m
//  mokoo
//
//  Created by Mac on 15/9/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "PersonalTextField.h"
#import "MokooMacro.h"
@implementation PersonalTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBorderStyle:UITextBorderStyleNone];
    [self setTextColor:placehoderFontColor];
    [self setFont: [UIFont systemFontOfSize:14]];
//    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
//    [self setBackgroundColor:[UIColor whiteColor]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
////    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width , 5);
////    return inset;
//    return CGRectInset(bounds, 10, 5);
//}
////控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 50, 0);
////    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y , 50 , 5);//更好理解些
////    
////    return inset;
//    return CGRectInset(bounds, 10, 5);
//}
@end
