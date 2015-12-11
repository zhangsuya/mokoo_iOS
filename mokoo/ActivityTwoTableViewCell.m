//
//  ActivityTwoTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ActivityTwoTableViewCell.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
@implementation ActivityTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableViewCell *)initActivityCell
{
    ActivityTwoTableViewCell *cell = [[ActivityTwoTableViewCell alloc]init];
    cell.avatarImageView = [[UIImageView alloc]init];
    cell.vImageView = [[UIImageView alloc]init];
    cell.titleLabel = [[UILabel alloc]init];
    cell.dateLabel = [[UILabel alloc]init];
    cell.contentLabel = [[UILabel alloc]init];
    cell.themeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_theme.pdf"] ];
    cell.themeLabel = [[UILabel alloc]init];
    cell.deleteBtn = [[UIButton alloc]init];
    cell.likeBtn = [[MCFireworksButton alloc]init];
    cell.likeCountLabel = [[UILabel alloc]init];
    cell.commentBtn = [[UIButton alloc]init];
    cell.commentCountLabel = [[UILabel alloc]init];
    cell.activityBtn = [[UIButton alloc]init];
    cell.activityLabel = [[UILabel alloc]init];
    cell.whiteView = [[UIView alloc]init];
    cell.moneyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_price_b.pdf"]];
    cell.moneyLabel = [[UILabel alloc]init];
    cell.timeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_time_b.pdf"]];
    cell.timeLabel = [[UILabel alloc]init];
    cell.locationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_location_b.pdf"]];
    cell.locationLabel = [[UILabel alloc]init];
    cell.personNumView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_people_b.pdf"]];
    cell.personNumLabel = [[UILabel alloc]init];
    cell.grayContentView = [[UIView alloc] init];
    cell.imageViewArray = [NSMutableArray array];
    cell.chiImageView = [[UIImageView alloc] init];
    cell.backgroundColor = viewBgColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.likeBtn setEnlargeEdgeWithTop:10 right:20 bottom:5 left:10];
    [cell.commentBtn setEnlargeEdgeWithTop:10 right:20 bottom:5 left:5];
    [cell.activityBtn setEnlargeEdgeWithTop:10 right:20 bottom:5 left:5];
    [cell.deleteBtn setEnlargeEdgeWithTop:5 right:20 bottom:5 left:20];
    
    return cell;
}
-(void)setAvatarImageView:(UIImageView *)avatarImageView
{
    
    _avatarImageView = avatarImageView;
}
-(void)setTitleLabel:(UILabel *)titleLabel
{
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    [titleLabel setTextColor:activityTitileColor];
    _titleLabel = titleLabel;
}
-(void)setThemeLabel:(UILabel *)themeLabel
{
    [themeLabel setFont:[UIFont systemFontOfSize:15]];
    [themeLabel setTextColor:activityFontColor];
    _themeLabel = themeLabel;
}
-(void)setDateLabel:(UILabel *)dateLabel
{
    [dateLabel setTextColor:activityTitileColor];
    [dateLabel setFont: [UIFont systemFontOfSize:10]];
    _dateLabel = dateLabel;
}
-(void)setContentLabel:(UILabel *)contentLabel
{
    [contentLabel setFont:[UIFont systemFontOfSize:14]];
    [contentLabel setTextColor:activityFontColor];
    _contentLabel = contentLabel;
}
-(void)setDeleteBtn:(UIButton *)deleteBtn
{
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [deleteBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn = deleteBtn;
}
-(void)setLikeBtn:(MCFireworksButton *)likeBtn
{
    [likeBtn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
    likeBtn.particleScale = 0.05;
    likeBtn.particleScaleRange = 0.02;
    _likeBtn = likeBtn;
}
- (void)setCommentBtn:(UIButton *)commentBtn
{
    [commentBtn setImage:[UIImage imageNamed:@"icon_review.pdf"] forState:UIControlStateNormal];
    _commentBtn = commentBtn;
}
-(void)setActivityBtn:(UIButton *)activityBtn
{
    [activityBtn setImage:[UIImage imageNamed:@"icon_apply.pdf"] forState:UIControlStateNormal];
    _activityBtn = activityBtn;
}
-(void)setLikeCountLabel:(UILabel *)likeCountLabel
{
    [likeCountLabel setFont:[UIFont systemFontOfSize:12]];
    [likeCountLabel setTextColor:blackFontColor];
    _likeCountLabel = likeCountLabel;
    
}
-(void)setCommentCountLabel:(UILabel *)commentCountLabel
{
    [commentCountLabel setFont:[UIFont systemFontOfSize:12]];
    [commentCountLabel setTextColor:blackFontColor];
    _commentCountLabel = commentCountLabel;
}
-(void)setActivityLabel:(UILabel *)activityLabel
{
    [activityLabel setFont:[UIFont systemFontOfSize:12]];
    [activityLabel setTextColor:blackFontColor];
    _activityLabel = activityLabel;
}
-(void)setMoneyLabel:(UILabel *)moneyLabel
{
    [moneyLabel setFont:[UIFont systemFontOfSize:12]];
    [moneyLabel setTextColor: activityFontColor];
    _moneyLabel = moneyLabel;
}
-(void)setTimeLabel:(UILabel *)timeLabel
{
    [timeLabel setFont:[UIFont systemFontOfSize:12]];
    [timeLabel setTextColor:activityFontColor];
    _timeLabel = timeLabel;
}
-(void)setLocationLabel:(UILabel *)locationLabel
{
    [locationLabel setFont:[UIFont systemFontOfSize:12]];
    [locationLabel setTextColor:activityFontColor];
    _locationLabel = locationLabel;
}
-(void)setPersonNumLabel:(UILabel *)personNumLabel
{
    [personNumLabel setFont:[UIFont systemFontOfSize:12]];
    [personNumLabel setTextColor:activityFontColor];
    _personNumLabel = personNumLabel;
}
-(void)setGrayContentView:(UIView *)grayContentView
{
    grayContentView.backgroundColor = activityBackgroundColor;
    _grayContentView =grayContentView;
}
@end
