//
//  ShowBaseTableViewController.h
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDetailViewController.h"
#import "CommentSendViewController.h"
@protocol ShowBaseTableViewControllerDelegate<NSObject>
@optional
-(void)passContentOffsetY:(CGFloat )y;
-(void)pushViewController:(ShowDetailViewController *)detailVC;
-(void)pushCommentSendViewController:(CommentSendViewController *)commentSendVC;
@end
@interface ShowBaseTableViewController : UITableViewController
@property (nonatomic,assign) CGFloat height;
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,copy) NSString *showNowType;
@property (nonatomic,strong)UIButton *goToTopBtn;
@property (nonatomic,copy)NSString *seeUserId;
@property (nonatomic,assign) id<ShowBaseTableViewControllerDelegate>delegate;
@end
