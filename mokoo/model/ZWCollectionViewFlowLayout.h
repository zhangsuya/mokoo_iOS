//
//  ZWCollectionViewFlowLayout.h
// 
//
//  Created by sy on 15/6/6.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSStickyHeaderFlowLayout.h"
@class ZWCollectionViewFlowLayout;
@protocol ZWwaterFlowDelegate <NSObject>

-(CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;

@end

@interface ZWCollectionViewFlowLayout : CSStickyHeaderFlowLayout
@property(nonatomic,assign)UIEdgeInsets cellInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property (nonatomic) CGSize headerReferenceSize;
//@property (nonatomic, assign) CGFloat naviHeight;//默认为64.0, default is 64.0

@property(nonatomic,weak)id<ZWwaterFlowDelegate>degelate;
@end
