//
//  ViewController.m
//  瀑布流demo
//
//  Created by yuxin on 15/6/6.
//  Copyright (c) 2015年 yuxin. All rights reserved.
//

#import "HomePageViewController.h"
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
@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,ZWwaterFlowDelegate,CustomTopBarDelegate,SDCycleScrollViewDelegate>
{
    CustomTopBarView *topBar;
    NSInteger showPage;
    notiNilView *_notinilView;
    HomePageHeadView *headView;
    UICollectionReusableView *reusableView;
//    MJRefreshHeader *_header;
//    MJRefreshFooterView *_footer;
}
@property (nonatomic,strong)UIScrollView *baseScrollView;
@property (nonatomic,strong )SDCycleScrollView *cycleScrollADView;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;
@property (nonatomic,strong)NSMutableArray *banners;
@property (nonatomic,strong)NSMutableDictionary *optionalParam;
@property (nonatomic,strong)NSDictionary *selectedTextField;
@end

@implementation HomePageViewController

//-(NSMutableArray *)shops
//{
//    if (_shops==nil) {
//        self.shops = [NSMutableArray array];
//    }
//    [RequestCustom requestFlowWater:nil pageNUM:@"0" pageLINE:@"10" complete:^(BOOL succed, id obj){
//        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//        if ([status isEqual:@"1"]) {
//            NSArray *dataArray = [obj objectForKey:@"data"];
//
//            if ([status isEqual:@"1"]) {
//                for (int i =0; i<[dataArray count]; i++) {
//                    [_shops addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
//                }
//                
//            }
//            [self.collectView reloadData];
//        }
//
//    }];
//    return _shops;
//}
-(NSMutableArray *)banners
{
    if (_banners ==nil) {
        self.banners = [NSMutableArray array];
    }
    return _banners;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    NSArray * shopsArray = [HomeModel objectArrayWithFilename:@"1.plist"];
//    [self.shops addObjectsFromArray:shopsArray];
    ZWCollectionViewFlowLayout * layOut = [[ZWCollectionViewFlowLayout alloc] init];
////    layOut.sectionInset = UIEdgeInsetsMake(38, 0, 0, 0);
//
    if ([layOut isKindOfClass:[ZWCollectionViewFlowLayout class]]) {
        layOut.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 180);
        layOut.itemSize = CGSizeMake(self.view.frame.size.width, layOut.itemSize.height);
    }
    layOut.degelate =self;
    //调整collectView的frame
//    SYCollectionViewFlowLayout *syLayout = [SYCollectionViewFlowLayout new];
//    syLayout.itemSize = CGSizeMake(100, 100);
//    syLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    syLayout.naviHeight = 64.0;
//    syLayout.degelate = self;
    
    //topbar
//    [self initTopBar];
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
    UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) collectionViewLayout:layOut];
    collectView.backgroundColor = listBgColor;
    collectView.delegate =self;
    collectView.dataSource =self;
    
    [self.view addSubview:collectView];
    [self initDefaultView];

    [collectView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
           withReuseIdentifier:@"header"];
    [collectView registerNib:[UINib nibWithNibName:@"HPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
//    [collectView registerClass:[SDCycleScrollView class]
//          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
//                 withReuseIdentifier:@"header"];
    [collectView registerClass:[HomePageHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScreenHeader"];

    
    self.collectView = collectView;
//    __typeof (self) __weak weakSelf = self;
    [self initRefresh];
//    MJRefreshNormalHeader *rHead = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self requestHomePageList:@"1" refreshType:@"header"];
//    }];
////    rHead.arrowView.image = [UIImage imageNamed:@"loading100.gif"];
//    self.collectView.header = rHead;
    self.collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestHomePageList:page refreshType:@"footer"];
    }];
    if (_shops==nil) {
        self.shops = [NSMutableArray array];
    }
    if (_optionalParam ==nil) {
        self.optionalParam = [[NSMutableDictionary alloc]init];
    }
    [self requestHomePageList:@"1" refreshType:@"header"];
  
//    [self.view addSubview:self.baseScrollView];
    
}

/**
 *  设置statusbar的状态
 */
