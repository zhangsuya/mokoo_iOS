//
//  CommentTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowCommentCellModel.h"
@interface CommentTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UIImageView *vImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,assign) CGFloat height;
-(UITableViewCell *)initShowCell;
- (id)initShowCellWithModel:(ShowCommentCellModel *)model;
@end
