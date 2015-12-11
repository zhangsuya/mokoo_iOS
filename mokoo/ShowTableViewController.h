//
//  ShowTableViewController.h
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSelectPhotoBrowserViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "CommentSendViewController.h"
@protocol ShowTableViewControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;

@end
#import "CustomTopBarView.h"
@class ShowTableViewController;
@interface ShowTableViewController : UIViewController<CustomTopBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,assign) CGFloat height;
//** 导航titileView */
@property (nonatomic, weak) UISegmentedControl *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,weak) id<ShowTableViewControllerDelegate>delegate;
@property (nonatomic, strong) UIButton *rightBtn;
//@property (nonatomic,strong)MLSelectPhotoPickerViewController *pickerVc;
@property (nonatomic,assign) NSInteger vcCount;
@property (nonatomic,strong)UIButton *goToTopBtn;
@end
