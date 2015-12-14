//
//  ShowBaseTableViewController.m
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowBaseTableViewController.h"
#import "ShowCell.h"
#import "ShowCellModel.h"
#import "MokooMacro.h"
#import "UIImage+ChangeSharp.h"
#import "UIView+SDExtension.h"
#import "MJRefresh.h"
#import "RequestCustom.h"
#import "ImageListModel.h"
#import "UIImageView+WebCache.h"
#import "XHImageViewer.h"
#import "UserInfo.h"
#import "MCFireworksButton.h"
#import "CommentSendViewController.h"
#import "MBProgressHUD.h"
//#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIButton+EnlargeTouchArea.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
#import "LoginMokooViewController.h"
@interface ShowBaseTableViewController ()<CommentSendViewDelegate,ShowDetailViewControllerDelegate>
{
    NSInteger showPage;
    NSOperationQueue *queue;
    notiNilView     *_notinilView;

}
@property (nonatomic,strong) NSMutableArray *shows;
@property (nonatomic,strong) NSMutableArray *allCells;
@property (nonatomic,strong) NSMutableArray *countedCells;
@end
#define kFileName @"showNow.plist"
@implementation ShowBaseTableViewController
@synthesize goToTopBtn =  _goToTopBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_countedCells == nil) {
        _countedCells = [NSMutableArray array];
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
//    self.tableView.tableFooterView = [[UIView alloc]init];
//    __typeof (self) __weak weakSelf = self;
    if (_shows == nil) {
        _shows = [NSMutableArray array];
        _allCells = [NSMutableArray array];
        //取数据到model并将model对象存到shows数组中
//        [self requestShowNowList:@"1" refreshType:@"header"];隐藏
        
        
        
    }
    
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self requestShowNowList:@"1" refreshType:@"header"];
//        
//    }];
    [self initRefresh];
    [self initData];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestShowNowList:page refreshType:@"footer"];
