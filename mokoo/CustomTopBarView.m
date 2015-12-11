//
//  CustomTopBarView.m
//  mokoo
//
//  Created by Mac on 14-12-15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CustomTopBarView.h"
#import "MokooMacro.h"

@implementation CustomTopBarView

#define selfHeight self.frame.size.height
#define selfWidth  self.frame.size.width
#define titleFont 17.0
#define faFont 18.0

- (id)initWithTitle:(NSString *)title
{
    CGRect frame = CGRectMake(0, 0, kDeviceWidth, 64);
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViewsWithTitle:title];
    }
    [self setBackgroundColor:topBarBgColor];
    return self;
}

- (void)initSubViewsWithTitle:(NSString *)title{
    float strWidth = [self widthForString:title fontSize:titleFont];
    float strTitleWidth = [self widthForString:title fontSize:faFont];
    //sidebar按钮
    _menuImgBtn = [[UIButton alloc]init];
    _menuImgBtn.frame = CGRectMake(16, 36, 14, 13);
//    [_menuImgBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_menuImgBtn :@"fa-bars" :btnColor :24];
    [_menuImgBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"] forState:UIControlStateNormal];
    [_menuImgBtn addTarget:self action:@selector(menuImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_menuImgBtn];
    _menuImgBtn.hidden = true;
    
    //back按钮
    _backImgBtn = [[UIButton alloc]init];
    _backImgBtn.frame = CGRectMake(16, 35, 8, 13);
//    [_backImgBtn setImage:[UIImage imageNamed:@"event_click_back.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_backImgBtn :@"fa-long-arrow-left" :btnColor :18];
    [_backImgBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"] forState:UIControlStateNormal];
    [_backImgBtn addTarget:self action:@selector(backImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backImgBtn];
    _backImgBtn.hidden = true;
    
    //左侧title
    _leftTitle = [[UILabel alloc]init];
    _leftTitle.frame = CGRectMake(45, 20, strTitleWidth+5, 35);
    [_leftTitle setFont:[UIFont fontWithName:@"Helvetica" size:faFont]];
    [_leftTitle setNumberOfLines:1];
    [_leftTitle setTextColor:btnColor];
    [_leftTitle setText:title];
    [self addSubview:_leftTitle];
    _leftTitle.hidden = true;
    
    //搜索选择器
    _searchSelector = [[UIButton alloc]init];
    _searchSelector.frame = CGRectMake(50+strTitleWidth, 28, 45, 20);
    [_searchSelector setFont:[UIFont fontWithName:@"Helvetica" size:titleFont]];
    [_searchSelector setTitleColor:btnColor forState:UIControlStateNormal];
    [_searchSelector setTitle:@"全部" forState:UIControlStateNormal];
    [_searchSelector setImage:[UIImage imageNamed:@"spinner_bg_pressed3.9.png"] forState:UIControlStateNormal];
    [_searchSelector setTitleEdgeInsets:UIEdgeInsetsMake(5, -70, 0, 0)];
    [_searchSelector setImageEdgeInsets:UIEdgeInsetsMake(5, 18, 0, 0)];
    [_searchSelector addTarget:self action:@selector(searchSelectorClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchSelector];
    _searchSelector.hidden = true;
    
    //中间title
    _midTitle = [[UILabel alloc]init];
    _midTitle.frame = CGRectMake(45, 25, strWidth+5, 30);
    _midTitle.center = CGPointMake(selfWidth/2, selfHeight/2+10);
    [_midTitle setFont:[UIFont fontWithName:@"Helvetica" size:titleFont]];
    [_midTitle setNumberOfLines:1];
    [_midTitle setTextColor:[UIColor blackColor]];
    [_midTitle setText:title];
    [self addSubview:_midTitle];
    _midTitle.hidden = true;
    
    //更多按钮
    _moreImgBtn = [[UIButton alloc]init];
    _moreImgBtn.frame = CGRectMake(selfWidth-45, 20, 45, 35);
    [_moreImgBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
//    [_moreImgBtn setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_moreImgBtn :@"fa-ellipsis-h" :btnColor :18];
    [_moreImgBtn addTarget:self action:@selector(moreImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreImgBtn];
    _moreImgBtn.hidden = true;
    
    //提交按钮
    _applyImgBtn = [[UIButton alloc]init];
    _applyImgBtn.frame = CGRectMake(selfWidth-45, 20, 45, 35);
    [_applyImgBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
//    [_applyImgBtn setImage:[UIImage imageNamed:@"apply_btn.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_applyImgBtn :@"fa-check" :btnColor :18];
    [_applyImgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_applyImgBtn addTarget:self action:@selector(applyImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_applyImgBtn];
    _applyImgBtn.hidden = true;
    
    //搜索按钮
    _searchImgBtn = [[UIButton alloc]init];
    _searchImgBtn.frame = CGRectMake(selfWidth-85, 20, 45, 35);
    [_searchImgBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
//    [_searchImgBtn setImage:[UIImage imageNamed:@"common_search_bg.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_searchImgBtn :@"fa-search" :btnColor :24];
    [_searchImgBtn addTarget:self action:@selector(searchImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchImgBtn];
    _searchImgBtn.hidden = true;
    
    //排序按钮
    _sortImgBtn = [[UIButton alloc]init];
    _sortImgBtn.frame = CGRectMake(selfWidth-125, 20, 45, 35);
    [_sortImgBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
//    [_sortImgBtn setImage:[UIImage imageNamed:@"sort_img.png"] forState:UIControlStateNormal];
//    [WiseApplicationViewController showFontAwesomeIcon:_sortImgBtn :@"fa-long-arrow-down" :btnColor :24];
    [_sortImgBtn addTarget:self action:@selector(sortImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sortImgBtn];
    _sortImgBtn.hidden = true;
    
    //编辑按钮
    _editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _editBtn.frame = CGRectMake(selfWidth-55, 30, 45, 23);
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self setButtonBorder:_editBtn];
    [_editBtn addTarget:self action:@selector(editBtnClicked:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editBtn];
    _editBtn.hidden = true;
    
    //保存按钮
    _saveBtn = [[UIButton alloc]init];
    _saveBtn.frame = CGRectMake(selfWidth-55, 30, 45, 23);
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setButtonBorder:_saveBtn];
    [_saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveBtn];
    _saveBtn.hidden = true;
    
    //底部横线
    _underLine = [[UILabel alloc]init];
    _underLine.frame = CGRectMake(0, 63.5f, selfWidth, 0.5f);
    [_underLine setBackgroundColor:boardColor];
    [self addSubview:_underLine];
}

#pragma mark 设置按钮边框
- (void)setButtonBorder:(UIButton *)btn{
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [dark_gray CGColor];
    btn.layer.cornerRadius = 10;
}

#pragma mark 通过给定字符串和字体大小计算字符串长度
- (float) widthForString: (NSString *)str fontSize: (float)fontSize{
    
    CGSize sizeToFit = [str sizeWithFont: [UIFont systemFontOfSize: fontSize]
                       constrainedToSize: CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                           lineBreakMode: NSLineBreakByWordWrapping]; // 可根据具体需求设置lineBreakMode
    return sizeToFit.width;
}

- (void)menuImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(menuBtnClicked)]) {
        [_delegate menuBtnClicked];
    }
}

- (void)backImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(backBtnClicked)]) {
        [_delegate backBtnClicked];
    }
}

- (void)searchSelectorClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(selectorClicked)]) {
        [_delegate selectorClicked];
    }
}

- (void)moreImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(moreBtnClicked)]) {
        [_delegate moreBtnClicked];
    }
}

- (void)searchImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(searchBtnClicked)]) {
        [_delegate searchBtnClicked];
    }
}

- (void)applyImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(applyBtnClicked)]) {
        [_delegate applyBtnClicked];
    }
}

- (void)sortImgBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(sortBtnClicked)]) {
        [_delegate sortBtnClicked];
    }
}

- (void)editBtnClicked:(id)sende forEvent:(UIEvent *)event{
    if ([_delegate respondsToSelector:@selector(editBtnClicked:forEvent:)]) {
        [_delegate editBtnClicked:sende forEvent:event];
    }
}

- (void)saveBtnClicked:(id)sende{
    if ([_delegate respondsToSelector:@selector(saveBtnClicked)]) {
        [_delegate saveBtnClicked];
    }
}

@end
