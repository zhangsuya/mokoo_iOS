//
//  ShowDetailViewController.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "ShowCellModel.h"
#import "CommentSendViewController.h"
@protocol ShowDetailViewControllerDelegate<NSObject>
@optional
-(void)passDeleteIndexPath:(NSIndexPath *)path;
-(void)passIndexPath:(NSIndexPath *)path model:(ShowCellModel *)model;
@end
@interface ShowDetailViewController : UIViewController<UIScrollViewDelegate,CustomTopBarDelegate,CommentSendViewDelegate>
@property (nonatomic, strong) ShowCellModel *model;
@property (nonatomic, assign) BOOL pageTabBarIsStopOnTop;
@property (nonatomic, copy)NSString *showID;
@property (nonatomic, strong)NSIndexPath *path;
@property (nonatomic, assign) id<ShowDetailViewControllerDelegate>delegate;
@property (readwrite, nonatomic) int yOrigin;

@end
