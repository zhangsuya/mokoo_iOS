//
//  SGChooseMenu.m
//  mokoo
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SGChooseMenu.h"
#import <QuartzCore/QuartzCore.h>
#include "MokooMacro.h"
#import "MBProgressHUD.h"
#define kMAX_CONTENT_SCROLLVIEW_HEIGHT   400

@interface SGGridItems : UIButton
@property (nonatomic, weak) SGChooseMenu *menu;
@property (nonatomic)BOOL isSelected;
@end

@implementation SGGridItems

- (id)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.clipsToBounds = NO;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        //        [self setBackgroundImage:[UIImage imageNamed:@"refine_box_b.pdf"] forState:UIControlStateNormal];
        //        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setTextColor:boardColor];
        [self setTitle:title forState:UIControlStateNormal];
        //        [self setTitleColor:boardColor forState:UIControlStateNormal];
        //        [self setImage:image forState:UIControlStateNormal];
        [self.layer setBorderWidth:0.5];
        [self.layer setBorderColor:[boardColor CGColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
@interface SGChooseMenu()
@property (nonatomic, strong) UIButton *titleLabel;
@property (nonatomic,strong) NSMutableArray *selectedArray;
@property (nonatomic,strong) UIButton *selectBtn;
//@property (nonatomic, strong)
@property (nonatomic, strong) UIScrollView *contentScrollView;
//@property (nonatomic, strong) SGButton *cancelButton;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic,assign) NSUInteger limitNum;
@property (nonatomic,strong) UIButton *submiteBtn;

@property (nonatomic, strong) void (^actionHandle)(NSArray *);
@end
@implementation SGChooseMenu
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BaseMenuBackgroundColor(self.style);
        
        _itemTitles = [NSArray array];
        _itemImages = [NSArray array];
        _items = [NSArray array];
        _selectedArray = [NSMutableArray array];
        _titleLabel = [[UIButton alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        //        [_titleLabel setTitleColor:grayFontColor forState:UIControlStateNormal];
        //        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        //        _titleLabel.textAlignment = NSTextAlignmentCenter;
        //        _titleLabel.textColor = BaseMenuTextColor(self.style);
        [self addSubview:_titleLabel];
        
        _submiteBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_submiteBtn setImage:[UIImage imageNamed:@"refine_right.pdf"] forState:UIControlStateNormal];
        [_submiteBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _contentScrollView.contentSize = _contentScrollView.bounds.size;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = YES;
        _contentScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentScrollView];
        [_contentScrollView addSubview:_submiteBtn];
        [_titleLabel addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
  
    }
    return self;
}

- (id)initWithTitle:(NSArray *)selectedTitles itemTitles:(NSArray *)itemTitles limitedNum:(NSInteger) num
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        NSInteger count = itemTitles.count;
        [_titleLabel setImage:[UIImage imageNamed:@"close.pdf"] forState:UIControlStateNormal];
        _itemTitles = [itemTitles subarrayWithRange:NSMakeRange(0, count)];
        self.limitNum = num;
        [self setupWithItemTitles:_itemTitles withSelectedTitles:selectedTitles ];
    }
    return self;
}

- (void)setupWithItemTitles:(NSArray *)titles withSelectedTitles:(NSArray *)selectedTitles
{
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        SGGridItems *item = [[SGGridItems alloc] initWithTitle:titles[i] ];
        item.menu = self;
        item.tag = i;
        for (int i =0; i < [selectedTitles count]; i++) {
            if ([item.titleLabel.text isEqualToString:selectedTitles[i]]) {
                [self selectButton:(SGGridItems *)item];
            }
        }
        
        [item addTarget:self
                 action:@selector(tapAction:)
       forControlEvents:UIControlEventTouchUpInside];
        [items addObject:item];
        [_contentScrollView addSubview:item];
    }
    _items = [NSArray arrayWithArray:items];
}

- (void)setStyle:(SGActionViewStyle)style{
    _style = style;
    
    self.backgroundColor = BaseMenuBackgroundColor(style);
    //    self.titleLabel.textColor = BaseMenuTextColor(style);
    //    [self.cancelButton setTitleColor:BaseMenuActionTextColor(style) forState:UIControlStateNormal];
    for (SGGridItems *item in self.items) {
        [item setTitleColor:BaseMenuTextColor(style) forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = (CGRect){CGPointMake(self.bounds.size.width - 13 -14, 14), CGSizeMake(13 , 13)};
    
    [self layoutContentScrollView];
    if (kDeviceHeight ==568) {
        self.contentScrollView.frame = (CGRect){CGPointMake(0, 65), self.contentScrollView.bounds.size.width,kDeviceHeight -173 -35};
    }
    else
    {
        self.contentScrollView.frame = (CGRect){CGPointMake(0, 65), self.contentScrollView.bounds.size.width,kDeviceHeight -173 -65};
    }
    
    
    //    self.cancelButton.frame = CGRectMake(self.bounds.size.width*0.05, 65 + self.contentScrollView.bounds.size.height, self.bounds.size.width*0.9, 44);
    
    //    self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , 65 + self.contentScrollView.bounds.size.height + self.cancelButton.bounds.size.height)};
    self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , 65 + self.contentScrollView.bounds.size.height)};
    
}

