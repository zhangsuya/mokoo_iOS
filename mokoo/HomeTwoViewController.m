//
//  HomeTwoViewController.m
//  mokoo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "HomeTwoViewController.h"
#import "ZWCollectionViewFlowLayout.h"
#import "ZWCollectionViewCell.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "MokooMacro.h"
#import "CustomTopBarView.h"
#import "HomePageHeadView.h"
#import "SGActionView.h"
#import "ChooseGridView.h"
#import "MJRefresh.h"
#import "RequestCustom.h"
#import "BannerModel.h"
#import "PersonalCenterViewController.h"
#import "MBProgressHUD.h"
#import "HPCollectionViewCell.h"
#import "ShowModelCardDetailViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "SYCollectionViewFlowLayout.h"
#import "notiNilView.h"
#import "UIView+SDExtension.h"
#import "ZWTwoCollectionViewLayout.h"
#import "HomeTwoPageHeadView.h"
@interface HomeTwoViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate,ZWTwowaterFlowDelegate>
{
    UITableView *baseTableView;
    notiNilView *_notinilView;
    NSInteger showPage;
    NSString *styleName;
    NSString *typeName;
}
@property (nonatomic,strong )SDCycleScrollView *cycleScrollADView;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;
@property (nonatomic,strong)NSMutableArray *banners;
@property (nonatomic,strong)NSMutableDictionary *optionalParam;
@property (nonatomic,strong)NSDictionary *selectedTextField;

@end
#define kFileName @"homePage.plist"
@implementation HomeTwoViewController
@synthesize goToTopBtn =  _goToTopBtn;
-(NSMutableArray *)banners
{
    if (_banners ==nil) {
        self.banners = [NSMutableArray array];
    }
    return _banners;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_shops==nil) {
        self.shops = [NSMutableArray array];
    }
    if (_optionalParam ==nil) {
        self.optionalParam = [[NSMutableDictionary alloc]init];
    }
    [self initTableView];
    [self initNavigationItem];

    [self initRefresh];
//    self.automaticallyAdjustsScrollViewInsets = NO;

//    [self requestHomePageList:@"1" refreshType:@"header"];//隐藏
    [self initData];
