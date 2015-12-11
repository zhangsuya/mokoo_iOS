//
//  fansTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansListModel.h"
@interface fansTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *rejectBtn;
@property (nonatomic,strong)fansTableViewCell *cell;
-(id)initFansListWithModel:(FansListModel *)model;
-(id)initShowCell;
@end