//        [self.tableView.footer endRefreshing];

    }];
    
    queue=[[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 5;
    [self initDefaultView];
//    [self.view insertSubview:self.goToTopBtn aboveSubview:self.tableView];
    [self.view setBackgroundColor:viewBgColor];
    [self.view addSubview:self.goToTopBtn];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    
    if ([_showNowType isEqualToString:@"个人中心"]) {
        if ([_seeUserId isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
            _notinilView    = [_notinilView initShowNowistNilviewByPersonalCenter];
        }else
        {
            _notinilView = [_notinilView initShowNowistNilviewByPersonalCenterOtherSee];
        }
        
    }else
    {
        _notinilView    = [_notinilView initShowNowistNilviewByType];
    }
    [self.view insertSubview:_notinilView aboveSubview:self.tableView];
    _notinilView.hidden = YES;
}

-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
//    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    
    
    _page   = 1;
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestShowNowList:@"1" refreshType:@"header"];

    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
//    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _shows.count;
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[_shows count])
    {
        ShowCell *cell  = [[ShowCell alloc] initShowCell];
        [self initCellHeight:cell withIndexPath:indexPath withModel:_shows[indexPath.row]];
//        [self initCell:cell withIndexPath:indexPath withModel:_shows[indexPath.row]];
        return cell.height;
    }
    else
    {
        return 50;
    }
    
    return 0;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<[_shows count]) {
        CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
        ShowDetailViewController *detailViewController = [[ShowDetailViewController alloc]init];
        detailViewController.path = indexPath;
        detailViewController.delegate = self;
        ShowCellModel *detaleModel = (ShowCellModel *)_shows[indexPath.row];
        detailViewController.showID = detaleModel.show_id;
        detailViewController.model = detaleModel;
        detailViewController.yOrigin = cellFrameInSuperview.origin.y;
        ((ShowDetailViewController *)detailViewController).pageTabBarIsStopOnTop = YES;
        if ([_delegate respondsToSelector:@selector(pushViewController:)]) {
            [_delegate pushViewController:detailViewController];
        }else
        {
            [self.navigationController pushViewController:detailViewController animated:NO];

        }
//                [self presentViewController:detailViewController animated:YES completion:nil];
        
    }
    else{
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    [tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    NSString *cellId = [NSString stringWithFormat:@"ShowCell"];
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        if (indexPath.row<[_shows count]) {
            cell = [[ShowCell alloc] initShowCell];
            ShowCellModel *model = _shows[indexPath.row];
            [self initCell:cell withIndexPath:indexPath withModel:model];
        }else
        {
            
        }
    }
    
    return cell;

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
-(void)passDeleteIndexPath:(NSIndexPath *)path
{
    [self.tableView beginUpdates];
    [self.shows removeObjectAtIndex:[path row]];
    NSArray *_tempIndexPathArr = [NSArray arrayWithObject:path];
    [self.tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    if ([self.shows count] ==0) {
        _notinilView.hidden = NO;
    }
}
-(void)passIndexPath:(NSIndexPath *)path model:(ShowCellModel *)model
{
    ShowCell *cell = (ShowCell *)[self.tableView cellForRowAtIndexPath:path];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowCellModel *beforeModel = self.shows[indexPath.row];
    if ([model isEqual:beforeModel]) {
        return;
    }else
    {
//        beforeModel = model;
        beforeModel.good_count = model.good_count;
        beforeModel.comment_count = model.comment_count;
        if ([model.is_zan isEqualToString:@"0"]) {
            cell.likeBtn.isSelected = NO;
            [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
            [cell.likeCountLabel setTextColor:blackFontColor];
            [cell.likeCountLabel setText:model.good_count];
            
        }else if ([model.is_zan isEqualToString:@"1"])
        {
            cell.likeBtn.isSelected = YES;
            [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
            [cell.likeCountLabel setTextColor:likeOnBtnColor];
            [cell.likeCountLabel setText:model.good_count];
        }
        
        cell.commentCountLabel.text = model.comment_count;
    }
    
    
}

- (void)initCellHeight:(ShowCell *)cell withIndexPath :(NSIndexPath *)indexPath withModel :(ShowCellModel *)model
{
    if (model.user_img !=nil) {
        
    }
    if ([model.is_verify isEqualToString:@"V"]) {
           }
    if (model.nick_name != nil) {
        
    }
    if (model.time != nil) {
        
        _height = 62.0f;
        
    }
    if (model.title !=nil&&model.title.length !=0) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
        _height = _height + textSize.height +5;
        
    }
    if (model.address !=nil&&model.address.length !=0) {
        
        CGSize textSize = [model.address boundingRectWithSize:CGSizeMake(kDeviceWidth - 81 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        _height = _height + textSize.height ;
        
    }
    //    NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];
    //    _tasksQueue.maxConcurrentOperationCount = 3;
    if ([model.imglist count]!=0) {
        
        if (model.imglist.count == 1) {
            
            
            
            
            
            _height = _height +218;
            
        } else if (model.imglist.count ==4) {
            //            NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];
                        _height = _height + HEIGHT_TWO_IMAG_WITH*2+5 +5;
            
            
        } else {
            NSInteger imagcount;
            if ([model.imglist count] > 9) {
                imagcount = 9;
            } else {
                imagcount = [model.imglist count];
            }
            //            NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];
            
            for (NSInteger i = 0; i < imagcount; i++) {
               
                NSInteger   numheight   = i/3;
                
                if (i == imagcount - 1) {
                    _height = _height + (HEIGHT_TWO_IMAG_WITH +5) *(numheight + 1)-5;
                }
                
                
                
                //                }];
                //                [_tasksQueue addOperation:getImageTask];
                
            }
            _height = _height +8;
        }
    }
    

    _height = _height + 13 +21 +13;
    cell.height = _height;
//    CALayer *lineLayer = [[CALayer alloc]init];
//    lineLayer.frame = CGRectMake(0, _height -0.8, kDeviceWidth, 0.8);
//    lineLayer.backgroundColor = [grayFontColor CGColor];
//    [cell.contentView.layer addSublayer:lineLayer];
    //    [cell.name addGestureRecognizer:creatByTap];
    //    if (![_countedCells containsObject:cell]) {
    //        [_countedCells addObject:cell];
    //    }
}
- (void)initCell:(ShowCell *)cell withIndexPath :(NSIndexPath *)indexPath withModel :(ShowCellModel *)model
{
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
        UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
        //            personalGesture.cancelsTouchesInView = NO;
        cell.avatarImageView.userInteractionEnabled = YES;
        [cell.avatarImageView addGestureRecognizer:personalGesture];
        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(65, 18, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(65.5f, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.title !=nil&&model.title.length !=0) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(65, 62, textSize.width, textSize.height);
        cell.contentLabel.text = model.title;
        _height = _height + textSize.height +5;
        [cell.contentView addSubview:cell.contentLabel];
    }
    if (model.address !=nil&&model.address.length !=0) {
        
        CGSize textSize = [model.address boundingRectWithSize:CGSizeMake(kDeviceWidth - 81 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        cell.addressImageView.frame = CGRectMake(67, _height, 9, 12);
        cell.addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.addressLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.addressLabel.frame = CGRectMake(81, _height, textSize.width, textSize.height);
        cell.addressLabel.text = model.address;
        [cell.contentView addSubview:cell.addressImageView];
        [cell.contentView addSubview:cell.addressLabel];
        
        _height = _height + textSize.height ;
        
    }
//    NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];
//    _tasksQueue.maxConcurrentOperationCount = 3;
    if ([model.imglist count]!=0) {
        
        if (model.imglist.count == 1) {
            
            ImageListModel *imageModel  = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[0])];
            UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67, _height +8, 145, 210)];
            
            NSBlockOperation *getImageTask = [NSBlockOperation blockOperationWithBlock:^{
                [imageview   sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
                            }];
            [queue addOperation:getImageTask];

                imageview.clipsToBounds = YES;
                imageview.contentMode   = UIViewContentModeScaleAspectFill;
                [cell.contentView addSubview:imageview];

                imageview.userInteractionEnabled    = YES;
                imageview.tag       = 0;
                
                UITapGestureRecognizer  *tap     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
                [imageview addGestureRecognizer:tap];
//                if ([cell.imageViewArray count] == 0) {
//                    [cell.imageViewArray addObject:imageview];
//                }
//                for (int i = 0; i<[cell.imageViewArray count]; i ++) {
//                    UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
//                    if (tmpView.tag != imageview.tag) {
//                        [cell.imageViewArray addObject:imageview];
//                    }
//                }

//            }];
//            [_tasksQueue addOperation:getImageTask];
            _height = _height +218;
            
        } else if (model.imglist.count ==4) {
//            NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];
            for (NSInteger i = 0; i < 4; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%2;
                NSInteger   numheight   = i/2;
                UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67 +(HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                NSBlockOperation *getImageTask = [NSBlockOperation blockOperationWithBlock:^{
                    [imageview sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading90.pdf"]];
                                    }];
                    [queue addOperation:getImageTask];
                    imageview.clipsToBounds = YES;
                    imageview.contentMode   = UIViewContentModeScaleAspectFill;
                    [cell.contentView addSubview:imageview];
                    imageview.userInteractionEnabled    = YES;
                    imageview.tag   =  i;
                    UITapGestureRecognizer  *tap     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
                    [imageview addGestureRecognizer:tap];

            }
            _height = _height + HEIGHT_TWO_IMAG_WITH*2+5 +5;
            
            
        } else {
            NSInteger imagcount;
            if ([model.imglist count] > 9) {
                imagcount = 9;
            } else {
                imagcount = [model.imglist count];
            }
//            NSOperationQueue *_tasksQueue=[[NSOperationQueue alloc] init];

            for (NSInteger i = 0; i < imagcount; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%3;
                NSInteger   numheight   = i/3;
                UIImageView *imageview   =[[UIImageView alloc] initWithFrame: CGRectMake(67 + (HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                NSURL *url = [NSURL URLWithString:imageModel.url];
                NSBlockOperation *getImageTask = [NSBlockOperation blockOperationWithBlock:^{
                    [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_loading90.pdf"]];
                    }];
                [queue addOperation:getImageTask];
                    imageview.clipsToBounds = YES;
                    imageview.contentMode   = UIViewContentModeScaleAspectFill;
                    [cell.contentView addSubview:imageview];
                    //                [_viewPartTwo addSubview:imageview];
                    imageview.tag   = i;
                    imageview.userInteractionEnabled    = YES;
                    UITapGestureRecognizer  *tap     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
                    [imageview addGestureRecognizer:tap];
//                    if ([cell.imageViewArray count] == 0) {
//                        [cell.imageViewArray addObject:imageview];
//                    }
//                    for (int i = 0; i<[cell.imageViewArray count] ; i ++) {
//                        UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
//                        if (tmpView.tag != imageview.tag) {
//                            [cell.imageViewArray addObject:imageview];
//                        }
//                    }
                    if (i == imagcount - 1) {
                        _height = _height + (HEIGHT_TWO_IMAG_WITH +5) *(numheight + 1)-5;
                    }
                    

                    
//                }];
//                [_tasksQueue addOperation:getImageTask];

                        }
            _height = _height +8;
        }
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(60, _height + 15, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.likeBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 13, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -64, _height + 13, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -35, _height + 13, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
    
    _height = _height + 13 +21 +13 ;
//    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    

}
-(void)requestShowNowList:(NSString *)page refreshType:(NSString *)type
{
    NSString *requestType;
    NSString *user_id;
    if ([_showNowType isEqualToString:@"个人中心"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"user_id"]) {
            user_id = [userDefaults objectForKey:@"user_id"];
        }else
        {
            user_id = nil;
        }
        [RequestCustom requestShowNow:_seeUserId currentUserId:user_id pageNUM:page pageLINE:@"5" Complete:^(BOOL succed, id obj) {
            if (succed) {
                if ([obj objectForKey:@"data"] ==[NSNull null]) {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"0"]) {
                        if (showPage==0) {
                            _notinilView.hidden = NO;
                        }
                        
                    }else
                    {
                        if (self.view.superview) {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"数据加载完毕";
                            hud.margin = 10.f;
                            hud.removeFromSuperViewOnHide = YES;
                            [hud hide:YES afterDelay:1];
                        }
                        
                        
                    }
                    if ([type isEqualToString:@"header"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView.header endRefreshing];
                            [self.tableView reloadData];
                        });
                        
                        
                    }else if([type isEqualToString:@"footer"])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView.footer endRefreshing];
                            
                            [self.tableView reloadData];
                        });
                        
                    }
                }else
                {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        NSArray *dataArray = [obj objectForKey:@"data"];
                        NSString *filePath = [self dataFilePath];
                        
                        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                            NSError *err;
                            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                        }
                        [dataArray writeToFile:[self dataFilePath] atomically:YES];
                        if ([dataArray count]==0) {
                            
                        }else{
                            if ([page isEqualToString:@"1"]) {
                                [_shows removeAllObjects];
                                showPage = 1;
                            }
                            for (int i =0; i<[dataArray count]; i++) {
                                [_shows addObject:[ShowCellModel cellModelWithDict:dataArray[i]]];
                                //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
                                //                        [_allCells addObject:cell];
                            }
                            //                    }if (showPage%2 ==0) {
                            //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
                            //                    }
                            
                            _notinilView.hidden = YES;
                            if ([type isEqualToString:@"header"]) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.tableView.header endRefreshing];
                                    [self.tableView reloadData];
                                });
                                
                                
                            }else if([type isEqualToString:@"footer"])
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.tableView.footer endRefreshing];
                                    
                                    [self.tableView reloadData];
                                });
                                
                            }
                        }
                        
                        
                        
                    }else
                    {
                        if ([type isEqualToString:@"header"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.header endRefreshing];
                                [self.tableView reloadData];
                            });
                            
                            
                        }else if([type isEqualToString:@"footer"])
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.footer endRefreshing];
                                
                                [self.tableView reloadData];
                            });
                            
                        }

                    }
                    
                }
                
            }else
            {
//                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = @"网络不给力,请检查网络";
//                hud.margin = 10.f;
//                hud.removeFromSuperViewOnHide = YES;
//                [hud hide:YES afterDelay:1];
                if ([type isEqualToString:@"header"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.header endRefreshing];
                    });
                    
                    
                }else if([type isEqualToString:@"footer"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.footer endRefreshing];
                        
                    });
                    
                }

            }

        }];
        return;
    }
    if ([_showNowType isEqualToString:@"我的关注"]) {
        requestType =@"2";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"user_id"]) {
            user_id = [userDefaults objectForKey:@"user_id"];
        }else
        {
            user_id = nil;
        }
        
    }else if ([_showNowType isEqualToString:@"所有人"])
    {
        requestType = @"1";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"user_id"]) {
            user_id = [userDefaults objectForKey:@"user_id"];
        }else
        {
            user_id = nil;
        }
    }
    [RequestCustom requestShowNow:user_id pageNUM:page pageLINE:@"5" requestType:requestType Complete:^(BOOL succed,id obj){
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"0"]) {
                    if (showPage==0) {
                        _notinilView.hidden = NO;
                    }
                    
                }else
                {
                    if (self.view.superview) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"数据加载完毕";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                    }
                    
                    
                }
                if ([type isEqualToString:@"header"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.header endRefreshing];
                        [self.tableView reloadData];
                    });
                    
                    
                }else if([type isEqualToString:@"footer"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.footer endRefreshing];
                        
                        [self.tableView reloadData];
                    });
                    
                }
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSArray *dataArray = [obj objectForKey:@"data"];
                    
                    if ([dataArray count]==0) {
                        
                    }else{
                        if ([page isEqualToString:@"1"]) {
                            [_shows removeAllObjects];
                            showPage = 1;
                        }
                        for (int i =0; i<[dataArray count]; i++) {
                            [_shows addObject:[ShowCellModel cellModelWithDict:dataArray[i]]];
                            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
                            //                        [_allCells addObject:cell];
                        }
                        //                    }if (showPage%2 ==0) {
                        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
                        //                    }
                        
                        _notinilView.hidden = YES;
                        if ([type isEqualToString:@"header"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSString *filePath = [self dataFilePath];
                                
                                if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                                    NSError *err;
                                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                                }
                                [dataArray writeToFile:[self dataFilePath] atomically:YES];
                                [self.tableView.header endRefreshing];
                                [self.tableView reloadData];
                            });
                            
                            
                        }else if([type isEqualToString:@"footer"])
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.footer endRefreshing];
                                
                                [self.tableView reloadData];
                            });
                            
                        }
                    }
                    
                    
                    
                }

            }
            
        }else
        {
            if ([_showNowType isEqualToString:@"个人中心"]) {
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
                        [self.tableView.header endRefreshing];
                    });
                    
                    
                }else if([type isEqualToString:@"footer"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.footer endRefreshing];
                        
                    });
                    
                }
            }
            
        }
        
    }];

}
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    if (_seeUserId) {
        return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@",_showNowType,_seeUserId,kFileName]];
    }else
    {
        return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",_showNowType,kFileName]];
    }
    
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        for (int i =0; i<[array count]; i++) {
            [_shows addObject:[ShowCellModel cellModelWithDict:array[i]]];
            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
            //                        [_allCells addObject:cell];
        }
        //                    }if (showPage%2 ==0) {
        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        //                    }
        