//    [self initDefaultView];
    
    

    // Do any additional setup after loading the view.
}
-(void)initTableView
{
    baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight )];
    baseTableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight +180 +38);
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
//    baseTableView.scrollEnabled = YES;
    [baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"fixed"];
    [baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [baseTableView registerClass:[HomePageHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScreenHeader"];
//    [baseTableView reloadData];
//    [baseTableView registerNib:[UINib nibWithNibName:@"HPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //
    
//    [baseTableView registerClass:[HomePageHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScreenHeader"];
    [self.view addSubview:baseTableView];
}
-(void)initDefaultViewWithCell:(UITableViewCell *)cell
{
    _notinilView    = [[notiNilView alloc] init];
    _notinilView    = [_notinilView initBaseNilviewWithHeight:kDeviceHeight - 64];
    [cell insertSubview:_notinilView aboveSubview:self.collectView];
    _notinilView.hidden = YES;
}
-(void)initNavigationItem
{

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 34, 20)];
    titleImageView.image = [UIImage imageNamed:@"home_logo.pdf"];
    _titleImageView = titleImageView;
    self.navigationItem.titleView = _titleImageView;
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return 38;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger itemCount;
    if (section ==1) {
        itemCount = 1;
        
    }else
    {
        itemCount = 1;
    }
    return itemCount;
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 180;
    }
    else
    {
        return kDeviceHeight -38 -64;
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeTwoPageHeadView *headView = [[HomeTwoPageHeadView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 38)];
    if (styleName) {
        [headView.styleBtn setTitle:styleName forState:UIControlStateNormal];
    }
    if (typeName) {
        [headView.typeBtn setTitle:typeName forState:UIControlStateNormal];
    }
    [headView.styleBtn addTarget:self action:@selector(styleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView.typeBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return headView;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row<[_shows count]) {
//        ShowDetailViewController *detailViewController = [[ShowDetailViewController alloc]init];
//        detailViewController.path = indexPath;
//        detailViewController.delegate = self;
//        ShowCellModel *detaleModel = (ShowCellModel *)_shows[indexPath.row];
//        detailViewController.showID = detaleModel.show_id;
//        ((ShowDetailViewController *)detailViewController).pageTabBarIsStopOnTop = YES;
//        if ([_delegate respondsToSelector:@selector(pushViewController:)]) {
//            [_delegate pushViewController:detailViewController];
//        }else
//        {
//            [self.navigationController pushViewController:detailViewController animated:NO];
//            
//        }
//        //                [self presentViewController:detailViewController animated:YES completion:nil];
//        
//    }
//    else{
//        
//    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    [tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    switch (indexPath.section) {
        case 0:
        {
            SDCycleScrollView *cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 180)];
            cycleView.autoScroll = true;
            cycleView.autoScrollTimeInterval = 4.0;
            cycleView.delegate = self;
            cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            [RequestCustom requestBanner:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] complete:^(BOOL succed,id obj){
                if (succed) {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        NSArray *dataArray = [obj objectForKey:@"data"];
                        //                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                        NSMutableArray *imageArray = [NSMutableArray array];
                        if ([status isEqual:@"1"]) {
                            for (int i =0; i<[dataArray count]; i++) {
                                [_banners addObject:[BannerModel initBannerWithDict:dataArray[i]]];
                                [imageArray addObject:[dataArray[i] objectForKey:@"img_url"]];
                            }
                            cycleView.imageURLStringsGroup = imageArray;
                            
                        }
                    }
                    
                }
                
            }];
            //    [self.baseScrollView addSubview:cycleView];
            _cycleScrollADView = cycleView;
            
            
            
            UITableViewCell *cycleCollectionViewCell = [tableView dequeueReusableCellWithIdentifier:@"fixed" forIndexPath:indexPath ];
            cycleCollectionViewCell.frame = cycleView.frame;
            //            [[UICollectionViewCell alloc]initWithFrame:cycleView.frame];
            [cycleCollectionViewCell addSubview:cycleView];
            return cycleCollectionViewCell;
        }
            
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath ];
            ZWTwoCollectionViewLayout * layOut = [[ZWTwoCollectionViewLayout alloc] init];
            ////    layOut.sectionInset = UIEdgeInsetsMake(38, 0, 0, 0);
            //
            layOut.degelate =self;
            UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight -64) collectionViewLayout:layOut];
            collectView.backgroundColor = listBgColor;
            collectView.delegate =self;
            collectView.dataSource =self;
            collectView.scrollEnabled = YES;
            cell.frame = collectView.frame;
            [cell addSubview:collectView];
            
            
            [collectView registerNib:[UINib nibWithNibName:@"HPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
            
            self.collectView = collectView;
            [self.view insertSubview:self.goToTopBtn aboveSubview:self.collectView];

            [self initDefaultViewWithCell:cell];
            if (self.collectView.footer) {
                
            }else
            {
                self.collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    // 进入刷新状态后会自动调用这个block
                    showPage += 1;
                    NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
                    [self requestHomePageList:page refreshType:@"footer"];
                }];

            }
            [self.collectView reloadData];
            return cell;
        }
            
            break;
        default:
            break;
    }
    return nil;

    
    
}
//实现tableview分割线从左到右占满，于viewload代码相对应
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    //
    //        [cell setSeparatorInset:UIEdgeInsetsZero];
    //
    //    }
    //
    //    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    //
    //        [cell setLayoutMargins:UIEdgeInsetsZero];
    //        
    //    }
    
    
}
//代理方法
-(CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    CGFloat cellHeight;
    if (indexPach.section ==0) {
        HomeModel * shop;
        
        //        if (indexPach.item ==nil) {
        //            shop = self.shops[0];
        //
        //        }else
        //        {
        shop = self.shops[indexPach.item];
        
        //        }
        
        //        cell.s
        
        cellHeight =  shop.height/shop.width*width;
        
        
    }
    return cellHeight;
}
//collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemCount;
    if (section ==0) {
        itemCount = self.shops.count;
        
    }
    return itemCount;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = listBgColor;
    cell.shop = self.shops[indexPath.item];
    UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGesture:)];
            //            personalGesture.cancelsTouchesInView = NO;
    cell.markImageView.userInteractionEnabled = YES;
    [cell.markImageView addGestureRecognizer:personalGesture];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowModelCardDetailViewController *modelCardDetailVC = [[ShowModelCardDetailViewController alloc]init];
    HomeModel *model = self.shops[indexPath.item];
    modelCardDetailVC.cardId = model.card_id;
    modelCardDetailVC.user_id = model.user_id;
    [self.navigationController pushViewController:modelCardDetailVC animated:NO];
}

- (void)clicked {
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
}
//SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //广告页跳转
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollView%@",@(scrollView.contentOffset.y));
//    //    if (scrollView.contentOffset.y>160) {
//    //        headView.sd_x = 0;
//    //        headView.sd_y = 0;
//    //    }
//
//    if ([scrollView isEqual:baseTableView]) {
//        self.collectView.contentOffset = CGPointMake(0, baseTableView.contentOffset.y);

