//
//  ActivityDetailTableViewController.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityDetailTableViewController.h"
#import "XHImageViewer.h"
#import "CommentSendViewController.h"
#import "RequestCustom.h"
#import "MJRefresh.h"
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "ActivityLikeTableViewController.h"
#import "MokooMacro.h"
#import "CustomTopBarView.h"
#import "ActivityTableViewCell.h"
#import "ActivityCommentTableViewController.h"
#import "UIImageView+WebCache.h"
#import "ActivityCaseTableViewController.h"
#import "MBProgressHUD.h"
#import "LoginMokooViewController.h"
#import "ActivityTwoTableViewCell.h"
#import "PersonalCenterViewController.h"


@interface ActivityDetailTableViewController ()<TYSlidePageScrollViewDataSource,TYSlidePageScrollViewDelegate,UIAlertViewDelegate,CommentSendViewDelegate>
{
    MJRefreshNormalHeader * _header;
    CustomTopBarView *topBar;
    UIRefreshControl *refreshControl;
    ActivityCommentTableViewController *activityTableViewVC;
    ActivityTwoTableViewCell *activityCell;
}
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UILabel *titleView;

@end

@implementation ActivityDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self requestActivityDetail];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 51, 40);
    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_close.pdf"] forState:UIControlStateNormal];
//        [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.rightBtn.hidden = YES;
    self.rightBtn.userInteractionEnabled = NO;
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
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
//    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void)backBtnClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    slidePageScrollView.pageTabBarIsStopOnTop = _pageTabBarIsStopOnTop;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
    [self.view addSubview:slidePageScrollView];
    
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    activityCell = [[ActivityTwoTableViewCell alloc]initActivityCell];
    [self initTwoCell:activityCell withModel:_model];
    
