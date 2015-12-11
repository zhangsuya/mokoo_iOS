//
//  ZWCollectionViewCell.h
//  
//
//  Created by sy on 15/6/6.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface ZWCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)HomeModel * shop;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
