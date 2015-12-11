//
//  ShowLikeTableViewController.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notiNilView.h"

@interface ShowLikeTableViewController : UITableViewController
@property (nonatomic ,assign) NSInteger itemNum;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic,copy)NSString *show_id;
@property (nonatomic,strong)notiNilView     *notinilView;

@end
