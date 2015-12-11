//
//  ChooseGridView.m
//  mokoo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ChooseGridView.h"
#import "MokooMacro.h"
@implementation ChooseGridView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithTitleArray:(NSArray *)titleArray
{
    CGRect frame = CGRectMake(16, 90, kDeviceWidth -32, kDeviceHeight -90 -83);
    self = [super initWithFrame:frame];
    if (self) {
        if (![self superview]) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:self];
            window.backgroundColor = blackFontColor;
        }
    }
    self.backgroundColor = whiteFontColor;
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(14, 14, 13, 13)];
    [closeBtn setImage:[UIImage imageNamed:@"close.pdf"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 65, self.frame.size.width, self.frame.size.height -65)];
    _contentScrollView.contentSize = _contentScrollView.bounds.size;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = YES;
    _contentScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentScrollView];
    [self layoutContentScrollViewWithTitleArray:titleArray];
    return self;
}
-(void)layoutContentScrollViewWithTitleArray:(NSArray *)titleArray
{
    UIEdgeInsets margin = UIEdgeInsetsMake(0, 15, 8, 15);
    //    CGSize itemSize = CGSizeMake((self.bounds.size.width - margin.left - margin.right) / 4, 85);
    CGSize itemSize = CGSizeMake((kDeviceWidth -60)/3, 30);
    NSInteger itemCount = titleArray.count;
    NSInteger rowCount = ((itemCount-1) / 3) + 1;
    self.contentScrollView.contentSize = CGSizeMake(self.bounds.size.width, rowCount * itemSize.height + margin.top + margin.bottom);
    for (int i=0; i<itemCount; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [grayFontColor CGColor];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:grayFontColor forState:UIControlStateNormal];
        int row = i / 3;
        int column = i % 3;
        CGPoint p = CGPointMake(margin.left*(i +1) + column * itemSize.width, margin.top + row * itemSize.height);
        btn.frame = (CGRect){p, itemSize};
        [btn layoutIfNeeded];
    }

}
@end