-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    _notinilView    = [_notinilView initBaseNilview];
    [self.view insertSubview:_notinilView aboveSubview:self.collectView];
    _notinilView.hidden = YES;
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"首页"];
    
    topBar.menuImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
}
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
//    else
//    {
//        itemCount = 1;
//    }
    return itemCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    reusableView = nil;
        if ([kind isEqual:UICollectionElementKindSectionHeader]) {
            headView= (HomePageHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ScreenHeader" forIndexPath:indexPath];
//            headView = [[HomePageHeadView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
            headView.tag = 1001;
            [headView.styleBtn addTarget:self action:@selector(styleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [headView.typeBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [headView.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            reusableView = headView;
            return reusableView;
        }else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
            UICollectionViewCell *cycleCollectionViewCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                withReuseIdentifier:@"header"
                                                                                       forIndexPath:indexPath];
            SDCycleScrollView *cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth , 180)];
            cycleView.autoScroll = true;
            cycleView.autoScrollTimeInterval = 4.0;
            cycleView.delegate = self;
            cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            //    [self.baseScrollView addSubview:cycleView];
            
            [RequestCustom requestBanner:[NSString stringWithFormat:@"%lu",(unsigned long)[MokooMacro getUserInfo].user_id ] complete:^(BOOL succed,id obj){
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
            
            _cycleScrollADView = cycleView;
//            UICollectionViewCell *cycleCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fixed" forIndexPath:indexPath];
            cycleCollectionViewCell.frame = cycleView.frame;
//                        [[UICollectionViewCell alloc]initWithFrame:cycleView.frame];
            [cycleCollectionViewCell addSubview:cycleView];
            return cycleCollectionViewCell;

//            return cell;
        }
        
    return nil;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = listBgColor;
    cell.shop = self.shops[indexPath.item];
    UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGesture:)];
    //            personalGesture.cancelsTouchesInView = NO;
    cell.markImageView.userInteractionEnabled = YES;
    [cell.markImageView addGestureRecognizer:personalGesture];
    return cell;
//    switch (indexPath.section) {
//        case 0:
//        {
//            
//        }
//            
//            break;
//        case 1:
//        {
//            
//        }
//            
//            break;
//        default:
//            break;
//    }
//    return nil;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(0, 38);
    }
    return CGSizeZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        ShowModelCardDetailViewController *modelCardDetailVC = [[ShowModelCardDetailViewController alloc]init];
        HomeModel *model = self.shops[indexPath.item];
        modelCardDetailVC.cardId = model.card_id;
        modelCardDetailVC.user_id = model.user_id;
        [self.navigationController pushViewController:modelCardDetailVC animated:NO];
    }
}

//scrollView的代理方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollView%@",@(scrollView.contentOffset.y));
////    if (scrollView.contentOffset.y>160) {
////        headView.sd_x = 0;
////        headView.sd_y = 0;
////    }
//    // 滚动过程中判断红色view 的位置，如果位于最顶部，就从UIScrollView脱离，添加到self.view，否则就添加到UIScrollView
//   
//    // 当前view距离顶部的距离
//    CGFloat height = scrollView.contentOffset.y +64 - self.cycleScrollADView.bounds.size.height;
//    HomePageHeadView *homeHeadView = [self.collectView viewWithTag:1001];
//    NSLog(@"height%@",@(height));
//    if (height >= 0) {
////        CGRect temp = _oldRect;
////        temp.origin.y = 0;
////        self.redView.frame = temp;
////        homeHeadView = [[HomePageHeadView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, 38)];
//        homeHeadView.sd_y = 64;
//        homeHeadView.hidden = NO;
////        [reusableView removeFromSuperview];
////        [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]]
////        UICollectionViewLayoutAttributes *attributes = [self.collectView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
////        attributes.frame = CGRectMake(0, 0, attributes.frame.size.width, attributes.frame.size.height);
//        [self.view addSubview:homeHeadView];
//    }
//    else
//    {
//        homeHeadView.sd_y = 181;
////        if (homeHeadView) {
////            homeHeadView.hidden = YES;
////        }
////        [homeHeadView removeFromSuperview];
////        self.redView.frame = _oldRect;
//        [self.collectView addSubview:homeHeadView];
//    }
////    // 方法照片
////    CGFloat scale = (1 - scrollView.contentOffset.y/70);
////    NSLog(@"%f",scale);
////    scale = scale >= 1 ? scale : 1;
////    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
//}
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
        

    }else if (indexPach.section ==1)
    {
        cellHeight =  180;
    }
    return cellHeight;
}
//customTopBar代理
- (void) menuBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
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

-(void)requestHomePageList:(NSString *)page refreshType:(NSString *)type
{
    [RequestCustom requestFlowWater:_optionalParam pageNUM:page pageLINE:@"10" complete:^(BOOL succed, id obj){
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
                if ([page isEqualToString:@"1"]) {
                    [self.collectView.footer endRefreshing];

                    _notinilView.hidden = NO;
                    return;
                }else
                {
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
            NSArray *dataArray = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                
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
                    [self.collectView.header endRefreshing];
                }else if([type isEqualToString:@"footer"])
                {
                    [self.collectView.footer endRefreshing];
                }
                
                [self.collectView reloadData];
            }

        }
        
        
    }];
    
}
//
-(void)styleBtnClicked:(UIButton *)btn
{
    [SGActionView sharedActionView].style = SGActionViewStyleLight ;
    NSArray *titleArray = @[ @"欧美", @"韩版", @"日系", @"英伦",
                             @"OL风", @"学院", @"学院", @"淑女",@"性感",@"复古",@"街头",@"休闲",@"民族",@"甜美",@"运动",@"可爱",@"大码",@"中老年",@"儿童" ];
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
                                 [self requestHomePageList:@"1" refreshType:@"header"];
                             }else if(index ==1002)
                             {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:@"风格" forState:UIControlStateNormal];
                                     //                                     btn.titleLabel.text = titleArray[index - 1];
                                 }];
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
                                 [self requestHomePageList:@"1" refreshType:@"header"];

                             }else if(index ==1002)
                             {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     [btn setTitle:@"类型" forState:UIControlStateNormal];
                                     //                                     btn.titleLabel.text = titleArray[index - 1];
                                 }];
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


//- (void)setScrollADImageURLStringsArray:(NSArray *)scrollADImageURLStringsArray
//{
//    _scrollADImageURLStringsArray = scrollADImageURLStringsArray;
//    
//    _cycleScrollADView.imageURLStringsGroup = scrollADImageURLStringsArray;
//}
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
    
    self.collectView.header   = header;
    
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