//    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _slidePageScrollView.headerView = activityCell;
    
}
- (void)initTwoCell:(ActivityTwoTableViewCell *)cell  withModel :(AvtivityCellModel *)model
{
    CGFloat _height = 0;
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(10, 5, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
        UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
        cell.avatarImageView.userInteractionEnabled = YES;
        [cell.avatarImageView addGestureRecognizer:personalGesture];
        [cell.grayContentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(39, 33, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.grayContentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(60, 18, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.grayContentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        CGSize textSize = [model.time boundingRectWithSize:CGSizeMake(kDeviceWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        cell.dateLabel.frame = CGRectMake(kDeviceWidth -30 -10 -textSize.width, 18, textSize.width, 14);
        cell.dateLabel.text = model.time;
        //
        [cell.grayContentView addSubview:cell.dateLabel];
    }
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_line.pdf"]];
    lineImageView.frame = CGRectMake(0, 54, kDeviceWidth -30, 3);
    [cell.grayContentView addSubview:lineImageView];
    _height = 57.0f;
    if (model.title !=nil) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, _height +15, 5, 15)];
        blackView.backgroundColor = blackFontColor;
        cell.themeLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.themeLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.themeLabel.frame = CGRectMake(10, _height +14, kDeviceWidth - 50, textSize.height);
        cell.themeLabel.text = model.title;
        [cell.grayContentView addSubview:blackView];
        [cell.grayContentView addSubview:cell.themeLabel];
        
        _height = _height + textSize.height +18 +14;
    }
    if (model.case_desc !=nil) {
        CGSize textSize = [model.case_desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(10, _height, textSize.width, textSize.height);
        cell.contentLabel.text = model.case_desc;
        _height = _height + textSize.height +17;
        [cell.grayContentView addSubview:cell.contentLabel];
    }
    cell.grayContentView.frame = CGRectMake(15, 20, kDeviceWidth -30, _height +128);
    cell.grayContentView.layer.cornerRadius = 5;
    cell.grayContentView.layer.masksToBounds = YES;
    [cell.contentView addSubview:cell.grayContentView];
//    UIImageView *chiImageView = [[UIImageView alloc] init];
    if ([model.status isEqualToString:@"1"]) {
        cell.chiImageView.image = [UIImage imageNamed:@"notice_card_y_m"];
        
    }else if([model.status isEqualToString:@"2"]) {
        cell.chiImageView.image = [UIImage imageNamed:@"notice_card_g_m"];
    }
    cell.chiImageView.frame = CGRectMake(0, _height, kDeviceWidth -30, 3);
    [cell.grayContentView addSubview:cell.chiImageView];
    cell.whiteView.frame = CGRectMake(0, _height + 3, kDeviceWidth -30, 125);
    CALayer *topLineLayer = [[CALayer alloc]init];
    topLineLayer.frame = CGRectMake(0, 0, kDeviceWidth - 67 -13, 0.5f);
    topLineLayer.borderColor = [boardColor CGColor];
    
    CALayer *botLineLayer = [[CALayer alloc]init];
    botLineLayer.frame = CGRectMake(0, 98.5f, kDeviceWidth - 67 -13, 0.5f);
    botLineLayer.borderColor = [boardColor CGColor];
    if ([model.status isEqualToString:@"1"]) {
        cell.whiteView.backgroundColor = activityOrangeBackgroundColor;
        
    }else if([model.status isEqualToString:@"2"]) {
        cell.whiteView.backgroundColor = activityGrayBackgroundColor;
        cell.moneyView.image = [UIImage imageNamed:@"notice_price_w.pdf"];
        cell.timeView.image = [UIImage imageNamed:@"notice_time_w.pdf"];
        cell.locationView.image = [UIImage imageNamed:@"notice_location_w.pdf"];
        cell.personNumView.image = [UIImage imageNamed:@"notice_people_w.pdf"];
        [cell.timeLabel setTextColor:[UIColor whiteColor]];
        [cell.moneyLabel setTextColor:[UIColor whiteColor]];
        [cell.locationLabel setTextColor:[UIColor whiteColor]];
        [cell.personNumLabel setTextColor:[UIColor whiteColor]];
    }
    cell.moneyView.frame = CGRectMake(10, 20, 13, 13);
    cell.moneyLabel.frame = CGRectMake(28, 20, kDeviceWidth - 67 -13 -33, 13);
    [cell.moneyLabel setText:model.price];
    cell.timeView.frame = CGRectMake(10, 53, 13, 13);
    cell.timeLabel.frame = CGRectMake(28, 53, kDeviceWidth - 67 -13 -33, 13);
    [cell.timeLabel setText:[NSString stringWithFormat:@"%@-%@",model.start,model.end]];
    cell.locationView.frame = CGRectMake(10, 86, 13, 13);
    cell.locationLabel.frame = CGRectMake(28, 86, kDeviceWidth - 67 -13 -33, 13);
    [cell.locationLabel setText:model.address];
    CGSize textSize = [[NSString stringWithFormat:@"人数：%@",model.need_count] boundingRectWithSize:CGSizeMake(kDeviceWidth - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.personNumLabel.frame = CGRectMake(kDeviceWidth -30 -10 -textSize.width,20 , textSize.width, 13);
    [cell.personNumLabel setText:[NSString stringWithFormat:@"人数：%@",model.need_count]];
    cell.personNumView.frame = CGRectMake(kDeviceWidth -30 -10 -textSize.width -13-5, 20, 13, 13);
    [cell.whiteView addSubview:cell.moneyView];
    [cell.whiteView addSubview:cell.moneyLabel];
    [cell.whiteView addSubview:cell.timeView];
    [cell.whiteView addSubview:cell.timeLabel];
    [cell.whiteView addSubview:cell.locationView];
    [cell.whiteView addSubview:cell.locationLabel];
    [cell.whiteView addSubview:cell.personNumView];
    [cell.whiteView addSubview:cell.personNumLabel];
    [cell.whiteView.layer addSublayer:topLineLayer];
    [cell.whiteView.layer addSublayer:botLineLayer];
    [cell.grayContentView addSubview:cell.whiteView];
    _height = _height + 128;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(20, _height + 7+20, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.likeBtn.frame = CGRectMake(kDeviceWidth - 182,  _height + 5 +20, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth- 153, _height +5+20, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
    
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 5+20, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 5+20, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
    
    cell.activityBtn.frame = CGRectMake(kDeviceWidth -64, _height + 5+20, 21, 21);
    [cell.activityBtn addTarget:self action:@selector(activityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cell.activityBtn];
    
    if (model.apply_count !=nil) {
        cell.activityLabel.frame = CGRectMake(kDeviceWidth -35, _height + 5+20, 21, 21);
        cell.activityLabel.text = model.apply_count;
        [cell.contentView addSubview:cell.activityLabel];
    }
    _height = _height + 5 +21 +5 +20 +8;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    //    [cell.name addGestureRecognizer:creatByTap];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, _height);
    //为了取她，跨越101.......
    cell.tag = 103;

}

- (void)initCell:(ActivityTableViewCell *)cell withModel :(AvtivityCellModel *)model
{
    CGFloat _height = 0;
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
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
        cell.dateLabel.frame = CGRectMake(65, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.title !=nil) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 90 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.themeImageView.frame = CGRectMake(65, 64, 13, 13);
        cell.themeLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.themeLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.themeLabel.frame = CGRectMake(88, 62, kDeviceWidth -88- 13, 17);
        cell.themeLabel.text = model.title;
        [cell.contentView addSubview:cell.themeImageView];
        [cell.contentView addSubview:cell.themeLabel];
        CALayer *imageOneLineLayer = [[CALayer alloc]init];
        imageOneLineLayer.frame = CGRectMake(65, _height +17 +3, 3, 1);
        imageOneLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:imageOneLineLayer];
        CALayer *imageTwoLineLayer = [[CALayer alloc]init];
        imageTwoLineLayer.frame = CGRectMake(70, _height +17 +3, 8, 1);
        imageTwoLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:imageTwoLineLayer];
        CALayer *labelLineLayer = [[CALayer alloc]init];
        labelLineLayer.frame = CGRectMake(88, _height +17 +3, textSize.width, 1);
        labelLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:labelLineLayer];
        _height = _height + 17 +5;
    }

    if (model.case_desc !=nil) {
        CGSize textSize = [model.case_desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(65, _height, textSize.width, textSize.height);
        cell.contentLabel.text = model.case_desc;
        _height = _height + textSize.height;
        [cell.contentView addSubview:cell.contentLabel];
    }
    cell.whiteView.frame = CGRectMake(65, _height + 5, kDeviceWidth - 67 -13, 99);
    CALayer *topLineLayer = [[CALayer alloc]init];
    topLineLayer.frame = CGRectMake(0, 0, kDeviceWidth - 67 -13, 0.5f);
    topLineLayer.borderColor = [boardColor CGColor];
    
    CALayer *botLineLayer = [[CALayer alloc]init];
    botLineLayer.frame = CGRectMake(0, 98.5f, kDeviceWidth - 67 -13, 0.5f);
    botLineLayer.borderColor = [boardColor CGColor];
    cell.whiteView.backgroundColor = whiteFontColor;
    
    cell.moneyView.frame = CGRectMake(11, 11, 13, 13);
    cell.moneyLabel.frame = CGRectMake(33, 11, kDeviceWidth - 67 -13 -33, 13);
    [cell.moneyLabel setText:model.price];
    cell.timeView.frame = CGRectMake(11, 33, 13, 13);
    cell.timeLabel.frame = CGRectMake(33, 33, kDeviceWidth - 67 -13 -33, 13);
    [cell.timeLabel setText:[NSString stringWithFormat:@"%@-%@",model.start,model.end]];
    cell.locationView.frame = CGRectMake(11, 55, 13, 13);
    cell.locationLabel.frame = CGRectMake(33, 55, kDeviceWidth - 67 -13 -33, 13);
    [cell.locationLabel setText:model.address];
    cell.personNumView.frame = CGRectMake(11, 77, 13, 13);
    cell.personNumLabel.frame = CGRectMake(33, 77, kDeviceWidth - 67 -13 -33, 13);
    [cell.personNumLabel setText:model.need_count];
    [cell.whiteView addSubview:cell.moneyView];
    [cell.whiteView addSubview:cell.moneyLabel];
    [cell.whiteView addSubview:cell.timeView];
    [cell.whiteView addSubview:cell.timeLabel];
    [cell.whiteView addSubview:cell.locationView];
    [cell.whiteView addSubview:cell.locationLabel];
    [cell.whiteView addSubview:cell.personNumView];
    [cell.whiteView addSubview:cell.personNumLabel];
    [cell.whiteView.layer addSublayer:topLineLayer];
    [cell.whiteView.layer addSublayer:botLineLayer];
    [cell.contentView addSubview:cell.whiteView];
    _height = _height + 99;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(60, _height + 15, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    //    (kDeviceWidth - 182,  _height + 13, 21, 21)
    //    CGRectMake(kDeviceWidth- 153, _height +13, 21, 21)
    cell.likeBtn.frame = CGRectMake(kDeviceWidth - 182,  _height + 13, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth- 153, _height +13, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
    //    CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21)
    //     CGRectMake(kDeviceWidth -94, _height + 13, 21, 21)
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 13, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
    //    CGRectMake(kDeviceWidth -64, _height + 13, 21, 21)
    //    CGRectMake(kDeviceWidth -35, _height + 13, 21, 21)
    cell.activityBtn.frame = CGRectMake(kDeviceWidth -64, _height + 13, 21, 21);
    [cell.activityBtn addTarget:self action:@selector(activityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cell.activityBtn];
//    [cell.activityBtn addTarget:self action:@selector(activityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.apply_count !=nil) {
        cell.activityLabel.frame = CGRectMake(kDeviceWidth -35, _height + 13, 21, 21);
        cell.activityLabel.text = model.apply_count;
        [cell.contentView addSubview:cell.activityLabel];
    }
    _height = _height + 13 +21 +13;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    //    [cell.name addGestureRecognizer:creatByTap];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, _height);
    //为了取她，跨越101.......
    cell.tag = 103;
}


- (void)addTabPageMenu
{
    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"赞",@"评论",@"报名"]];
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 38);
    titlePageTabBar.backgroundColor = whiteFontColor;
    _slidePageScrollView.pageTabBar = titlePageTabBar;
}
- (void)addTableViewWithPage:(NSInteger)page itemNum:(NSInteger)num
{
    if (page ==0) {
        ActivityLikeTableViewController *tableViewVC = [[ActivityLikeTableViewController alloc]init];
        tableViewVC.itemNum = num;
        tableViewVC.page = page;
        tableViewVC.case_id = self.model.case_id;
        [self addChildViewController:tableViewVC];
    }else if(page ==1)
    {
        activityTableViewVC = [[ActivityCommentTableViewController alloc]init];
//        tableViewVC.itemNum = num;
//        tableViewVC.page = page;
        activityTableViewVC.case_id = self.model.case_id;
        [self addChildViewController:activityTableViewVC];
        
    }else if (page ==2)
    {
        ActivityCaseTableViewController *caseVC = [[ActivityCaseTableViewController alloc]init];
        caseVC.user_id = self.model.user_id;
        caseVC.case_id = self.model.case_id;
        [self addChildViewController:caseVC];

    }
    
    
    // don't forget addChildViewController
}
#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    if (index ==0) {
        ActivityLikeTableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }else if(index ==1)
    {
        ActivityCommentTableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }else if (index ==2)
    {
        ActivityCaseTableViewController *tableViewVC = self.childViewControllers[index];
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
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
        if (buttonIndex == 0) {
            
        }else if (buttonIndex ==1)
        {
            ActivityCaseTableViewController *tableViewVC = self.childViewControllers[2];
            [tableViewVC.tableView.header beginRefreshing];
            [RequestCustom addActivityCaseById:_model.case_id Complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        if ([_model.apply_count isEqualToString:@"0"]) {
                            tableViewVC.notinilView.hidden = YES;
                        }
                        ActivityTwoTableViewCell *cell = (ActivityTwoTableViewCell *)_slidePageScrollView.headerView;
                        _model.apply_count = [NSString stringWithFormat:@"%@",@([_model.apply_count integerValue] +1)];
                        cell.activityLabel.text = _model.apply_count;
                        [tableViewVC.tableView.header endRefreshing];
                    }else if ([status isEqualToString:@"2"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"您已经报过名了";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];

                    }
                }
            }];
        }
    
    
}

