//
//  ShowTableViewController.m
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowTableViewController.h"
#import "ShowCell.h"
#import "ShowCellModel.h"
#import "MokooMacro.h"
#import "UIImage+ChangeSharp.h"
#import "UIView+SDExtension.h"
#import "ShowDetailViewController.h"
#import "ShowBaseTableViewController.h"
#import "HJCActionSheet.h"
#import "ShowSendSecondViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MJRefresh.h"
#import "LoginMokooViewController.h"
#import "UIImage+FixOrientation.h"
@interface ShowTableViewController ()<HJCActionSheetDelegate,ShowBaseTableViewControllerDelegate,ShowSendSecondViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *shows;
@property (nonatomic,strong) NSMutableArray *allCells;
@property (nonatomic,strong) NSMutableArray *countedCells;
@property (nonatomic,strong) UITableView *allShowTableView;
@property (nonatomic,strong) UITableView *myCaretableView;
@property (nonatomic,strong) UITableView *currentTableView;
@property (nonatomic,strong) MLSelectPhotoPickerViewController *pickerVc;
@end

@implementation ShowTableViewController
@synthesize goToTopBtn =  _goToTopBtn;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavigationItem];
    
    [self addTableViewWithType:@"所有人"];
    [self addTableViewWithType:@"我的关注"];
    ShowBaseTableViewController *showAllViewController = self.childViewControllers[0];
    showAllViewController.delegate = self;
    showAllViewController.tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
    self.allShowTableView = showAllViewController.tableView;
    [self.view addSubview:self.allShowTableView];
//    [self.view addSubview:_goToTopBtn];
    [self.view insertSubview:self.goToTopBtn aboveSubview:self.allShowTableView];
//    _currentTableView = self.allShowTableView;
//    [self.view bringSubviewToFront:_goToTopBtn];
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    //设置导航条titleView
    UISegmentedControl *titleV = [[UISegmentedControl alloc] initWithItems:nil];
    [titleV setTintColor:blackFontColor];
    [titleV insertSegmentWithTitle:@"所有人" atIndex:0 animated:NO];
    [titleV insertSegmentWithTitle:@"我的关注" atIndex:1 animated:NO];
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
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-21-16, 16, 21, 16);
    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_camera.pdf"] forState:UIControlStateNormal];
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
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
        }else{
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
                LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
                //        loginVC.notBack = YES;
                [self presentViewController:loginVC animated:YES completion:nil];
                return;
            }
            ShowBaseTableViewController *showAllViewController = self.childViewControllers[0];
            showAllViewController.tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
            showAllViewController.delegate = self;
            self.allShowTableView = showAllViewController.tableView;
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
        }
        _currentTableView = _allShowTableView;
        
    } else {
        if (self.myCaretableView) {
            self.myCaretableView.hidden = NO;
            self.allShowTableView.hidden = YES;
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.myCaretableView];
            //切换时保证goToTopBtn在正确的时候显示
            if (self.myCaretableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
        }else
        {
            ShowBaseTableViewController *myCreatViewController = self.childViewControllers[1];
            myCreatViewController.tableView.frame = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64 );
            myCreatViewController.delegate = self;
            self.myCaretableView = myCreatViewController.tableView;
            [self.view addSubview:self.myCaretableView];
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.myCaretableView];
            //切换时保证goToTopBtn在正确的时候显示
            if (self.myCaretableView.contentOffset.y>1100) {
                _goToTopBtn.alpha = 1;
            }else
            {
                _goToTopBtn.alpha = 0;
            }
            self.myCaretableView.hidden = NO;
            
            self.allShowTableView.hidden = YES;
        }
        _currentTableView = _myCaretableView;
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
    
        ShowBaseTableViewController *tableViewVC = [[ShowBaseTableViewController alloc]init];
    tableViewVC.delegate = self;
        tableViewVC.showNowType = showNowType;
//        tableViewVC.page = page;
        [self addChildViewController:tableViewVC];
    
    
    
    // don't forget addChildViewController
}
-(NSMutableArray *)shows
{
    if (_shows == nil) {
        _shows = [NSMutableArray array];
        _allCells = [NSMutableArray array];
        //取数据到model并将model对象存到shows数组中
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"show" ofType:@"plist"]];
        for (NSDictionary *dict in tmpArr) {
            ShowCellModel *model = [ShowCellModel cellModelWithDict:dict];
            [_shows addObject:model];
            ShowCell *cell = [[ShowCell alloc]init];
            [_allCells addObject:cell];
        }
    }
    return  _shows;
}
-(NSMutableArray *)countedCells
{
    if (_countedCells == nil) {
        _countedCells = [NSMutableArray array];
    }
    return _countedCells;
}
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

    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
    //before
