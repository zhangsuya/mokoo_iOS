//
//  LikeTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LikeTableViewCell.h"
#import "MokooMacro.h"
#import "UIImageView+WebCache.h"
@implementation LikeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initShowCell
{
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"LikeTableViewCell" owner:self options:nil] lastObject];
//    cell.titleLabel = [[UILabel alloc]init];
//    cell.dateLabel = [[UILabel alloc]init];
//    cell.contentLabel = [[UILabel alloc]init];
    self.cell.backgroundColor = viewBgColor;
    return self.cell;
}
- (id)initShowCellWithModel:(ShowLikeCellModel *)model
{
    LikeTableViewCell *cell = [[LikeTableViewCell alloc]initShowCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (model.user_img !=nil) {
        
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img ]placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
//        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
//        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.text = model.nick_name;
//        [cell.contentView addSubview:cell.titleLabel];
    }
        CALayer *lineLayer = [[CALayer alloc]init];
        lineLayer.frame = CGRectMake(0, 65.5f, kDeviceWidth, 0.5f);
        lineLayer.backgroundColor = [lineSystemColor CGColor];
        [cell.layer addSublayer:lineLayer];
    return cell;
}
//-(void)setAvatarImageView:(UIImageView *)avatarImageView
//{
//    _avatarImageView = avatarImageView;
//}
//-(void)setTitleLabel:(UILabel *)titleLabel
//{
//    [titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [titleLabel setTextColor:blackFontColor];
//    _titleLabel = titleLabel;
//    
//    
//}

@end
