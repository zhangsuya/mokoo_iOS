//
//  ChatListViewController.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "ChatListViewController.h"
#import "UIButton+EnlargeTouchArea.h"

#import "RCDChatViewController.h"
#import "MokooMacro.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"约起来"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    self.navigationItem.titleView = titleLabel;
    
    
    
    //自定义导航左右按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _leftBtn.frame = CGRectMake(0, 6, 67, 23);
//    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
//    backImg.frame = CGRectMake(-10, 0, 22, 22);
//    [_leftBtn addSubview:backImg];
//    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 22)];
//    backText.text = @"退出";
//    backText.font = [UIFont systemFontOfSize:15];
//    [backText setBackgroundColor:[UIColor clearColor]];
//    [backText setTextColor:[UIColor whiteColor]];
//    [_leftBtn addSubview:backText];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
//    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    [_leftBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
//    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
    self.conversationListTableView.userInteractionEnabled = YES;
    //刷新融云头像,因为个人可能修改了个人信息:如头像
    RCUserInfo *userInfo = [RCUserInfo new];
    userInfo.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"];
    userInfo.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];;
    userInfo.portraitUri = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_img"];;
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
    
    
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{

    //需要修改功能板
    RCDChatViewController *chatVC = [[RCDChatViewController alloc] init];
    chatVC.conversationType       = model.conversationType;
    chatVC.targetId = model.targetId;
    chatVC.userName =model.conversationTitle;
    chatVC.title = model.conversationTitle;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    
//    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
//    conversationVC.conversationType =model.conversationType;
//    conversationVC.targetId = model.targetId;
//    conversationVC.userName =model.conversationTitle;
//    conversationVC.title = model.conversationTitle;
//    [self.navigationController pushViewController:conversationVC animated:YES];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.navigationItem.title = @"会话";    
}

/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
//    [alertView show];
    if ([_delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [_delegate leftBtnClicked];
    }
}

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"1"; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
    conversationVC.userName = @"测试1";
    conversationVC.title = @"自问自答";
    [self.navigationController pushViewController:conversationVC animated:YES];

}
//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) {
////        [[RCIM sharedRCIM]disconnect];
//       
////        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
//    if ([touch.view isKindOfClass:[UIView class]]){
//        
//        return NO;
//        
//    }
//    
//    return YES;
//    
//}


@end