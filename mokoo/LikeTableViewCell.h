//
//  LikeTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowLikeCellModel.h"
@interface LikeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) UITableViewCell *cell;
-(id)initShowCell;
- (id)initShowCellWithModel:(ShowLikeCellModel *)model;
@end