//        _notinilView.hidden = YES;
        
        [self.tableView reloadData];
//        [self.tableView.header endRefreshing];
    }
    [self.tableView.header performSelector:@selector(beginRefreshing) withObject:nil];
}
+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday;
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents*comps;
    
    // 年月日获得
    
    comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                       fromDate:date];
    
//    NSInteger year = [comps year];
//    NSString*itme;
    NSInteger month = [comps month];
    
    NSInteger day = [comps day];
//    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * todayYearString = [[today description]substringToIndex:4];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    NSString * yearString = [[date description] substringToIndex:4];
//    [[date description] substringWithRange:NSMakeRange(11, 15)];
    if ([yearString isEqualToString:todayYearString]) {
        if ([dateString isEqualToString:todayString])
        {
            return [NSString stringWithFormat:@"今天%ld%ld",(long)month,(long)day] ;
        } else if ([dateString isEqualToString:yesterdayString])
        {
            return [NSString stringWithFormat:@"昨天%@",[[date description] substringWithRange:NSMakeRange(11, 15)]] ;
        } else
        {
//            return [[date description] substringWithRange:(11,)];
        }
    }
    return nil;
}
-(void)tapClick:(UIGestureRecognizer *)tap
{
    ShowCell *cell = (ShowCell *)[[tap.view superview] superview];
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    ShowCellModel *model = self.shows[indexPath.row];
    NSInteger count = model.imglist.count;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
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
    
//    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
////    imageViewer.delegate = self;
//    [imageViewer showWithImageViews:cell.imageViewArray selectedView:(UIImageView *)tap.view];
}
-(void)likeBtnClicked:(MCFireworksButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    ShowCell *cell = (ShowCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowCellModel *model = self.shows[indexPath.row];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (btn.isSelected) {
        [RequestCustom delShowNowGoodByShowId:model.show_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    
                    btn.isSelected = NO;
                    [cell.likeCountLabel setTextColor:blackFontColor];
                    model.good_count = [NSString stringWithFormat:@"%@",@([model.good_count integerValue] -1)];
                    model.is_zan = @"0";
                    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] -1)];
                    [btn popOutsideWithDuration:0.5];
                    [btn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
                    [btn animate];
                }

            }
        }];
    }
    else {
        
        [RequestCustom addShowNowGoodByShowId:model.show_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    btn.isSelected = YES;
                    [cell.likeCountLabel setTextColor:likeOnBtnColor];
                    model.good_count = [NSString stringWithFormat:@"%@",@([model.good_count integerValue] +1)];
                    model.is_zan = @"1";
                    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] +1)];
                    [btn popInsideWithDuration:0.4];
                    [btn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
                    [btn animate];
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

    ShowCell *cell = (ShowCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowCellModel *model = self.shows[indexPath.row];

    CommentSendViewController *commentSendVC = [[CommentSendViewController alloc]initWithNibName:@"CommentSendViewController" bundle:nil];
    commentSendVC.type = @"show";
    commentSendVC.path = indexPath;
    commentSendVC.delegate = self;
    commentSendVC.showId = model.show_id;
    if ([_delegate respondsToSelector:@selector(pushCommentSendViewController:)]) {
        [_delegate pushCommentSendViewController:commentSendVC];
    }else
    {
        [self.navigationController pushViewController:commentSendVC animated:YES];

    }
}
-(void)deleBtnClicked:(UIButton *)btn
{
    ShowCell *cell = (ShowCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowCellModel *model = self.shows[indexPath.row];
    [RequestCustom deleteShowNowByShowId:model.show_id Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [self.tableView beginUpdates];
                [self.shows removeObjectAtIndex:[indexPath row]];
                NSArray *_tempIndexPathArr = [NSArray arrayWithObject:indexPath];
                [self.tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
                if ([self.shows count] ==0) {
                    _notinilView.hidden = NO;
                }
            }
        }
        
    }];

}
- (void)removeOneCell:(id)sender
{
    
}
-(void)sendSucced:(NSIndexPath *)indexPath
{
    ShowCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    ShowCellModel *model = self.shows[indexPath.row];
    model.comment_count = [NSString stringWithFormat:@"%@",@([model.comment_count integerValue] +1)];
    cell.commentCountLabel.text = model.comment_count;
    //    self.myCaretableView
    
}
-(UIButton *)goToTopBtn
{
    if(!_goToTopBtn)
    {
        _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToTopBtn.backgroundColor = [UIColor clearColor];
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-79, kDeviceHeight-139, 39, 39);
        _goToTopBtn.alpha = 0;
        [_goToTopBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToTopBtn;
}
//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
        self.tableView.frame = frame;
        
    }completion:^(BOOL finished){
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
}
-(void)imageGes:(UITapGestureRecognizer *)tap
{
    ShowCell *cell = (ShowCell *)tap.view.superview.superview;
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    ShowCellModel *model = _shows[indexpath.row];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [super scrollViewDidScroll:scrollView];
    if ([_delegate isEqual:[NSNull null]]) {
        
    }
    else
    {
        if ([_delegate respondsToSelector:@selector(passContentOffsetY:)]) {
            [_delegate passContentOffsetY:scrollView.contentOffset.y];
        }
    }
    
    
}
//-(void)dealloc
//{
//    _delegate = nil;
//    self.tableView.delegate = nil;
//    self.tableView.dataSource = nil;
//    self.tableView = nil;
//    
//}
@end