-(void)likeBtnClicked:(MCFireworksButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    ActivityTwoTableViewCell *cell = (ActivityTwoTableViewCell *)[[btn superview] superview];
    //    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //    ShowCellModel *model = self.shows[indexPath.row];
    ActivityLikeTableViewController *tableViewVC = self.childViewControllers[0];
    [tableViewVC.tableView.header beginRefreshing];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (btn.isSelected) {
        [RequestCustom delActivityGoodByCaseId:self.model.case_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
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
                    //保证缺省页面的正确显示
                    if ([_model.good_count isEqualToString:@"0"]) {
                        tableViewVC.notinilView.hidden = NO;
                    }
                    
                    //                ActivityCaseTableViewController *tableViewVC = self.childViewControllers[0];
                    [tableViewVC.tableView.header endRefreshing];
                }
            }
            
        }];
    }
    else {
        
        [RequestCustom addActivityGoodByCaseId:self.model.case_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
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
                    //                ActivityCaseTableViewController *tableViewVC = self.childViewControllers[0];
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
//    commentSendVC.path = 
    commentSendVC.delegate = self;
    commentSendVC.showId = self.model.case_id;
    commentSendVC.type = @"case";

    [self.navigationController pushViewController:commentSendVC animated:YES];
}
-(void)activityBtnClicked:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    //判断活动是否已经关闭
    if ([self.model.status isEqualToString:@"2"]) {//活动关闭不能报名
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前活动已关闭,不能报名";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"1"]) {//不是模特不能报名
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您不是模特哦，请到个人中心升级模特";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        
        return;
    }
    
//    if ([self.model.user_type isEqualToString:@"1"]) {
//        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"您不是模特哦，请到个人中心升级模特";
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1];
//        return;
//    }
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:self.model.user_id]) {
//        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"这是您发布的活动，您不能报名";
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1];
//        return;
//    }
    //有空了改用UIAlertController
    UIAlertView *alerts = [[UIAlertView alloc]initWithTitle:@"是否报名?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerts show];
}
-(void)deleBtnClicked:(UIButton *)btn
{
    [RequestCustom deleteActivityByCaseId:self.model.case_id Complete:^(BOOL succed, id obj) {
        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
        if ([status isEqual:@"1"]) {
            //改为list请求数据block
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }];
    
}
-(void)sendSucced:(NSIndexPath *)indexPath
{
    [activityTableViewVC.tableView.header beginRefreshing];
}
-(void)RefreshViewControlEventValueChanged
{
    
    
}
-(void)imageGes:(UITapGestureRecognizer *)tap
{
    
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    
    personalViewController.user_id = self.model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
-(void)requestActivityDetail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    [RequestCustom requestActivityDetail:user_id caseId:_caseID Complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSDictionary *dataDict = [obj objectForKey:@"data"];
                    _model = [AvtivityCellModel cellModelWithDict:dataDict];
                    if ([_model.user_id isEqualToString:user_id]) {
                        if ([self.model.status isEqualToString:@"1"]) {
                            self.rightBtn.hidden = NO;
                            self.rightBtn.userInteractionEnabled = YES;
                        }else if ([self.model.status isEqualToString:@"2"])
                        {
                            self.rightBtn.hidden = YES;
                            self.rightBtn.userInteractionEnabled = NO;
                        }

                    }
                    [self addSlidePageScrollView];
                    
                    [self addHeaderView];
                    
                    [self addTabPageMenu];
                    
                    [self addTableViewWithPage:0 itemNum:6];
                    [self addTableViewWithPage:1 itemNum:12];
                    [self addTableViewWithPage:2 itemNum:10];
                    
                    [_slidePageScrollView reloadData];
                    if (_clickedPageTabBarIndex) {
                        [_slidePageScrollView.pageTabBar clickedPageTabBarAtIndex:_clickedPageTabBarIndex];
                    }
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
-(void)cameraBtnClicked:(UIButton *)btn
{
    [RequestCustom requestCloseActivityByCaseId:_model.case_id Complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.rightBtn.hidden = YES;
                        self.rightBtn.userInteractionEnabled = NO;
                        activityCell.whiteView.backgroundColor = activityGrayBackgroundColor;
                        activityCell.moneyView.image = [UIImage imageNamed:@"notice_price_w.pdf"];
                        activityCell.timeView.image = [UIImage imageNamed:@"notice_time_w.pdf"];
                        activityCell.locationView.image = [UIImage imageNamed:@"notice_location_w.pdf"];
                        activityCell.personNumView.image = [UIImage imageNamed:@"notice_people_w.pdf"];
                        [activityCell.timeLabel setTextColor:[UIColor whiteColor]];
                        [activityCell.moneyLabel setTextColor:[UIColor whiteColor]];
                        [activityCell.locationLabel setTextColor:[UIColor whiteColor]];
                        [activityCell.personNumLabel setTextColor:[UIColor whiteColor]];
                        activityCell.chiImageView.image = [UIImage imageNamed:@"notice_card_g_m"];
                        
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"关闭成功";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                    });
                }
                
            }
            
        }

    }];
}

@end
