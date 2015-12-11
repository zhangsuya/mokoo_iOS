//
//  ModelCardFlowViewController.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelCardFlowViewController.h"
#import "MJExtension.h"
#import "MCCollectionViewCell.h"
#import "ModelCardCollectionViewLayout.h"
#import "ModelCardModel.h"
#import "UIImageView+WebCache.h"
#import "MokooMacro.h"
#import "MJRefresh.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
@interface ModelCardFlowViewController ()
{
    NSMutableArray *arrayData;
    WaterFlowView *waterFlow;
    NSInteger showPage;
    notiNilView     *_notinilView;

}

@end
#define kFileName @"modelCardFlow.plist"
@implementation ModelCardFlowViewController
@synthesize goToTopBtn =  _goToTopBtn;
- (void)loadInternetData {
    // Request
    

//    NSArray * shopsArray = [ModelCardModel objectArrayWithFilename:@"1.plist"];
//    [self.view addSubview:_goToTopBtn];
    [self requestList:@"1" refreshType:@"header"];
   
                
//    [arrayData addObjectsFromArray:shopsArray];
                //arrayData = [[res objectForKey:@"gallery"] retain];
                //NSLog(@"arr == %@",arrayData);
//    [self dataSourceDidLoad];
}
- (void)dataSourceDidLoad {
    [waterFlow reloadData];
}

- (void)dataSourceDidError {
    [waterFlow reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    arrayData = [[NSMutableArray alloc] init];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStyleBordered target:self action:@selector(loadMore)];
    for (UIViewController *controller in self.navigationController.viewControllers ) {
        if ([controller isKindOfClass:[PersonalCenterViewController class]]) {
            waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        }
    }
    if (waterFlow ) {
        
    }else
    {
        waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64)];
    }
    self.view = waterFlow;

//    waterFlow.backgroundColor = viewBgColor;
    waterFlow.waterFlowViewDelegate = self;
    waterFlow.waterFlowViewDatasource = self;
//    waterFlow.backgroundColor = [UIColor whiteColor];
    [self initRefresh];
//    waterFlow.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        showPage += 1;
//        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
//        [self requestList:page refreshType:@"footer"];
//    }];

//    [self.view addSubview:waterFlow];
    self.view.backgroundColor = viewBgColor;
    [self initDefaultView];
    [waterFlow release];
//    [self.view release];
    [self loadInternetData];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    这样可以避免模特卡的返回偏移
    [waterFlow setNeedsLayout];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBarHidden = YES;
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
//    这样可以避免模特卡的返回偏移
    [waterFlow setNeedsLayout];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBarHidden = NO;
//    ModelCardFlowViewController *modelVC = self.viewControllers[2];
//    WaterFlowView *flowView = (WaterFlowView *)modelVC.view;
//    waterFlow.contentOffset = CGPointMake(waterFlow.contentOffset.x,-255);
}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    waterFlow.header   = header;
    
    
}
-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    if ([_user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
        _notinilView    = [_notinilView initModelCardFlowNilviewByPersonalCenter];

    }else
    {
        _notinilView    = [_notinilView initModelCardFlowNilviewByPersonalCenterOtherSee];
    }
    [self.view insertSubview:_notinilView aboveSubview:waterFlow];
    _notinilView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadMore{
    
    [arrayData addObjectsFromArray:arrayData];
    [waterFlow reloadData];
}

#pragma mark WaterFlowViewDataSource
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return 2;
}

- (NSInteger)numberOfAllWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return [arrayData count];
}

