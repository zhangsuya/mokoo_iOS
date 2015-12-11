//
//  LeftViewTextField.m
//  mokoo
//
//  Created by Mac on 15/11/6.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "LeftViewTextField.h"
#import "MokooMacro.h"

@implementation LeftViewTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    [self setBorderStyle:UITextBorderStyleNone];
    
    [self setFont: [UIFont systemFontOfSize:15]];
    //    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

//- (void)layoutSublayersOfLayer:(CALayer *)layer
//{
//    [super layoutSublayersOfLayer:layer];
//    
//    [layer setBorderWidth: 0.5];
//    //    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
//    [layer setBorderColor:textFieldBoardColor.CGColor];
//    //    [layer setCornerRadius:3.0];
//    //    [layer setShadowOpacity:1.0];
//    //    [layer setShadowColor:[UIColor redColor].CGColor];
//    //    [layer setShadowOffset:CGSizeMake(1.0, 1.0)];
//}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    return CGRectInset(bounds, 32, 8.8f);
    //    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width, bounds.size.height/2);//更好理解些
    //    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 32, 6);
//        CGRect inset = CGRectMake(bounds.origin.x+32, 17.5f , bounds.size.width -32, bounds.size.height);//更好理解些
    //
//        return inset;
    
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds, 32 , 6 );
    
    //    CGRect inset = CGRectMake(bounds.origin.x +16, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    //    return inset;
}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +11, bounds.origin.y +15.5f, 13, 13);
    return inset;
//    return CGRectInset(bounds,16,12);
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