//    }else if([scrollView isEqual:self.collectView])
//    {
//        baseTableView.contentOffset = CGPointMake(0, self.collectView.contentOffset.y);
//    }

    NSLog(@"tableview%@,collectView%@",@(baseTableView.contentOffset.y),@(self.collectView.contentOffset.y));
    if ([scrollView isEqual:self.collectView]) {
        CGFloat height = scrollView.contentOffset.y   - 180 -38;
        NSLog(@"collectView%@",@(scrollView.contentOffset.y));

//        NSLog(@"height%@",@(height));
        if (height <=0) {
            baseTableView.contentOffset = CGPointMake(0, self.collectView.contentOffset.y-64  );//-64

//            baseTableView.scrollEnabled = NO;
//            self.collectView.scrollEnabled = YES;
        }
        
    }
    
    if ( self.collectView.contentOffset.y > 600) {
        self.goToTopBtn.alpha = 1;
        //        [self.view bringSubviewToFront:_goToTopBtn];
    } else {
        self.goToTopBtn.alpha = 0;
    }
//    if ([scrollView isEqual:self.collectView]) {
//        if (scrollView.contentOffset.y>0) {
//            baseTableView.scrollEnabled = NO;
////            self.collectView.scrollEnabled = YES;
//
//        }else
//        {
//            baseTableView.scrollEnabled = YES;
//            self.collectView.scrollEnabled = NO;
//        }
//    }
    
