//
//  ShowSendViewController.h
//  mokoo
//
//  Created by Mac on 15/9/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShowSendViewControllerDelegate<NSObject>
-(void)showSendRefrensh;
@end
@interface ShowSendViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWeightConstant;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placehoderTopConstraint;

//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, copy) NSString *showId;
@property (nonatomic,strong)NSArray *selectArray;
@property (nonatomic,strong)UIImage *cameraImage;
@property (nonatomic,assign) id<ShowSendViewControllerDelegate>delegate;
@end