- (UIView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(IndexPath *)indexPath{
    
    ImageViewCell *view = [[ImageViewCell alloc] initWithIdentifier:nil];
    
    return view;
}


-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath{
    
    //arrIndex是某个数据在总数组中的索引
    NSInteger arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
    
    
    ModelCardModel *object = [arrayData objectAtIndex:arrIndex];
    
    
    
    ImageViewCell *imageViewCell = (ImageViewCell *)view;
    imageViewCell.indexPath = indexPath;
    imageViewCell.columnCount = waterFlowView.columnCount;
    [imageViewCell relayoutViews];
    [(ImageViewCell *)view setImageWithURL:[NSURL URLWithString:object.img_url]];
}


#pragma mark WaterFlowViewDelegate
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(IndexPath *)indexPath{
    
    NSInteger arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
    ModelCardModel *model = (ModelCardModel *)[arrayData objectAtIndex:arrIndex];
    
    float width = 0.0f;
    float height = 0.0f;
    if (model) {
        
        width = model.width;
        height = model.height;
    }
    
    return waterFlowView.cellWidth * (height/width);
}

- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath{
    ShowModelCardDetailViewController *modelCardDetailVC = [[ShowModelCardDetailViewController alloc]init];
    ModelCardModel *model = (ModelCardModel *)arrayData[indexPath.row * waterFlowView.columnCount + indexPath.column];
    modelCardDetailVC.cardId = model.card_id;
    modelCardDetailVC.user_id = model.user_id;
    if ([_delegate respondsToSelector:@selector(pushModelCardDetailViewController:)]) {
        [_delegate pushModelCardDetailViewController:modelCardDetailVC];
    }else{
        [self.navigationController pushViewController:modelCardDetailVC animated:YES];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)requestList:(NSString *)page refreshType:(NSString *)type{
    NSString *userId ;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userId = [userDefaults objectForKey:@"user_id"] ;
    }
    [RequestCustom requestPersonalCenterModelListByUserId:userId pageNUM:page pageLINE:@"10" Complete:^(BOOL succed, id obj){
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"0"]) {
                    if (showPage==0) {
                        _notinilView.hidden = NO;
                    }
                    
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"数据加载完毕";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                }
                [waterFlow.footer endRefreshing];
                return ;
            }
            NSArray *dataArray = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                
                if ([dataArray count]>0) {
                    if ([page isEqualToString:@"1"]) {
                        _notinilView.hidden = YES;
                        [arrayData removeAllObjects];
                        showPage = 1;
                    }
                    for (int i =0; i<[dataArray count]; i++) {
                        [arrayData addObject:[ModelCardModel initModelCardListWithDict:dataArray[i]]];
                    }
                    
                }
                if ([type isEqualToString:@"header"]) {
                    NSString *filePath = [self dataFilePath];
                    
                    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                        NSError *err;
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                    }
                    [dataArray writeToFile:[self dataFilePath] atomically:YES];
                    [waterFlow.header endRefreshing];
                }else if([type isEqualToString:@"footer"])
                {
                    [waterFlow.footer endRefreshing];
                }
                
                [waterFlow reloadData];
            }
            
        }
        
        
    }];
}
//-(UIButton *)goToTopBtn
//{
//    if(!_goToTopBtn)
//    {
//        _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _goToTopBtn.backgroundColor = [UIColor clearColor];
//        _goToTopBtn.frame = CGRectMake(kDeviceWidth-79, kDeviceHeight-139, 39, 39);
//        _goToTopBtn.alpha = 0;
//        [_goToTopBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
//        [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _goToTopBtn;
//}
//回到顶部
//- (void)goToTop
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
//        waterFlow.frame = frame;
//        
//    }completion:^(BOOL finished){
//    }];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [waterFlow scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
//    
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if ( scrollView.contentOffset.y > 1100) {
//        self.goToTopBtn.alpha = 1;
//        //        [self.view bringSubviewToFront:_goToTopBtn];
//    } else {
//        self.goToTopBtn.alpha = 0;
//    }
//}
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",_user_id,kFileName]];
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        for (int i =0; i<[array count]; i++) {
            [arrayData addObject:[ModelCardModel initModelCardListWithDict:array[i]]];
            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
            //                        [_allCells addObject:cell];
        }
        //                    }if (showPage%2 ==0) {
        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        //                    }
        
        _notinilView.hidden = YES;
        
        [waterFlow reloadData];
    }
    [waterFlow.header performSelector:@selector(beginRefreshing) withObject:nil];
}

@end
