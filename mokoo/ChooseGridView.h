//
//  ChooseGridView.h
//  mokoo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseGridView;
@interface ChooseGridView : UIView
@property (nonatomic,strong)UIButton *nameBtn;
@property (nonatomic,strong)UIScrollView *contentScrollView;
-(id)initWithTitleArray:(NSArray *)titleArray;
@end
