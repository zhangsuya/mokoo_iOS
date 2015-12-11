//
//  ModelCardCollectionViewLayout.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelCardCollectionViewLayout;
@protocol MCwaterFlowDelegate <NSObject>

-(CGFloat)MCwaterFlow:(ModelCardCollectionViewLayout*)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPach;

@end
@interface ModelCardCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;
@property(nonatomic,weak)id<MCwaterFlowDelegate>degelate;
@end
