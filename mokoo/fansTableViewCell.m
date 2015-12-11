//
//  fansTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "fansTableViewCell.h"
#import "MokooMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+MLExtension.h"
@implementation fansTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initShowCell
{
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"fansTableViewCell" owner:self options:nil] lastObject];
    
    //    cell.titleLabel = [[UILabel alloc]init];
    //    cell.dateLabel = [[UILabel alloc]init];
    //    cell.contentLabel = [[UILabel alloc]init];
    
    self.cell.backgroundColor = viewBgColor;
    return self.cell;
}
-(id)initFansListWithModel:(FansListModel *)model
{
    fansTableViewCell *cell = [[fansTableViewCell alloc] initShowCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = viewBgColor;
    cell.contentView.backgroundColor = viewBgColor;
    if (model.user_img !=nil) {
        
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img ]placeholderImage:[UIImage imageNamed:@"head.pdf"]];
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
    if (model.sign !=nil) {
        cell.statusLabel.text = model.sign;
        cell.statusLabel.ml_width = kDeviceWidth - 78.5f -cell.statusLabel.ml_x;
    }
    cell.rejectBtn.ml_x = kDeviceWidth - 78.5;
    if ([model.is_follow isEqualToString:@"1"]) {
        [cell.rejectBtn setImage:[UIImage imageNamed:@"focus_off_a"] forState:UIControlStateNormal];
    }else if ([model.is_follow isEqualToString:@"0"])
    {
        [cell.rejectBtn setImage:[UIImage imageNamed:@"focus_on_a"] forState:UIControlStateNormal];
    }
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 65.5f, kDeviceWidth, 0.5f);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.layer addSublayer:lineLayer];
    
    return cell;
}

@end