- (void)layoutContentScrollView
{
    UIEdgeInsets margin = UIEdgeInsetsMake(8, 15, 8, 15);
    //    CGSize itemSize = CGSizeMake((self.bounds.size.width - margin.left - margin.right) / 4, 85);
    CGSize itemSize = CGSizeMake((self.bounds.size.width -60 -15)/3 , 30);
    NSInteger itemCount = self.items.count;
    NSInteger rowCount = ((itemCount-1) / 3) + 1;
    self.submiteBtn.frame = (CGRect){CGPointMake((kDeviceWidth - 32)/2 -22.5, rowCount * (itemSize.height + margin.bottom) +27), 45,45};
    self.contentScrollView.contentSize = CGSizeMake(self.bounds.size.width, rowCount * (itemSize.height  + margin.bottom)+ 72 + margin.top);
    for (int i=0; i<itemCount; i++) {
        SGGridItems *item = self.items[i];
        int row = i / 3;
        int column = i % 3;
        CGPoint p = CGPointMake(margin.left*(column +2) + column * itemSize.width, margin.top*row + row * itemSize.height);
        item.frame = (CGRect){p, itemSize};
        [item layoutIfNeeded];
    }
    
    if (self.contentScrollView.contentSize.height > kMAX_CONTENT_SCROLLVIEW_HEIGHT) {
        self.contentScrollView.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, kMAX_CONTENT_SCROLLVIEW_HEIGHT)};
    }else{
        self.contentScrollView.bounds = (CGRect){CGPointZero, self.contentScrollView.contentSize};
    }
}

#pragma mark -

- (void)triggerSelectedAction:(void (^)(NSArray *))actionHandle
{
    self.actionHandle = actionHandle;
}

#pragma mark -

- (void)tapAction:(id)sender
{
    if (self.actionHandle) {
        if ([sender isEqual:self.titleLabel]) {
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                self.actionHandle(0);
                self.actionHandle(_selectedArray);
            });
        }else if ([sender isEqual:self.submiteBtn])
        {
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.actionHandle(_selectedArray);
            });
        }
        else{
            
            [self selectButton:(SGGridItems *)sender];
            
        }
    }
}
- (void)selectButton:(SGGridItems *)button
{
    if (button.isSelected==NO) {
        if ([_selectedArray count] <_limitNum) {
            
            button.isSelected = YES;
            [button setTitleColor:blackFontColor forState:UIControlStateNormal];
            [button.layer setBorderColor:[blackFontColor CGColor]];
            [_selectedArray addObject:button.titleLabel.text];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.superview animated:YES];
            //            hud.labelText = ;
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [NSString stringWithFormat:@"最多选择%lu种",(unsigned long)_limitNum];
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
        
        
    }else if (button.isSelected==YES)
    {
        button.isSelected = NO;
//        [button setTitleColor:boardColor forState:UIControlStateNormal];
        [button.layer setBorderColor:[boardColor CGColor]];
        [_selectedArray removeObject:button.titleLabel.text];
    }
    
//    if (_selectBtn) {
//        _selectBtn.selected = NO;
//        [_selectBtn setTitleColor:boardColor forState:UIControlStateNormal];
//        [_selectBtn.layer setBorderColor:[boardColor CGColor]];
//        
//        //        _selectBtn.titleLabel. = _textFont;
//    }
//    _selectBtn = button;
//    
//    //    CGRect frame = _horIndicator.frame;
//    //    frame.origin.x = CGRectGetMinX(_selectBtn.frame) +CGRectGetWidth(_selectBtn.frame)/2 -27.5;
//    //    [UIView animateWithDuration:0.2 animations:^{
//    //        _horIndicator.frame = frame;
//    //
//    //    }];
//    
//    _selectBtn.selected = YES;
//    [_selectBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
//    [_selectBtn.layer setBorderColor:[blackFontColor CGColor]];
    //    _selectBtn.titleLabel.font = _selectedTextFont;
}
- (void)submiteBtnClicked:(UIButton *)btn
{
    
}
@end
