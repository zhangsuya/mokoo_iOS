//
//  ViewController.h
//
//
//  Created by sy on 15/6/6.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomePageControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;

@end
@interface HomePageViewController : UIViewController
@property (strong, nonatomic) UIButton *leftBtn;
@property (nonatomic,strong) UIImageView *titleImageView;
//@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;
@property (nonatomic,weak) id<HomePageControllerDelegate>delegate;
@end

