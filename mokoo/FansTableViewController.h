//
//  FansTableViewController.h
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansTableViewController : UITableViewController
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,strong)UIButton *goToTopBtn;
@property (nonatomic,copy)NSString *userId;
//1.关注列表		2.粉丝列表
@property (nonatomic,copy)NSString *type;
@end
