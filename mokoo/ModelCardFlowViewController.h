//
//  ModelCardFlowViewController.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowView.h"
#import "ImageViewCell.h"
#import "ShowModelCardDetailViewController.h"

@protocol ModelCardFlowViewControllerDelegate<NSObject>
@optional
-(void)pushModelCardDetailViewController:(ShowModelCardDetailViewController *)detailVc;
@end
@interface ModelCardFlowViewController : UIViewController<WaterFlowViewDelegate,WaterFlowViewDataSource>
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,strong)UIButton *goToTopBtn;
@property (nonatomic,assign) id<ModelCardFlowViewControllerDelegate>delegate;
- (void)dataSourceDidLoad;
- (void)dataSourceDidError;
-(void)loadInternetData;
@end
