//
//  ActivityTwoTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCFireworksButton.h"
#import "AvtivityCellModel.h"
@interface ActivityTwoTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UIImageView *vImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) MCFireworksButton *likeBtn;
@property (nonatomic,strong) UILabel *likeCountLabel;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UILabel *commentCountLabel;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UIImageView *moneyView;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIImageView *timeView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *locationView;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UIImageView *personNumView;
@property (nonatomic,strong) UILabel *personNumLabel;
@property (nonatomic,strong) UIButton *activityBtn;//报名按钮
@property (nonatomic,strong) UILabel *activityLabel;
@property (nonatomic,strong) UIImageView *themeImageView;
@property (nonatomic,strong) UILabel *themeLabel;
@property (nonatomic,strong) UIView *grayContentView;
@property (nonatomic,assign) CGFloat height;//cell高度
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) UIImageView *chiImageView;
-(UITableViewCell *)initActivityCell;
@end
