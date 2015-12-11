//
//  MyReservationTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/10/16.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyReservationModel.h"
@interface MyReservationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;
@property (nonatomic,strong)MyReservationTableViewCell *cell;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(id)initMyReservationWithModel:(MyReservationModel *)model;
@end
