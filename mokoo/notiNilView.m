//
//  notiNilView.m
//  Mokoo
//
//  Created by 常大人 on 15/9/10.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import "notiNilView.h"
#import "UIImage+GIF.h"
#import "MokooMacro.h"
@interface notiNilView () {
    IBOutlet    UIImageView *_imageview;
    IBOutlet    UILabel     *_lblOne;
    IBOutlet    UILabel     *_lblTwo;
    
    IBOutlet    UIButton    *_btnAddFriend;
}

@end

@implementation notiNilView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initActivityListNilviewByType:(NSString *)_showNowType {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    self.backgroundColor   = viewBgColor;
    
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
//    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
//    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
//    [self addSubview:_imageview];
    
    _lblOne.text    = @"伸完懒腰，快去发布吧";
    _lblTwo.hidden = YES;
    if ([_showNowType isEqualToString:@"我的活动"]) {
        _btnAddFriend.hidden = NO;
        _btnAddFriend.layer.masksToBounds = YES;
        _btnAddFriend.layer.cornerRadius = 16;
        _btnAddFriend.layer.borderColor = [[UIColor blackColor] CGColor];
        _btnAddFriend.layer.borderWidth = 0.5f;
    }else if ([_showNowType isEqualToString:@"活动广场"]){
        _btnAddFriend.hidden = YES;
    }

    return self;
}
//cat_rest
-(id)initScheduleNilView
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    self.noticeImageView.image = [UIImage imageNamed:@"cat_rest"];

    _lblOne.text    = @"今天休息哦～";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden    = YES;
    
    return self;
}
-(id)initSendScheduleNilView
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    self.noticeImageView.image = [UIImage imageNamed:@"cat_date"];
    _lblOne.hidden = NO;
    _lblOne.text    = @"今天还没有安排哦～";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden = YES;
    UIButton *yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yueBtn.tag = 1002;
    yueBtn.backgroundColor = yellowOrangeColor;
    yueBtn.layer.masksToBounds = YES;
    yueBtn.layer.cornerRadius = 3;
    yueBtn.frame = CGRectMake(16, 247, kDeviceWidth - 32, 44);
    [yueBtn setTitle:@"我要预约" forState:UIControlStateNormal];
    [yueBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    [self addSubview:yueBtn];
    [yueBtn addTarget:self action:@selector(yueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnAddFriend setTitle:@"我要预约" forState:UIControlStateNormal];
    
    return self;
}
- (id)initShowNowistNilviewByType {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
//    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
//    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
//    [self addSubview:_imageview];
    
    _lblOne.text    = @"快来找到中意的TA～";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initShowNowistNilviewByPersonalCenter {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.text    = @"木有留下印记...";
    _lblTwo.text = @"好友来了会踩空哦！";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initShowNowistNilviewByPersonalCenterOtherSee {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.text    = @"我很忙，没有来得及秀...";
    _lblTwo.text = @"下次再来让你看个够！";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
-(id)initMyReservationModelNilView
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64);
    self.backgroundColor   = viewBgColor;
    self.noticeImageView.image = [UIImage imageNamed:@"cat_sad"];
    _lblOne.hidden = NO;
    _lblOne.text    = @"没人约..好忧桑...";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden = YES;
    
    //    [_btnAddFriend setTitle:@"我要预约" forState:UIControlStateNormal];
    
    return self;
}
-(id)initMyReservationNormalNilView
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64);
    self.backgroundColor   = viewBgColor;
    self.noticeImageView.image = [UIImage imageNamed:@"cat_date"];
    _lblOne.hidden = NO;
    _lblOne.text    = @"今天你约了吗？";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden = NO;
    _btnAddFriend.layer.masksToBounds = YES;
    _btnAddFriend.layer.cornerRadius = 16;
    [_btnAddFriend setTitle:@"约起来" forState:UIControlStateNormal];
    _btnAddFriend.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnAddFriend.layer.borderWidth = 0.5f;
    //    [_btnAddFriend setTitle:@"我要预约" forState:UIControlStateNormal];
    
    return self;
}
- (id)initModelCardFlowNilviewByPersonalCenter {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.text    = @"脸都不露，没法混饭吃了哦！";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initModelCardFlowNilviewByPersonalCenterOtherSee {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.text    = @"玩起了捉迷藏...";
    _lblTwo.text    = @"下来再来给你看真面目！";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initBaseNilview{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-0);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.hidden = YES;
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initBaseNilviewWithHeight:(CGFloat )height{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, height);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    
    _lblOne.hidden = YES;
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden    = YES;
    
    return self;
}
- (id)initMainNilviewDelegate:(id<notinilViewDelegate>)delegate  {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.delegate   = delegate;
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-44);
    self.backgroundColor   = viewBgColor;
    
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
//    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
//    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
//    [self addSubview:_imageview];

    _lblOne.text    = @"";
    _lblTwo.text    = @"";
    _btnAddFriend.hidden    = NO;

    return self;
}

- (id)initLoadFailView{
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    self.backgroundColor   = viewBgColor;
    
    //    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"sad.gif" ofType:nil];
    //    NSData  *imgaData = [NSData dataWithContentsOfFile:filePath];
    //    _imageview.image = [UIImage sd_animatedGIFWithData:imgaData];
    //    [self addSubview:_imageview];
    self.noticeImageView.image = [UIImage imageNamed:@"cat_rest"];
    _lblOne.hidden = NO;
    _lblOne.text = @"数据加载失败...";
    _lblTwo.hidden = YES;
    _btnAddFriend.hidden = NO;
    _btnAddFriend.layer.masksToBounds = YES;
    _btnAddFriend.layer.cornerRadius = 16;
    [_btnAddFriend setTitle:@"重新加载" forState:UIControlStateNormal];
    _btnAddFriend.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnAddFriend.layer.borderWidth = 0.5f;
    
    return self;
}
//搜索结果页
- (id)initSearchNilview {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64);
    self.backgroundColor   = viewBgColor;
    
    _imageview.image = [UIImage imageNamed:@"camera_3_l"];
    [self addSubview:_imageview];

    _lblOne.text    = @"";
    _lblTwo.text    = @"";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
//搜索用户页
- (id)initSearchFriendNilview {
    self = [[[NSBundle mainBundle] loadNibNamed:@"notiNilView" owner:self options:nil] objectAtIndex:0];
    self.frame  = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64);
    self.backgroundColor   = viewBgColor;

    _imageview.image = [UIImage imageNamed:@"camera_3_l"];
    [self addSubview:_imageview];
    
    _lblOne.text    = @"";
    _lblTwo.text    = @"";
    _btnAddFriend.hidden    = YES;
    
    return self;
}
-(void)yueBtnClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(yueBtnClicked)]) {
        [self.delegate yueBtnClicked];
    }
}
- (IBAction)btnAddFriend:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addNewFriend)]) {
        [self.delegate addNewFriend];
    }
}

@end
