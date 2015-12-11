//
//  ActivityViewController.m
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityBaseTwoTableViewController.h"
#import "MokooMacro.h"
#import "ActivitySendThreeViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "notiNilView.h"
#import "LoginMokooViewController.h"
#import "MJRefresh.h"
@interface ActivityViewController ()<UINavigationControllerDelegate,ActivityBaseTwoTableViewControllerDelegate>
{
}
@property (nonatomic,strong) UITableView *allShowTableView;
@property (nonatomic,strong) UITableView *myCaretableView;
@property (nonatomic,strong) UITableView *currentTableView;
@property (nonatomic,strong) ActivityBaseTwoTableViewController *showAllViewController;
@property (nonatomic,strong) ActivityBaseTwoTableViewController *myCreatViewController;
@end

@implementation ActivityViewController
@synthesize goToTopBtn =  _goToTopBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self addTableViewWithType:@"活动广场"];
    [self addTableViewWithType:@"我的活动"];
    _showAllViewController = self.childViewControllers[0];
    _showAllViewController.delegate = self;
    _showAllViewController.tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
    self.allShowTableView = _showAllViewController.tableView;
    [self.view addSubview:self.allShowTableView];
    [self.view insertSubview:self.goToTopBtn aboveSubview:self.allShowTableView];
//    _currentTableView = self.allShowTableView;
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    //设置导航条titleView
    UISegmentedControl *titleV = [[UISegmentedControl alloc] initWithItems:nil];
    [titleV setTintColor:blackFontColor];
    [titleV insertSegmentWithTitle:@"活动广场" atIndex:0 animated:NO];
    [titleV insertSegmentWithTitle:@"我的活动" atIndex:1 animated:NO];
    titleV.frame = CGRectMake(0, 0, 142, 26);
    //    titleV.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 30);
    
    //文字设置
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:14];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *normalAttDic = [NSMutableDictionary dictionary];
    normalAttDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:14];
    normalAttDic[NSForegroundColorAttributeName] = blackFontColor;
    [titleV setTitleTextAttributes:normalAttDic forState:UIControlStateNormal];
    [titleV setTitleTextAttributes:attDic forState:UIControlStateSelected];
    //事件
    titleV.selectedSegmentIndex = 0;
    [titleV addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
    _titleView = titleV;
    self.navigationItem.titleView = _titleView;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-21-16, 16, 21, 16);
    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_publish.pdf"] forState:UIControlStateNormal];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
    self.navigationController.delegate = self;
}
#pragma mark - titleViewAction
- (void)titleViewChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        if (self.allShowTableView) {
            self.myCaretableView.hidden = YES;
            self.allShowTableView.hidden = NO;
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.allShowTableView];
            //切换时保证goToTopBtn在正确的时候显示
            if (self.allShowTableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
            [self.allShowTableView.header beginRefreshing];
            //            _showAllViewController.delegate = self;
//            _myCreatViewController.delegate = nil;
        }else{
            
            _showAllViewController = self.childViewControllers[0];
            _showAllViewController.delegate = self;
            _showAllViewController.tableView.frame = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight -64 );
            self.allShowTableView = _showAllViewController.tableView;
            [self.view addSubview:self.allShowTableView];
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.allShowTableView];
            //切换时保证goToTopBtn在正确的时候显示
            if (self.allShowTableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
            self.myCaretableView.hidden = YES;
            self.allShowTableView.hidden = NO;
//            _currentTableView = self.allShowTableView;
        }
        
        
    } else {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
            LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
            //        loginVC.notBack = YES;
            [self presentViewController:loginVC animated:YES completion:nil];
            return;
        }
        if (self.myCaretableView) {
            self.myCaretableView.hidden = NO;
            self.allShowTableView.hidden = YES;
//            _showAllViewController.delegate = nil;
//            _myCreatViewController.delegate = self;
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.myCaretableView];
            //切换时保证goToTopBtn在正确的时候显示
//            [self.view insertSubview:self.allShowTableView aboveSubview:self.goToTopBtn];
            if (self.myCaretableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
            [self.myCaretableView.header beginRefreshing];
        }else
        {
            _myCreatViewController = self.childViewControllers[1];
            _myCreatViewController.tableView.frame = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight - 64);
            _myCreatViewController.delegate = self;
