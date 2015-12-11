//
//  CommentTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "MokooMacro.h"
#import "UIImageView+WebCache.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableViewCell *)initShowCell
{
    CommentTableViewCell *cell = [[CommentTableViewCell alloc]init];
    cell.avatarImageView = [[UIImageView alloc]init];
    cell.vImageView = [[UIImageView alloc]init];
    cell.titleLabel = [[UILabel alloc]init];
    cell.dateLabel = [[UILabel alloc]init];
    cell.contentLabel = [[UILabel alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = viewBgColor;
    return cell;
}
- (id)initShowCellWithModel:(ShowCommentCellModel *)model
{
    CommentTableViewCell *cell = [[CommentTableViewCell alloc]initShowCell];
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        
        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@""]];
//        [cell.avatarImageView setImage:[UIImage imageNamed:@"show_head.pdf"]];
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(67, 15, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(67, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.content !=nil) {
        CGSize textSize = [model.content boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        //        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.text = model.content;
        _height = _height + textSize.height;
        [cell.contentView addSubview:cell.contentLabel];
    }
   
    _height = _height + 13 ;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [grayFontColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, _height);
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

@end
