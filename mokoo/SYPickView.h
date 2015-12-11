//
//  SYPickView.h
//  mokoo
//
//  Created by Mac on 15/9/1.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SYPickViewDelegate<NSObject>
- (void)passValue:(NSString *)selectedItem;
-(void)passItem:(NSInteger)item;
@optional
- (void)cancelBtnClicked;
@end
@interface SYPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView *myPickerView;
@property (nonatomic,strong)NSArray *selectedArray;
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic, assign) id <SYPickViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;

@end
