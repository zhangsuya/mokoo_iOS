//
//  DemoTextField.m
//  MHTextField
//
//  Created by Mehfuz Hossain on 12/3/13.
//  Copyright (c) 2013 Mehfuz Hossain. All rights reserved.
//

#import "DemoTextField.h"
#import "MokooMacro.h"
@implementation DemoTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBorderStyle:UITextBorderStyleNone];
    
    [self setFont: [UIFont systemFontOfSize:15]];
//    [self setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    return CGRectInset(bounds, 10, 7.5f);
    //    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width, bounds.size.height/2);//更好理解些
    //    return inset;
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 6);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 6);
}

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

- (void) drawPlaceholderInRect:(CGRect)rect {
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0]};
     //5,6
    [self.placeholder drawInRect:CGRectInset(rect, 0, 0) withAttributes:attributes];
}

@end
