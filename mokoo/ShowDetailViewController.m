//
//  ShowDetailViewController.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "MokooMacro.h"
#import "ShowCell.h"
#import "TYSlidePageScrollView.h"
#import "TableViewController.h"
#import "TYTitlePageTabBar.h"
#import "ShowLikeCellModel.h"
#import "ShowCommentCellModel.h"
#import "ShowLikeTableViewController.h"
#import "ShowCommentTableViewController.h"
#import "ShowTableViewController.h"
#import "XHImageViewer.h"
#import "CommentSendViewController.h"
#import "RequestCustom.h"
#import "MJRefresh.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ImageListModel.h"
#import "UIButton+EnlargeTouchArea.h"
#import "LoginMokooViewController.h"
#import "PersonalCenterViewController.h"
@interface ShowDetailViewController ()<TYSlidePageScrollViewDataSource,TYSlidePageScrollViewDelegate>
{
    MJRefreshNormalHeader * _header;
    CustomTopBarView *topBar;
    UIRefreshControl *refreshControl;
    ShowCell *cell;
}
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,weak)UILabel *titleView;
@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addTabPageMenu];
    
    
    [self addTableViewWithPage:0 itemNum:6];
    [self addTableViewWithPage:1 itemNum:12];
    [_slidePageScrollView reloadData];

