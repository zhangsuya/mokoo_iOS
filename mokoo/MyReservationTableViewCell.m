//
//  MyReservationTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/10/16.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "MyReservationTableViewCell.h"
#import "MokooMacro.h"
#import "MyReservationModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+MLExtension.h"
@implementation MyReservationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initShowCell
{
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"MyReservationTableViewCell" owner:self options:nil] lastObject];
    
    //    cell.titleLabel = [[UILabel alloc]init];
    //    cell.dateLabel = [[UILabel alloc]init];
    //    cell.contentLabel = [[UILabel alloc]init];
    
    self.cell.backgroundColor = viewBgColor;
    return self.cell;
}
-(id)initMyReservationWithModel:(MyReservationModel *)model
{
    MyReservationTableViewCell *cell = [[MyReservationTableViewCell alloc] initShowCell];
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
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"2"]) {//模特用户
        if ([model.type isEqualToString:@"2"]) {//被预约
            if ([model.status isEqualToString:@"3"]) {//拒绝
                cell.rejectBtn.hidden = YES;
                //拒绝也能私聊
//                cell.chatBtn.hidden = YES;
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                cell.statusLabel.ml_width = kDeviceWidth - cell.statusLabel.ml_x;
                cell.statusLabel.text = [NSString stringWithFormat:@"你已拒绝TA%@的预约",model.date];
                //        cell.rejectBtn.hidden = YES;
                
            }else if([model.status isEqualToString:@"1"]){//正常
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
                cell.statusLabel.text = [NSString stringWithFormat:@"%@的预约",model.date];
            }else if([model.status isEqualToString:@"2"])
            {//接受
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                cell.statusLabel.text = [NSString stringWithFormat:@"%@的预约",model.date];
                cell.rejectBtn.hidden = YES;
                //        cell.chatBtn.hidden = YES;
            }

        }else if ([model.type isEqualToString:@"1"]) {//预约
            cell.rejectBtn.hidden = YES;
            if ([model.status isEqualToString:@"3"]) {//拒绝
                //拒绝也能私聊
//                cell.chatBtn.hidden = YES;
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                cell.statusLabel.ml_width = kDeviceWidth - cell.statusLabel.ml_x;
                cell.statusLabel.text = [NSString stringWithFormat:@"TA已拒绝您的%@的预约",model.date];
                //        cell.rejectBtn.hidden = YES;
                
            }else if([model.status isEqualToString:@"1"]){//正常
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
                cell.statusLabel.text = [NSString stringWithFormat:@"%@的预约",model.date];
            }else if([model.status isEqualToString:@"2"])
            {//接受
                cell.chatBtn.layer.masksToBounds = YES;
                cell.chatBtn.layer.cornerRadius = 3;
                cell.chatBtn.backgroundColor = [UIColor blackColor];
                cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
                cell.statusLabel.text = [NSString stringWithFormat:@"TA已接受您的%@的预约",model.date];
                cell.rejectBtn.hidden = YES;
                //        cell.chatBtn.hidden = YES;
            }

        }
    }else
    {//非模特用户
        cell.rejectBtn.hidden = YES;
        if ([model.status isEqualToString:@"3"]) {
            //拒绝也能私聊
//            cell.chatBtn.hidden = YES;
            cell.chatBtn.layer.masksToBounds = YES;
            cell.chatBtn.layer.cornerRadius = 3;
            cell.chatBtn.backgroundColor = [UIColor blackColor];
            cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
            cell.statusLabel.ml_width = kDeviceWidth - cell.statusLabel.ml_x;
            cell.statusLabel.text = [NSString stringWithFormat:@"TA已拒绝您的%@的预约",model.date];
            //        cell.rejectBtn.hidden = YES;
            
        }else if([model.status isEqualToString:@"1"]){
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
            cell.statusLabel.text = [NSString stringWithFormat:@"%@的预约",model.date];
        }else if([model.status isEqualToString:@"2"])
        {
            cell.chatBtn.layer.masksToBounds = YES;
            cell.chatBtn.layer.cornerRadius = 3;
            cell.chatBtn.backgroundColor = [UIColor blackColor];
            cell.chatBtn.ml_x =kDeviceWidth -13-cell.chatBtn.ml_width;
            cell.statusLabel.text = [NSString stringWithFormat:@"TA已接受您的%@的预约",model.date];
            cell.rejectBtn.hidden = YES;
            //        cell.chatBtn.hidden = YES;
        }

    }
    if (model.time)
    {
        [cell.timeLabel setTextAlignment:NSTextAlignmentRight];
        cell.timeLabel.ml_x =kDeviceWidth -13-cell.timeLabel.ml_width;

        cell.timeLabel.text = model.time;
    }
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 65.5f, kDeviceWidth, 0.5f);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.layer addSublayer:lineLayer];
    
    return cell;
}
@end
