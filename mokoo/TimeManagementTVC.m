//
//  TimeManagementTVC.m
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "TimeManagementTVC.h"
#import "MokooMacro.h"
#import "UIView+MLExtension.h"
@implementation TimeManagementTVC

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLeftLabel:(UILabel *)leftLabel
{
    [leftLabel setFont:[UIFont systemFontOfSize:12]];
    [leftLabel setTextColor:blackFontColor];
    _leftLabel = leftLabel;
}
-(void)setRightLabel:(UILabel *)rightLabel
{
    [rightLabel setFont:[UIFont systemFontOfSize:15]];
    [rightLabel setTextColor:blackFontColor];
    _rightLabel = rightLabel;
}
-(void)setColorImageView:(UIImageView *)colorImageView
{
    _colorImageView = colorImageView;
}
-(void)setRestLabel:(UILabel *)restLabel
{
    [restLabel setFont:[UIFont systemFontOfSize:15]];
    [restLabel setTextColor:blackFontColor];
    _restLabel = restLabel;

}
-(void)setRestSwitch:(UISwitch *)restSwitch
{
//    [restSwitch setTintColor:yellowOrangeColor];
    [restSwitch setOnTintColor:yellowOrangeColor];
//    [restSwitch setBackgroundColor:yellowOrangeColor];
    _restSwitch = restSwitch;
    
}
//- (UITableViewCell *)initShowCell
//{
//    TimeManagementTVC *cell =[[TimeManagementTVC alloc] init];
//    NSString *startEndTime = [NSString stringWithFormat:@"%@-%@",model.start,model.end];
//    CGSize size = [startEndTime boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    cell.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, size.width, size.height)];
//    cell.colorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16+size.width +70, cell.ml_height/2 -2.5/2, 2.5, 2.5)];
//    cell.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(16+size.width +70 +2.5 +16, 13, kDeviceWidth-(16+size.width +70 +2.5 +16), 18)];
//    [cell.contentView addSubview:cell.leftLabel];
//    [cell.contentView addSubview:cell.colorImageView];
//    [cell.contentView addSubview:cell.rightLabel];
//    return cell;
//
//}
-(TimeManagementTVC *)initTimeCellWithPlanListModel:(PlanListModel *)model
{
    TimeManagementTVC *cell =[[TimeManagementTVC alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *startEndTime = [NSString stringWithFormat:@"%@-%@",[model.start substringFromIndex:10],model.end];
    CGSize size = [startEndTime boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    cell.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, (44-size.height)/2, size.width, size.height)];
    cell.leftLabel.text = startEndTime;
    cell.colorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16+size.width +30, cell.ml_height/2 -7/2, 7, 7)];
    if ([model.status isEqualToString:@"1"]) {
        cell.colorImageView.image = [UIImage imageNamed:@"calendar_circle_r.pdf"];
    }else if ([model.status isEqualToString:@"2"])
    {
        cell.colorImageView.image = [UIImage imageNamed:@"calendar_circle_g.pdf"];
    }
    cell.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(16+size.width +30 +7 +16, (44-18)/2, kDeviceWidth-(16+size.width +70 +7 +16), 18)];
    cell.rightLabel.text = model.content;
    [cell.contentView addSubview:cell.leftLabel];
    [cell.contentView addSubview:cell.colorImageView];
    [cell.contentView addSubview:cell.rightLabel];
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 43.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    return cell;
}
-(TimeManagementTVC *)initTimeCellWithAllPlanListModel:(AllPlanListModel *)model
{
    TimeManagementTVC *cell =[[TimeManagementTVC alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CALayer *firstLineLayer = [[CALayer alloc]init];
    firstLineLayer.frame = CGRectMake(0, 0, kDeviceWidth, 0.5);
    firstLineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:firstLineLayer];

    CGSize size = [@"休息中" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    cell.restLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, (44-size.height)/2, size.width, size.height)];
    cell.restLabel.text = @"休息中";
    cell.restLabel.ml_centerY = 22;
    cell.restSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cell.restSwitch.ml_x = kDeviceWidth -16-cell.restSwitch.ml_width;
    cell.restSwitch.ml_centerY = 22;
    if ([model.sleep isEqualToString:@"0"]) {
        [cell.restLabel setTextColor:blackFontColor];
        [cell.restSwitch setOn:NO];

    }else if([model.sleep isEqualToString:@"1"])
    {
        [cell.restLabel setTextColor:redFontColor];
        [cell.restSwitch setOn:YES];
    }
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, 43.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];

    [cell.contentView addSubview:cell.restLabel];
    [cell.contentView addSubview:cell.restSwitch];
    return cell;

}
@end
