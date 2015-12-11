//
//  ActivityCaseTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"
#import "MyReservationModel.h"
@interface ActivityCaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) ActivityCaseTableViewCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;

@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
-(id)initShowCell;
-(id)initActivityCaseWithModel:(ActivityListModel *)model withUserId:(NSString *)user_id;
-(id)initMyReservationWithModel:(MyReservationModel *)model;
@end
