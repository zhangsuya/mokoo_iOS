//
//  HomeTwoPageHeadView.m
//  mokoo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "HomeTwoPageHeadView.h"
#import "MokooMacro.h"
@implementation HomeTwoPageHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *styleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/3, 38)];
        [self addSubview:styleView];
        UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/3, 0, kDeviceWidth/3, 38)];
        [self addSubview:typeView];
        UIView *moreView = [[UIView alloc]initWithFrame:CGRectMake(2*kDeviceWidth/3, 0, kDeviceWidth/3, 38)];
        [self addSubview:moreView];
        _styleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/4, 38)];
        _styleBtn.center = CGPointMake(kDeviceWidth/6, 38/2);
        [_styleBtn setTitle:@"风格" forState:UIControlStateNormal];
        [_styleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_styleBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        UIImageView *styleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/8 +35, 17, 9, 5)];
        styleImageView.image = [UIImage imageNamed:@"home_re_arrow_down.pdf"];
        [_styleBtn addSubview:styleImageView];
        //        [_styleBtn setImage:[UIImage imageNamed:@"home_re_arrow_down.pdf"] forState:UIControlStateNormal];
        CALayer *lineLayer = [[CALayer alloc]init];
        lineLayer.backgroundColor = [boardColor CGColor];
        lineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
        CALayer *typeLineLayer = [[CALayer alloc]init];
        typeLineLayer.backgroundColor = [boardColor CGColor];
        typeLineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
        
        CALayer *moreLineLayer = [[CALayer alloc]init];
        moreLineLayer.backgroundColor = [boardColor CGColor];
        moreLineLayer.frame = CGRectMake(kDeviceWidth/3-1, 10, 1, 18);
        
        [styleView.layer addSublayer:lineLayer];
        //        [_styleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 9)];
        //        [_styleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _styleBtn.titleLabel.bounds.size.width, 0, -_styleBtn.titleLabel.bounds.size.width)];
        
        _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/4, 38)];
        _typeBtn.center = CGPointMake(kDeviceWidth/6, 38/2);
        [_typeBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        [_typeBtn setTitle:@"类型" forState:UIControlStateNormal];
        [_typeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIImageView *typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/8 +35, 16, 9, 5)];
        typeImageView.image = [UIImage imageNamed:@"home_re_arrow_down.pdf"];
        //        [_typeBtn setImage:[UIImage imageNamed:@"home_re_arrow_down.pdf"] forState:UIControlStateNormal];
        [_typeBtn addSubview:typeImageView];
        [typeView.layer addSublayer:typeLineLayer];
        [typeView addSubview:_typeBtn];
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/4, 38)];
        _moreBtn.center = CGPointMake(kDeviceWidth/6 +13, 38/2);
        [_moreBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
        [_moreBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_moreBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        //        UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/8 +25, 16, 9, 5)];
        //        moreImageView.image = [UIImage imageNamed:@"home_re_arrow_down.pdf"];
        //        [_moreBtn addSubview:moreImageView];
        UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 11, 16, 16)];
        moreImageView.image = [UIImage imageNamed:@"home_refine.pdf"];
        [_moreBtn addSubview:moreImageView];
        //        [_moreBtn setImage:[UIImage imageNamed:@"home_refine.pdf"] forState:UIControlStateNormal];
        [moreView.layer addSublayer:moreLineLayer];
        [moreView addSubview:_moreBtn];
        [styleView addSubview:_styleBtn];
        CALayer *lineBoLayer = [[CALayer alloc]init];
        lineBoLayer.frame = CGRectMake(0, 37.5f, kDeviceWidth, 0.5f);
        lineBoLayer.backgroundColor = [boardColor CGColor];
        [self.layer addSublayer:lineBoLayer];
        self.backgroundColor = whiteFontColor;
    }
    return self;
}

@end
