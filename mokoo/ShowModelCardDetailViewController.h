//
//  ShowModelCardDetailViewController.h
//  mokoo
//
//  Created by Mac on 15/9/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowModelCardDetailViewController : UIViewController
@property (nonatomic,copy)NSString *cardId;
@property (nonatomic,copy)NSString *user_id;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong)UIButton *goToTopBtn;
@end
