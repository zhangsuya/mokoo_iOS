//
//  ActivityBaseTwoTableViewController.h
//  mokoo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityBaseTwoTableViewControllerDelegate<NSObject>
-(void)passContentOffsetY:(CGFloat )y;
@end
@interface ActivityBaseTwoTableViewController : UITableViewController
@property (nonatomic,assign) CGFloat height;
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,copy) NSString *showNowType;//活动展示类型,活动广场还是我的活动
-(void)requestActivityList:(NSString *)page refreshType:(NSString *)type;
@property (nonatomic,assign) id<ActivityBaseTwoTableViewControllerDelegate>delegate;

@end
