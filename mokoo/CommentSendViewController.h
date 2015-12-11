//
//  CommentSendViewController.h
//  mokoo
//
//  Created by Mac on 15/9/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommentSendViewDelegate<NSObject>
-(void)sendSucced:(NSIndexPath *)indexPath;
@end
@interface CommentSendViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
//** 导航titileView */
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, copy) NSString *showId;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)NSIndexPath *path;
@property (nonatomic, assign)  id<CommentSendViewDelegate> delegate;

@end
