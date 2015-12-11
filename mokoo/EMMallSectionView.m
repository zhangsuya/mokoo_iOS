

//
//  EMMallSectionView.m
//  chexun
//
//  Created by macrong on 15/5/27.
//  Copyright (c) 2015年 macrong. All rights reserved.
//

#import "EMMallSectionView.h"
#import "MokooMacro.h"

@interface EMMallSectionView()

@end

@implementation EMMallSectionView

+ (EMMallSectionView *)showWithName:(CGFloat)height
{
    EMMallSectionView  *sectionView = [[EMMallSectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
    sectionView.backgroundColor = viewBgColor;
    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
//    CGRect        rect = [sectionName boundingRectWithSize:CGSizeMake(APP_SCREEN_WIDTH -20, 20)
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:attributes
//                                     context:nil];
//    CGFloat titleWidth = CGRectGetWidth(rect);
    
//    
//    // TITLE
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 22, APP_SCREEN_WIDTH - 20, 20)];
//    titleLabel.textColor = [UIColor blueColor];
//    titleLabel.text = sectionName;
//    titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    [sectionView addSubview:titleLabel];
//    
//    
//    // line_gray
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, sectionView.frame.size.height - 1, CGRectGetWidth(sectionView.frame) - 20, 1)];
//    lineView.backgroundColor = [UIColor grayColor];
//    [sectionView addSubview:lineView];
//    
//    // line_red
//    UIView *lineSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleWidth, 1)];
//    lineSelectView.backgroundColor = [UIColor redColor];
//    [lineView addSubview:lineSelectView];
    
    
    return sectionView;
}

+ (CGFloat)getSectionHeight
{
//    if (_section ==0) {
//        return 10;
//    }else
//    {
//        return 6;
//    }
    return 6;
}

- (void)setFrame:(CGRect)frame{
    NSLog(@"_______ frame = %@",NSStringFromCGRect(frame));

    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [super setFrame:newFrame];
}




@end