//            _myCreatViewController requestActivityList:<#(NSString *)#> refreshType:<#(NSString *)#>
            self.myCaretableView = _myCreatViewController.tableView;
            [self.view addSubview:self.myCaretableView];
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.myCaretableView];
            //切换时保证goToTopBtn在正确的时候显示
//            [self.view insertSubview:self.allShowTableView aboveSubview:self.goToTopBtn];
            self.myCaretableView.hidden = NO;
            self.allShowTableView.hidden = YES;
            if (self.myCaretableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
            //            _currentTableView = self.myCaretableView;
        }
        
        //显示nearView
        //        [self.view addSubview:self.nearImageView];
        //        [self.rmedView removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addTableViewWithType:(NSString *)showNowType
{
    
    ActivityBaseTwoTableViewController *tableViewVC = [[ActivityBaseTwoTableViewController alloc]init];
    tableViewVC.delegate = self;
    tableViewVC.showNowType = showNowType;
    //        tableViewVC.page = page;
    [self addChildViewController:tableViewVC];
    
    
    
    // don't forget addChildViewController
}
//navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    if (_titleView.selectedSegmentIndex == 0) {
        [_showAllViewController requestActivityList:@"1" refreshType:@"header"];
    }else
    {
        [_myCreatViewController requestActivityList:@"1" refreshType:@"header"];
    }
    
}
//-(NSMutableArray *)shows
//{
//    if (_shows == nil) {
//        _shows = [NSMutableArray array];
//        _allCells = [NSMutableArray array];
//        //取数据到model并将model对象存到shows数组中
//        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"show" ofType:@"plist"]];
//        for (NSDictionary *dict in tmpArr) {
//            ShowCellModel *model = [ShowCellModel cellModelWithDict:dict];
//            [_shows addObject:model];
//            ShowCell *cell = [[ShowCell alloc]init];
//            [_allCells addObject:cell];
//        }
//    }
//    return  _shows;
//}
//-(NSMutableArray *)countedCells
//{
//    if (_countedCells == nil) {
//        _countedCells = [NSMutableArray array];
//    }
//    return _countedCells;
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)clicked {
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
}
- (void)cameraBtnClicked:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    ActivitySendThreeViewController *sendVC = [[ActivitySendThreeViewController alloc] init];
//    ActivitySendThreeViewController *sendVC = [[ActivitySendThreeViewController alloc] initWithNibName:@"ActivitySendThreeViewController" bundle:nil];
    [self.navigationController pushViewController:sendVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIButton *)goToTopBtn
{
    if(!_goToTopBtn)
    {
        _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToTopBtn.backgroundColor = [UIColor clearColor];
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-52, kDeviceHeight-52, 39, 39);
        _goToTopBtn.alpha = 0;
        [_goToTopBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [_goToTopBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
        [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToTopBtn;
}
//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame1 = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
        CGRect frame2 = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight -64);

        if (_titleView.selectedSegmentIndex ==0)
        {
            self.allShowTableView.frame = frame1;
        }else if (_titleView.selectedSegmentIndex ==1)
        {
            self.myCaretableView.frame = frame2;
        }
        
    }completion:^(BOOL finished){
        
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (_titleView.selectedSegmentIndex ==0) {
        [self.allShowTableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    }else if (_titleView.selectedSegmentIndex ==1)
    {
        [self.myCaretableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    }

    
}
-(void)passContentOffsetY:(CGFloat)y
{
    if ( y > 1100) {
        self.goToTopBtn.alpha = 1;
        //        [self.view bringSubviewToFront:_goToTopBtn];
    } else {
        self.goToTopBtn.alpha = 0;
    }
    
}
-(void)dealloc
{//将delegate设为nil
    _showAllViewController.delegate = nil;
    _myCreatViewController.delegate = nil;
    self.allShowTableView.delegate = nil;
    self.myCaretableView.delegate = nil;
    self.navigationController.delegate = nil;
}
@end
