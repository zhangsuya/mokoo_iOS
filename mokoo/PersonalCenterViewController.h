//
//  PersonalCenterViewController.h
//  mokoo
//
//  Created by Mac on 15/9/7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "TYSlidePageScrollViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
@protocol PersonalCenterViewControllerDelegate<NSObject>
@optional
- (void)leftBtnClicked;
@end

@interface PersonalCenterViewController : TYSlidePageScrollViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic , assign) BOOL isNoHeaderView;
@property (nonatomic, weak) id<PersonalCenterViewControllerDelegate> delegate;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,assign) NSInteger vcCount;
@end
