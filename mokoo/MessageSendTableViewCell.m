//
//  MessageSendTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/11/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "MessageSendTableViewCell.h"
#import "MokooMacro.h"
#import "UIView+MLExtension.h"
@implementation MessageSendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableViewCell *)initShowCell
{
    MessageSendTableViewCell *cell = [[MessageSendTableViewCell alloc] init];
    cell.titleLabel = [[UILabel alloc] init];
    cell.detailLabel = [[UILabel alloc] init];
    cell.messageSwitch = [[UISwitch alloc] init];
    cell.rightTitleLabel = [[UILabel alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(id)initFirstTableViewCell
{
    MessageSendTableViewCell *cell = (MessageSendTableViewCell *)[[MessageSendTableViewCell alloc] initShowCell];
    cell.titleLabel.frame = CGRectMake(16, 0, kDeviceWidth/2 -16, 44);
    cell.rightTitleLabel.frame = CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2-16, 44);
    [cell.contentView addSubview:cell.titleLabel];
    [cell.contentView addSubview:cell.rightTitleLabel];
    return cell;
}
-(id)initSecondTableViewCell
{
    MessageSendTableViewCell *cell = (MessageSendTableViewCell *)[[MessageSendTableViewCell alloc] initShowCell];
    cell.titleLabel.frame = CGRectMake(16, 8, kDeviceWidth/2, 20);
    cell.detailLabel.frame = CGRectMake(16, 33, kDeviceWidth/2, 15);
    cell.messageSwitch.frame = CGRectMake(0, 0, 0, 0);
    cell.messageSwitch.ml_centerY = 59/2;
    cell.messageSwitch.ml_x = kDeviceWidth-cell.messageSwitch.ml_width -16;
    cell.frame = CGRectMake(0, 0, kDeviceWidth, 59);
    [cell.contentView addSubview:cell.titleLabel];
    [cell.contentView addSubview:cell.detailLabel];
    [cell.contentView addSubview:cell.messageSwitch];
    return cell;
}
-(void)setTitleLabel:(UILabel *)titleLabel
{
    [titleLabel setFont:[UIFont systemFontOfSize: 15]];
    [titleLabel setTextColor:blackFontColor];
    _titleLabel = titleLabel;
}
-(void)setDetailLabel:(UILabel *)detailLabel
{
    [detailLabel setFont:[UIFont systemFontOfSize:11]];
    [detailLabel setTextColor:placehoderFontColor];
    _detailLabel = detailLabel;
}
-(void)setMessageSwitch:(UISwitch *)messageSwitch
{
    [messageSwitch setOnTintColor:yellowOrangeColor];
    _messageSwitch = messageSwitch;
}
-(void)setRightTitleLabel:(UILabel *)rightTitleLabel
{
    [rightTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightTitleLabel setTextColor:placehoderFontColor];
    [rightTitleLabel setTextAlignment:NSTextAlignmentRight];
    _rightTitleLabel = rightTitleLabel;
}
@end