//    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", @"视频", nil];
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    // 2.显示出来
    [sheet show];
}
// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
        {
            UIImagePickerController *camera = [[UIImagePickerController alloc] init];
            camera.delegate = self;
            camera.allowsEditing = NO;
            
            if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                camera.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else
            {
                camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:camera animated:YES completion:nil];
        }
            break;
        case 2:
        {
            if (!_pickerVc ){
                _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                _pickerVc.minCount = 9;
                _pickerVc.status = PickerViewShowStatusCameraRoll;
                //            [self.navigationController.visibleViewController presentViewController:_pickerVc animated:YES completion:nil];
                _vcCount =0;
                [_pickerVc showPickerVc:self];
                __weak typeof(self) weakSelf = self;
                _pickerVc.callBack = ^(NSArray *assets){
                    if (weakSelf.vcCount ==0) {
                        weakSelf.pickerVc = nil;
                        //                    [weakSelf.pickerVc dismissViewControllerAnimated:YES completion:nil];
                        if ([assets count]==0) {
                            return ;
                        }
                        ShowSendSecondViewController *sendVC = [[ShowSendSecondViewController alloc]initWithNibName:@"ShowSendSecondViewController" bundle:nil];
                        sendVC.delegate = weakSelf;
                        sendVC.selectArray = assets;
                        //                [weakSelf.pickerVc.navigationController pushViewController:sendVC animated:YES];
                        [weakSelf.navigationController pushViewController:sendVC animated:YES];
                        if (assets) {
                            
                        }else
                        {
                            weakSelf.vcCount ++;
                            
                        }
                    }else
                    {
                        
                    }
                    
                    //                [weakSelf.assets addObjectsFromArray:assets];
                    //                [weakSelf.tableView reloadData];
                };
                        }
            // 创建控制器
            // 默认显示相册里面的内容SavePhotos
            // 默认最多能选9张图片
           

        }
            break;
        case 3:
        {
//            MLSelectPhotoPickerViewController *_pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
            // 默认显示相册里面的视频
            // 最多能选9个视频
            if (!_pickerVc ){
                _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                _pickerVc.minCount = 9;
                _pickerVc.status = PickerViewShowStatusVideo;
                [_pickerVc showPickerVc:self];
            }
        }
            break;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *fixImage = [image fixOrientation:image];
    UIImageWriteToSavedPhotosAlbum(fixImage, nil, nil, nil);
//    if ([tmpView isEqual:_bigImageView]) {
//        tmpView.image = image;
//        [selectedImageArray addObject:image];
//    }else
//    {
//        MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
//        imageCrop.delegate = self;
//        imageCrop.ratioOfWidthAndHeight = 300.0f/400.0f;
//        imageCrop.image = image;
//        [imageCrop showWithAnimation:NO];
//    }
    _vcCount =0;
    if (_vcCount ==0) {
        //                    [weakSelf.pickerVc dismissViewControllerAnimated:YES completion:nil];
        ShowSendSecondViewController *sendVC = [[ShowSendSecondViewController alloc]initWithNibName:@"ShowSendSecondViewController" bundle:nil];
        sendVC.delegate = self;
        sendVC.cameraImage = fixImage;
        //                [weakSelf.pickerVc.navigationController pushViewController:sendVC animated:YES];
        [self.navigationController pushViewController:sendVC animated:YES];
        _vcCount ++;
    }else
    {
        
    }

    [ picker dismissViewControllerAnimated: YES completion: nil ];
    picker = nil;
}
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
        CGRect frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
        CGRect frame2 = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64 );

        if (_titleView.selectedSegmentIndex ==0) {
            self.allShowTableView.frame = frame;
        }else if (_titleView.selectedSegmentIndex ==1)
        {
            self.myCaretableView.frame = frame2;
        }
//        self.currentTableView.frame = frame;
        
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
-(void)showSendRefrensh
{
    if (_titleView.selectedSegmentIndex ==0) {
        [self.allShowTableView.header beginRefreshing];
    } else {
        [self.myCaretableView.header beginRefreshing];
    }
}
//-(void)sendSucced
//{
//    
//}
/**
 *  将delegate设为nil
 */
-(void)dealloc
{
    ShowBaseTableViewController *showAllViewController = self.childViewControllers[0];
    showAllViewController.delegate = nil;
    if (self.childViewControllers.count ==2) {
        ShowBaseTableViewController *myCareViewController = self.childViewControllers[1];
        myCareViewController.delegate = nil;
    }
    
    self.allShowTableView.delegate = nil;
    self.myCaretableView.delegate = nil;
}
@end
