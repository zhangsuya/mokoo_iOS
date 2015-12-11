//
//  ActivityCaseTableViewController.h
//  mokoo
//
//  Created by Mac on 15/9/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notiNilView.h"
@interface ActivityCaseTableViewController : UITableViewController
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,copy)NSString *case_id;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,strong)notiNilView     *notinilView;

@end
