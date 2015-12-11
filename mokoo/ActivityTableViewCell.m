//
//  ActivityTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableViewCell *)initActivityCell
{
    ActivityTableViewCell *cell = [[ActivityTableViewCell alloc]init];
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
    cell.moneyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_price_r.pdf"]];
    cell.moneyLabel = [[UILabel alloc]init];
    cell.timeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_time.pdf"]];
    cell.timeLabel = [[UILabel alloc]init];
    cell.locationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_location.pdf"]];
    cell.locationLabel = [[UILabel alloc]init];
    cell.personNumView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice_people.pdf"]];
    cell.personNumLabel = [[UILabel alloc]init];
    cell.imageViewArray = [NSMutableArray array];
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
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setTextColor:blackFontColor];
    _titleLabel = titleLabel;
}
-(void)setThemeLabel:(UILabel *)themeLabel
{
    [themeLabel setFont:[UIFont systemFontOfSize:15]];
    [themeLabel setTextColor:blackFontColor];
    _themeLabel = themeLabel;
}
-(void)setDateLabel:(UILabel *)dateLabel
{
    [dateLabel setTextColor:grayFontColor];
    [dateLabel setFont: [UIFont systemFontOfSize:10]];
    _dateLabel = dateLabel;
}
-(void)setContentLabel:(UILabel *)contentLabel
{
    [contentLabel setFont:[UIFont systemFontOfSize:15]];
    [contentLabel setTextColor:blackFontColor];
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
    [moneyLabel setTextColor:redFontColor];
    _moneyLabel = moneyLabel;
}
-(void)setTimeLabel:(UILabel *)timeLabel
{
    [timeLabel setFont:[UIFont systemFontOfSize:12]];
    [timeLabel setTextColor:placehoderFontColor];
    _timeLabel = timeLabel;
}
-(void)setLocationLabel:(UILabel *)locationLabel
{
    [locationLabel setFont:[UIFont systemFontOfSize:12]];
    [locationLabel setTextColor:placehoderFontColor];
    _locationLabel = locationLabel;
}
-(void)setPersonNumLabel:(UILabel *)personNumLabel
{
    [personNumLabel setFont:[UIFont systemFontOfSize:12]];
    [personNumLabel setTextColor:placehoderFontColor];
    _personNumLabel = personNumLabel;
}
@end
