//
//  ShowCommentTableViewController.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCommentTableViewController : UITableViewController
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) NSString *show_id;
@end
