//
//  HomeChooseTextField.m
//  mokoo
//
//  Created by Mac on 15/9/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "HomeChooseTextField.h"
#import "MokooMacro.h"
@implementation HomeChooseTextField

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
    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

//- (CGRect)textRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 10, 5);
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 10, 5);
//}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    [layer setBorderWidth: 0.5];
    [layer setBorderColor: textFieldBoardColor.CGColor];
//
//    [layer setCornerRadius:3.0];
//    [layer setShadowOpacity:0];
//    [layer setShadowColor:[UIColor redColor].CGColor];
//    [layer setShadowOffset:CGSizeMake(0, 0)];
}

//- (void) drawPlaceholderInRect:(CGRect)rect {
//    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
//    [self.placeholder drawInRect:CGRectInset(rect, 5, 5) withAttributes:attributes];
//}

@end
