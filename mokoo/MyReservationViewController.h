//
//  MyReservationViewController.h
//  mokoo
//
//  Created by Mac on 15/10/12.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyReservationViewControllerDelegate<NSObject>
@optional
- (void)leftBtnClicked;
@end
@interface MyReservationViewController : UIViewController
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong)UIButton *goToTopBtn;
@property (nonatomic,assign) id<MyReservationViewControllerDelegate>delegate;
@end
