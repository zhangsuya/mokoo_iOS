//
//  ChatListViewController.h
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
@protocol ChatListViewControllerDelegate<NSObject>
@optional
- (void)leftBtnClicked;
@end


@interface ChatListViewController : RCConversationListViewController<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,assign) id<ChatListViewControllerDelegate>delegate;
@end
