//
//  CustomTextField.m
//  mokoo
//
//  Created by Mac on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "CustomTextField.h"
#import "MokooMacro.h"
@implementation CustomTextField
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBorderStyle:UITextBorderStyleNone];
    
//    [self setFont: [UIFont systemFontOfSize:17]];
    //    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 16, bounds.origin.y + bounds.size.height -20, 16, 16);
//}
- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    [layer setBorderWidth: 0.5];
    //    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
    [layer setBorderColor:textFieldBoardColor.CGColor];
    //    [layer setCornerRadius:3.0];
//    [layer setShadowOpacity:1.0];
//    [layer setShadowColor:[UIColor redColor].CGColor];
//    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    return CGRectInset(bounds, 16, 12);
//    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width, bounds.size.height/2);//更好理解些
//    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 16, 12);
//    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y , bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
    
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds, 16 , 12 );
    
//    CGRect inset = CGRectMake(bounds.origin.x +16, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    return inset;
    //return CGRectInset(bounds,50,0);
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [placehoderFontColor setFill];
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
    [self.placeholder drawInRect:CGRectInset(rect,0,0) withAttributes:attributes];
}
@end
