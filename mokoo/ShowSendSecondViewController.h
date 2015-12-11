//
//  ShowSendSecondViewController.h
//  mokoo
//
//  Created by Mac on 15/10/14.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"
#import "CPTextViewPlaceholder.h"
#import "PlaceholderTextView.h"
@protocol ShowSendSecondViewControllerDelegate<NSObject>
-(void)showSendRefrensh;
@end
@interface ShowSendSecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *commentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWeightConstant;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placehoderTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whiteViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTxetViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationButtomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addPicTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTextViewTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whiteViewButtomConstraint;
@property (weak, nonatomic) IBOutlet UIView *whiteTopView;
@property (weak, nonatomic) IBOutlet UIView *grayContentView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, copy) NSString *showId;
@property (nonatomic,strong)NSArray *selectArray;
@property (nonatomic,strong)UIImage *cameraImage;
@property (nonatomic,assign) id<ShowSendSecondViewControllerDelegate>delegate;
@end
