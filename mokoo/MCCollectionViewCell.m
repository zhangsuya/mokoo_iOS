//
//  MCCollectionViewCell.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "MCCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MCCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setShop:(ModelCardModel *)shop
{
    _shop = shop;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:_shop.img_url]];
    
    
}
@end
