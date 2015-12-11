//
//  ActivityCaseTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityCaseTableViewCell.h"
#import "MokooMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+MLExtension.h"

@implementation ActivityCaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initShowCell
{
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityCaseTableViewCell" owner:self options:nil] lastObject];

    //    cell.titleLabel = [[UILabel alloc]init];
    //    cell.dateLabel = [[UILabel alloc]init];
    //    cell.contentLabel = [[UILabel alloc]init];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell.backgroundColor = viewBgColor;
    return self.cell;
}
-(id)initActivityCaseWithModel:(ActivityListModel *)model withUserId:(NSString *)user_id
{
    ActivityCaseTableViewCell *cell = [[ActivityCaseTableViewCell alloc] initShowCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = viewBgColor;
    cell.contentView.backgroundColor = viewBgColor;
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
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]||![user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]){
        cell.rejectBtn.hidden = YES;
        cell.chatBtn.hidden = YES;
        cell.statusLabel.hidden = YES;
    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:user_id])
    {
        if ([model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]])
        {
            cell.rejectBtn.hidden = YES;
            cell.chatBtn.hidden = YES;
            cell.statusLabel.hidden = YES;
        }else
        {
            cell.statusLabel.ml_x = kDeviceWidth  - cell.statusLabel.ml_width - 5;

            if ([model.status isEqualToString:@"3"]) {
                cell.rejectBtn.hidden = YES;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                [cell.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.statusLabel.text = @"已拒绝";
                cell.chatBtn.hidden = YES;
            }else if([model.status isEqualToString:@"1"]){
                cell.statusLabel.hidden = YES;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.rejectBtn.layer.borderColor = [UIColor blackColor].CGColor;
                cell.rejectBtn.layer.borderWidth = 0.5f;
                [cell.rejectBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                cell.rejectBtn.backgroundColor = [UIColor whiteColor];
                cell.rejectBtn.ml_x = cell.chatBtn.ml_x -8 -cell.rejectBtn.ml_width;
                [cell.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.rejectBtn.layer.masksToBounds = YES;
                cell.rejectBtn.layer.cornerRadius = 3;
                cell.statusLabel.text = @"待接受";
                
            }else if([model.status isEqualToString:@"2"])
            {
                cell.rejectBtn.hidden = YES;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                [cell.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                //        cell.chatBtn.hidden = YES;
                cell.statusLabel.text = @"已接受";
            }

        }

        
    }
    
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 65.5f, kDeviceWidth, 0.5f);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.layer addSublayer:lineLayer];
    
    return cell;
}
-(id)initMyReservationWithModel:(MyReservationModel *)model
{
    ActivityCaseTableViewCell *cell = [[ActivityCaseTableViewCell alloc] initShowCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = viewBgColor;
    cell.contentView.backgroundColor = viewBgColor;
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
    if ([model.status isEqualToString:@"0"]) {
        cell.rejectBtn.hidden = YES;
        cell.chatBtn.hidden = YES;
    }else if([model.status isEqualToString:@"1"]){
        cell.statusLabel.hidden = YES;
        cell.chatBtn.backgroundColor = [UIColor blackColor];
        cell.rejectBtn.layer.borderColor = [UIColor blackColor].CGColor;
        cell.rejectBtn.layer.borderWidth = 0.5f;
        [cell.rejectBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
        cell.rejectBtn.backgroundColor = [UIColor whiteColor];
        cell.rejectBtn.ml_x = cell.chatBtn.ml_x -8 -cell.rejectBtn.ml_width;
        [cell.chatBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        cell.chatBtn.layer.masksToBounds = YES;
        cell.chatBtn.layer.cornerRadius = 3;
        cell.rejectBtn.layer.masksToBounds = YES;
        cell.rejectBtn.layer.cornerRadius = 3;
    }else if([model.status isEqualToString:@"2"])
    {
        cell.rejectBtn.hidden = YES;
        cell.chatBtn.hidden = YES;
        cell.statusLabel.text = @"已接受";
    }
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 65.5f, kDeviceWidth, 0.5f);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.layer addSublayer:lineLayer];
    
    return cell;
}

@end
