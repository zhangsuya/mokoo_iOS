//
//  CustomTopBarView.h
//  mokoo
//
//  Created by Mac on 14-12-15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTopBarView;
@protocol CustomTopBarDelegate <NSObject>
@optional
- (void) menuBtnClicked;
- (void) backBtnClicked;
- (void) sortBtnClicked;
- (void) searchBtnClicked;
- (void) moreBtnClicked;
- (void) applyBtnClicked;
- (void) editBtnClicked:(UIButton *)sender forEvent:(UIEvent *)event;
- (void) saveBtnClicked;
- (void) selectorClicked;

@end

@interface CustomTopBarView : UIView

@property (nonatomic, readonly) UIButton *menuImgBtn;
@property (nonatomic, readonly) UIButton *backImgBtn;
@property (nonatomic, readonly) UIButton *sortImgBtn;
@property (nonatomic, readonly) UIButton *searchImgBtn;
@property (nonatomic, readonly) UIButton *moreImgBtn;
@property (nonatomic, readonly) UIButton *applyImgBtn;
@property (nonatomic, readonly) UILabel *leftTitle;
@property (nonatomic, readonly) UILabel *midTitle;
@property (nonatomic, readonly) UIButton *searchSelector;
@property (nonatomic, readonly) UIButton *editBtn;
@property (nonatomic, readonly) UIButton *saveBtn;
@property (nonatomic, readonly) UILabel *underLine;
@property (nonatomic, assign) id <CustomTopBarDelegate> delegate;

- (id)initWithTitle:(NSString *)title;

@end
