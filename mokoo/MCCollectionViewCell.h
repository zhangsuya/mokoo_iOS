//
//  MCCollectionViewCell.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelCardModel.h"
@interface MCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property(nonatomic,retain)ModelCardModel * shop;

@end
