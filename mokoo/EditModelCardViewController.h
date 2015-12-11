//
//  EditModelCardViewController.h
//  mokoo
//
//  Created by Mac on 15/9/22.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPActionSheetView.h"
#import "MLImageCrop.h"
@protocol EditModelCardViewControllerDelegate<NSObject>
-(void)editModelCardViewRefrensh;
@end
@interface EditModelCardViewController : UIViewController<ZPActionSheetViewDelegate,UIImagePickerControllerDelegate,MLImageCropDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoSamllConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeSmallConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourSmallConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addCatagoryLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitBtnTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addTypeBtnTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourImageView;
@property (weak, nonatomic) IBOutlet UIButton *addTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submiteBtnClicked:(UIButton *)sender;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,assign) id<EditModelCardViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *experienceTableView;
@end