//请求数据
//    [self requestShowNowDetail];

    
//    refreshControl = [[UIRefreshControl alloc]init];
//    //    self.refreshControl.tintColor = [UIColor blueColor];
//    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
//    [refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];

    
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 30, 30);
    [titleLabel setText:@"详情"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
//    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
//    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
//    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
//    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)setTableViewWithHeight:(CGFloat)height
{
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, height +38, kDeviceWidth, kDeviceHeight - 64) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"详情"];
    
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void)backBtnClicked:(UIButton *)btn
{
    if (_path) {
        if ([_delegate respondsToSelector:@selector(passIndexPath:model:)]) {
            [_delegate passIndexPath:_path model:_model];
        }

    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    slidePageScrollView.pageTabBarIsStopOnTop = _pageTabBarIsStopOnTop;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
//    slidePageScrollView.backgroundColor = viewBgColor;
    [self.view addSubview:slidePageScrollView];
    self.view.backgroundColor = viewBgColor;
    _slidePageScrollView = slidePageScrollView;

}

- (void)addHeaderView
{
//    cell = [[ShowCell alloc]initShowCellWithModel:self.model];
    cell = [[ShowCell alloc] initShowCellWithModel:self.model yOrign:_yOrigin -64];
    for (int i = 0; i<[cell.imageViewArray count]; i ++) {
        UITapGestureRecognizer  *tap     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCli:)];
        [cell.imageViewArray[i] addGestureRecognizer:tap];
    }
    UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
    [cell.avatarImageView addGestureRecognizer:personalGesture];
    cell.avatarImageView.userInteractionEnabled = YES;
    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _slidePageScrollView.headerView = cell;
    
}
-(void)tapCli:(UIGestureRecognizer *)tap
{
   
    NSInteger count = _model.imglist.count;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(_model.imglist[i])];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:imageModel.url]; // 图片路径
        photo.srcImageView = (UIImageView *)[cell viewWithTag:i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
//    ShowCell *cell = (ShowCell *)[[tap.view superview] superview];
//    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
//    //    imageViewer.delegate = self;
//    NSLog(@"%@",@([cell.imageViewArray count]));
//    [imageViewer showWithImageViews:cell.imageViewArray selectedView:(UIImageView *)tap.view];
    
}
- (void)addTabPageMenu
{
    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"赞",@"评论"]];
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 38);
    titlePageTabBar.backgroundColor = whiteFontColor;
    _slidePageScrollView.pageTabBar = titlePageTabBar;
}
- (void)addTableViewWithPage:(NSInteger)page itemNum:(NSInteger)num
{
    if (page ==0) {
        ShowLikeTableViewController *tableViewVC = [[ShowLikeTableViewController alloc]init];
        tableViewVC.itemNum = num;
        tableViewVC.page = page;
        tableViewVC.show_id = self.model.show_id;
        [self addChildViewController:tableViewVC];
    }else
    {
        ShowCommentTableViewController *tableViewVC = [[ShowCommentTableViewController alloc]init];
        tableViewVC.itemNum = num;
        tableViewVC.page = page;
        tableViewVC.show_id = self.model.show_id;
        [self addChildViewController:tableViewVC];

    }
    
    
    // don't forget addChildViewController
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    if (index ==0) {
        ShowLikeTableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }else
    {
        ShowCommentTableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }
    return nil;
}
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    if (pageScrollView.contentOffset.y
        >0) {
        NSLog(@"上下");
    }
    
}
-(void)imageGes:(UITapGestureRecognizer *)tap
{
    
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    
    personalViewController.user_id = self.model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
-(void)likeBtnClicked:(MCFireworksButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    ShowLikeTableViewController *tableViewVC = self.childViewControllers[0];
    [tableViewVC.tableView.header beginRefreshing];

    if (btn.isSelected) {
        [RequestCustom delShowNowGoodByShowId:self.model.show_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    
                    btn.isSelected = NO;
                    _model.good_count = [NSString stringWithFormat:@"%@",@([_model.good_count integerValue] -1)];
                    _model.is_zan = @"0";
                    [cell.likeCountLabel setTextColor:blackFontColor];
                    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] -1)];
                    [btn popOutsideWithDuration:0.5];
                    [btn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
                    [btn animate];
                    //                [_slidePageScrollView reloadData];
                    //保证缺省页面的正确显示
                    if ([_model.good_count isEqualToString:@"0"]) {
                        tableViewVC.notinilView.hidden = NO;
                    }
                    [tableViewVC.tableView.header endRefreshing];
                }

            }
            }];
    }
    else {
        
        [RequestCustom addShowNowGoodByShowId:self.model.show_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
//                    ShowLikeTableViewController *tableViewVC = self.childViewControllers[0];
                    //保证缺省页面的正确显示
                    if ([_model.good_count isEqualToString:@"0"]) {
                        tableViewVC.notinilView.hidden = YES;
                    }
                    btn.isSelected = YES;
                    [cell.likeCountLabel setTextColor:likeOnBtnColor];
                    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] +1)];
                    _model.good_count = [NSString stringWithFormat:@"%@",@([_model.good_count integerValue] +1)];
                    _model.is_zan = @"1";
                    [btn popInsideWithDuration:0.4];
                    [btn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
                    [btn animate];
                    [tableViewVC.tableView.header endRefreshing];
                    
                }

            }
            }];
        
        
    }
    
}
-(void)commentBtnClicked:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    CommentSendViewController *commentSendVC = [[CommentSendViewController alloc]initWithNibName:@"CommentSendViewController" bundle:nil];
    commentSendVC.showId = self.model.show_id;
    commentSendVC.path = _path;
    commentSendVC.type = @"show";
    commentSendVC.delegate = self;
    [self.navigationController pushViewController:commentSendVC animated:YES];
}
-(void)deleBtnClicked:(UIButton *)btn
{
    [RequestCustom deleteShowNowByShowId:self.model.show_id Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([_delegate respondsToSelector:@selector(passDeleteIndexPath:)]) {
                [_delegate passDeleteIndexPath:self.path];
            }
            if ([status isEqual:@"1"]) {
                //改为list请求数据block
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }
        
    }];
    
}
-(void)RefreshViewControlEventValueChanged
{

    
}
-(void)requestShowNowDetail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    [RequestCustom requestShowNowDetail:user_id showId:_showID Complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSDictionary *dataDict = [obj objectForKey:@"data"];
                    _model = [ShowCellModel cellModelWithDict:dataDict];
                    [self addSlidePageScrollView];
                    [self addHeaderView];
                    [self addTabPageMenu];

                    
                    [self addTableViewWithPage:0 itemNum:6];
                    [self addTableViewWithPage:1 itemNum:12];
                    [_slidePageScrollView reloadData];

                    
                }
                
            }
            
        }

    }];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (void) backBtnClicked
{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    ShowTableViewController *showVC = [[ShowTableViewController alloc]init];
//    [self.navigationController popToViewController:showVC animated:YES];
}
-(void)sendSucced:(NSIndexPath *)indexPath
{
//    [_slidePageScrollView reloadData];
    _model.comment_count = [NSString stringWithFormat:@"%@",@([_model.comment_count integerValue] +1)];
    cell.commentCountLabel.text = _model.comment_count;
    
    ShowCommentTableViewController *tableViewVC = self.childViewControllers[1];
    [tableViewVC.tableView.header beginRefreshing];
}
@end