//
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)requestHomePageList:(NSString *)page refreshType:(NSString *)type
{
    [RequestCustom requestFlowWater:_optionalParam pageNUM:page pageLINE:@"10" complete:^(BOOL succed, id obj){
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
                if ([page isEqualToString:@"1"]) {
                    [_shops removeAllObjects];
                    [baseTableView.header endRefreshing];
                    [self.collectView reloadData];

                    _notinilView.hidden = NO;
                    return;
                }else
                {
                    if (self.view) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"数据加载完毕";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                        [self.collectView.footer endRefreshing];
                        return ;
                    }
                    
                }
                
            }
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                NSArray *dataArray = [obj objectForKey:@"data"];
                if ([status isEqual:@"1"]) {
                    

                    if ([page isEqualToString:@"1"]) {
                        [_shops removeAllObjects];
                        showPage = 1;
                    }
                    for (int i =0; i<[dataArray count]; i++) {
                        [_shops addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
                    }
                    
                }
                _notinilView.hidden = YES;
                if ([type isEqualToString:@"header"]) {
                    NSString *filePath = [self dataFilePath];
                    
                    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                        NSError *err;
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                    }
                    
//                     BOOL succed =[dataArray writeToFile:[self dataFilePath] atomically:YES];
                    //因为直接写入不成功，所以序列化一下
                    [NSKeyedArchiver archiveRootObject:dataArray toFile:filePath];
                    [baseTableView.header endRefreshing];
                    [baseTableView reloadData];

                }else if([type isEqualToString:@"footer"])
                {
                    [self.collectView.footer endRefreshing];
                    [self.collectView reloadData];
                }

            }
            
        }else
        {
            if (self.view.superview) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络不给力,请检查网络";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
            
            if ([type isEqualToString:@"header"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [baseTableView.header endRefreshing];
                });
                
                
            }else if([type isEqualToString:@"footer"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [baseTableView.footer endRefreshing];
                    
                });
                
            }

        }
        
        
    }];
    
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
        
        [self requestHomePageList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    baseTableView.header   = header;
    
    
}
//
-(void)styleBtnClicked:(UIButton *)btn
{
    [SGActionView sharedActionView].style = SGActionViewStyleLight ;
    NSArray *titleArray = @[ @"欧美", @"韩版", @"日系", @"英伦",
                             @"OL风", @"学院", @"淑女",@"性感",@"复古",@"街头",@"休闲",@"民族",@"甜美",@"运动",@"可爱",@"大码",@"中老年",@"儿童" ];
    //    ChooseGridView *chooseView = [[ChooseGridView alloc]initWithTitleArray:@[ @"Facebook", @"Twitter", @"Google+", @"Linkedin",@"weibo", @"wechat", @"Pocket", @"Dropbox" ]];
    NSString *style;
    if ([[_optionalParam objectForKey:@"style"] integerValue]!=0) {
        style =titleArray[[[_optionalParam objectForKey:@"style"] integerValue] -1];
    }else
    {
        style = @"";
    }
    [SGActionView showGridMenuWithTitle:style
                             itemTitles:titleArray
                                 images:@[ [UIImage imageNamed:@"calendar_circle_b.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_l.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"]]
                         selectedHandle:^(NSInteger index){
                             if (index != 0&&index!=1002) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:titleArray[index -1] forState:UIControlStateNormal];
                                     //                                     btn.titleLabel.text = titleArray[index - 1];
                                 }];
                                 [_optionalParam setObject:@(index)  forKey:@"style"];
                                 styleName = titleArray[index -1];
                                 [self requestHomePageList:@"1" refreshType:@"header"];
                             }else if(index ==1002)
                             {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:@"风格" forState:UIControlStateNormal];
                                     //                                     btn.titleLabel.text = titleArray[index - 1];
                                 }];
                                 styleName =  @"风格";
                                 [_optionalParam setObject:@(0)  forKey:@"style"];
                                 [self requestHomePageList:@"1" refreshType:@"header"];
                             }
                             
                         }];
    //    [self performSelector:@selector(doAfter) withObject:nil afterDelay:10];
    
}
-(void)typeBtnClicked:(UIButton *)btn
{
    [SGActionView sharedActionView].style = SGActionViewStyleLight ;
    NSArray *titleArray = @[ @"走秀"
                             ,@"车模"
                             ,@"平面",
                             @"展示",
                             @"试衣",
                             @"礼仪",
                             @"外籍",
                             @"腿模",
                             @"手模",
                             @"胸模",
                             @"混血",
                             @"歌手",
                             @"演员",
                             @"舞蹈",
                             @"cosplay",
                             @"showgirl",
                             @"主持人",
                             @"化妆师",
                             @"造型师" ];
    //    ChooseGridView *chooseView = [[ChooseGridView alloc]initWithTitleArray:@[ @"Facebook", @"Twitter", @"Google+", @"Linkedin",@"weibo", @"wechat", @"Pocket", @"Dropbox" ]];
    NSString *type;
    if ([[_optionalParam objectForKey:@"work_type"] integerValue] !=0) {
        type = titleArray[[[_optionalParam objectForKey:@"work_type"] integerValue] -1];
    }else
    {
        type = @"";
    }
    [SGActionView showGridMenuWithTitle:type
                             itemTitles:titleArray
                                 images:@[ [UIImage imageNamed:@"calendar_circle_b.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_l.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"],
                                           [UIImage imageNamed:@"calendar_circle_g_s.pdf"]]
                         selectedHandle:^(NSInteger index){
                             if (index != 0 &&index!=1002) {
                                 NSLog(@"%ld",(long)index);
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:titleArray[index - 1] forState:UIControlStateNormal];
                                 }];
                                 [_optionalParam setObject:@(index) forKey:@"work_type"];
                                 typeName = titleArray[index - 1];
                                 [self requestHomePageList:@"1" refreshType:@"header"];
                                 
                             }else if(index ==1002)
                             {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:@"类型" forState:UIControlStateNormal];
                                     //                                     btn.titleLabel.text = titleArray[index - 1];
                                 }];
                                 typeName = @"类型";
                                 [_optionalParam setObject:@(0)  forKey:@"work_type"];
                                 [self requestHomePageList:@"1" refreshType:@"header"];
                             }
                             
                         }];
    
}
-(void)moreBtnClicked:(UIButton *)btn
{
    [SGActionView sharedActionView].style = SGActionViewStyleLight ;
    [[SGActionView sharedActionView] showTextFieldWithselectedDict:_optionalParam selectedHandle:^(NSDictionary *selectedDict) {
        [_optionalParam addEntriesFromDictionary:selectedDict];
        [self requestHomePageList:@"1" refreshType:@"header"];
    }];
    
}
-(void)doAfter
{
    
}
-(void)imageGesture:(UIGestureRecognizer *)tap
{
    HPCollectionViewCell * cell = (HPCollectionViewCell *)tap.view.superview.superview;
    NSIndexPath *indexPath = [_collectView indexPathForCell:cell];
    cell.shop = self.shops[indexPath.item];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = cell.shop.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
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
        
        
        
    }completion:^(BOOL finished){
        
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
    
    
}
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",kFileName]];
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
//        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        //因为直接写入不成功，所以序列化一下,这里反序列化取出
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        for (int i =0; i<[array count]; i++) {
            [_shops addObject:[HomeModel initHomeModelWithDict:array[i]]];
            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
            //                        [_allCells addObject:cell];
        }
        //                    }if (showPage%2 ==0) {
        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        //                    }
        
        _notinilView.hidden = YES;
        //先加载缓存数据
        [baseTableView reloadData];
    }
    //后加载新数据
    [baseTableView.header performSelector:@selector(beginRefreshing) withObject:nil];
}
@end
