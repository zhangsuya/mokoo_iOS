//
//  ShowCell.h
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowCellModel.h"
#import "MCFireworksButton.h"
@interface ShowCell : UITableViewCell
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UIImageView *vImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *addressImageView;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) MCFireworksButton *likeBtn;
@property (nonatomic,strong) UILabel *likeCountLabel;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UILabel *commentCountLabel;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSMutableArray *imageViewArray;
-(UITableViewCell *)initShowCell;
- (id)initShowCellWithModel:(ShowCellModel *)model;
- (id)initShowCellWithModel:(ShowCellModel *)model yOrign:(CGFloat)yOrign;
@end
