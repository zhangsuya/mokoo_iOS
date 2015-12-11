//
//  ZWTwoCollectionViewLayout.h
//  mokoo
//
//  Created by Mac on 15/10/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSStickyHeaderFlowLayout.h"

@class ZWTwoCollectionViewLayout;
@protocol ZWTwowaterFlowDelegate <NSObject>

-(CGFloat)ZWwaterFlow:(ZWTwoCollectionViewLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;

@end
@interface ZWTwoCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,assign)UIEdgeInsets cellInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property (nonatomic) CGSize headerReferenceSize;
//@property (nonatomic, assign) CGFloat naviHeight;//默认为64.0, default is 64.0

@property(nonatomic,weak)id<ZWTwowaterFlowDelegate>degelate;
@end
