//
//  SGGridMenu.m
//  SGActionView
//
//  Created by Sagi on 13-9-6.
//  Copyright (c) 2013年 AzureLab. All rights reserved.
//

#import "SGGridMenu.h"
#import <QuartzCore/QuartzCore.h>
#include "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#define kMAX_CONTENT_SCROLLVIEW_HEIGHT   400

@interface SGGridItem : UIButton
@property (nonatomic, weak) SGGridMenu *menu;
@end

@implementation SGGridItem

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
    
//    float width = self.bounds.size.width;
//    float height = self.bounds.size.height;
    
//    CGRect btnRect = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    CGRect imageRect = CGRectMake(width * 0.2, width * 0.2, width * 0.6, width * 0.6);
//    self.imageView.frame = imageRect;
    
//    float labelHeight = height - (imageRect.origin.y + imageRect.size.height);
//    CGRect labelRect = CGRectMake(width * 0.05, imageRect.origin.y + imageRect.size.height, width * 0.9, labelHeight);
//    self.titleLabel.frame = labelRect;
}

@end


@interface SGGridMenu ()
@property (nonatomic, strong) UIButton *titleLabel;
@property (nonatomic,strong)UIButton *allBtn;
@property (nonatomic,strong) UIButton *selectBtn;
//@property (nonatomic, strong)
@property (nonatomic, strong) UIScrollView *contentScrollView;
//@property (nonatomic, strong) SGButton *cancelButton;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic,copy)NSString *selecteTitle;
@property (nonatomic, strong) void (^actionHandle)(NSInteger);
@end

@implementation SGGridMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BaseMenuBackgroundColor(self.style);

        _itemTitles = [NSArray array];
        _itemImages = [NSArray array];
        _items = [NSArray array];
        
        _titleLabel = [[UIButton alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setEnlargeEdgeWithTop:10 right:10 bottom:20 left:20];
        [self addSubview:_titleLabel];
        _allBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        _allBtn.backgroundColor = [UIColor blackColor];
        [self addSubview:_allBtn];
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _contentScrollView.contentSize = _contentScrollView.bounds.size;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = YES;
        _contentScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentScrollView];
        [_titleLabel addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
//        _cancelButton = [SGButton buttonWithType:UIButtonTypeCustom];
//        _cancelButton.clipsToBounds = YES;
//        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
//        [_cancelButton setTitleColor:BaseMenuTextColor(self.style) forState:UIControlStateNormal];
//        [_cancelButton addTarget:self
//                          action:@selector(tapAction:)
//                forControlEvents:UIControlEventTouchUpInside];
//        [_cancelButton setTitle:@"取    消" forState:UIControlStateNormal];
//        [self addSubview:_cancelButton];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title itemTitles:(NSArray *)itemTitles
{
    
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        NSInteger count = itemTitles.count;
        _selecteTitle = title;
//        _titleLabel.text = title;
        [_titleLabel setImage:[UIImage imageNamed:@"close.pdf"] forState:UIControlStateNormal];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _itemTitles = [itemTitles subarrayWithRange:NSMakeRange(0, count)];
//        _itemImages = [images subarrayWithRange:NSMakeRange(0, count)];
        [self setupWithItemTitles:_itemTitles ];
    }
    return self;
}

- (void)setupWithItemTitles:(NSArray *)titles
{
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        SGGridItem *item = [[SGGridItem alloc] initWithTitle:titles[i] ];
        item.menu = self;
        item.tag = i;
        if ([item.titleLabel.text isEqualToString:_selecteTitle]) {
            [self selectButton:(UIButton *)item];
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
    for (SGGridItem *item in self.items) {
        [item setTitleColor:BaseMenuTextColor(style) forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = (CGRect){CGPointMake(self.bounds.size.width - 13 -14, 14), CGSizeMake(13 , 13)};
    self.allBtn.frame = (CGRect){CGPointMake(17, 30), CGSizeMake(60 , 30)};
    [self layoutContentScrollView];
    self.contentScrollView.frame = (CGRect){CGPointMake(0, 65), self.contentScrollView.bounds.size.width,kDeviceHeight -173 -65};
    
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
    self.contentScrollView.contentSize = CGSizeMake(self.bounds.size.width, rowCount * itemSize.height + margin.top + margin.bottom);
    for (int i=0; i<itemCount; i++) {
        SGGridItem *item = self.items[i];
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

- (void)triggerSelectedAction:(void (^)(NSInteger))actionHandle
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
                self.actionHandle(0);
            });
        }else if ([sender isEqual:self.allBtn])
        {
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.actionHandle(1002);
            });
        }
        else{
            [self selectButton:(UIButton *)sender];
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.actionHandle([sender tag] + 1);
            });
        }
    }
}
- (void)selectButton:(UIButton *)button
{
    if (_selectBtn) {
        _selectBtn.selected = NO;
        [_selectBtn setTitleColor:boardColor forState:UIControlStateNormal];
        [_selectBtn.layer setBorderColor:[boardColor CGColor]];

//        _selectBtn.titleLabel. = _textFont;
    }
    _selectBtn = button;
    
//    CGRect frame = _horIndicator.frame;
//    frame.origin.x = CGRectGetMinX(_selectBtn.frame) +CGRectGetWidth(_selectBtn.frame)/2 -27.5;
//    [UIView animateWithDuration:0.2 animations:^{
//        _horIndicator.frame = frame;
//        
//    }];
    
    _selectBtn.selected = YES;
    [_selectBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    [_selectBtn.layer setBorderColor:[blackFontColor CGColor]];
//    _selectBtn.titleLabel.font = _selectedTextFont;
}
@end
