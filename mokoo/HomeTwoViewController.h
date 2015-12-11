//
//  HomeTwoViewController.h
//  mokoo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeTwoViewControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;

@end
@interface HomeTwoViewController : UIViewController
@property (strong, nonatomic) UIButton *leftBtn;
@property (nonatomic,strong) UIImageView *titleImageView;
//@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;
@property (nonatomic,weak) id<HomeTwoViewControllerDelegate>delegate;
@property (nonatomic,strong)UIButton *goToTopBtn;

@end
