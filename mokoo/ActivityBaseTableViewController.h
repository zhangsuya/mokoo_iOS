//
//  ActivityBaseTableViewController.h
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityBaseTableViewControllerDelegate<NSObject>
-(void)passContentOffsetY:(CGFloat )y;
@end
@interface ActivityBaseTableViewController : UITableViewController
@property (nonatomic,assign) CGFloat height;
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,copy) NSString *showNowType;
-(void)requestActivityList:(NSString *)page refreshType:(NSString *)type;
@property (nonatomic,assign) id<ActivityBaseTableViewControllerDelegate>delegate;

@end
