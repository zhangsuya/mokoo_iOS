//
//  ViewController.h
//  QQSlideMenu
//
//  Created by wamaker on 15/6/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMBaseViewController.h"

@interface SlidingMenuViewController : UIViewController
@property (nonatomic)BOOL isPersonal;
@property (retain, nonatomic) UIViewController   *homeVC;


- (void)didSelectItem:(NSString *)title;
@end

