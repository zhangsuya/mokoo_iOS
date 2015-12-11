//
//  ZPActionSheetView.h
//  NothingIsImpossible
//
//  Created by hztuen on 15/8/19.
//  Copyright (c) 2015年 hztuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZPActionSheetViewDelegate;

@interface ZPActionSheetView : UIView
{
    UIView *view;
    UIButton *button;
}
@property(nonatomic,assign)id<ZPActionSheetViewDelegate> delegate;
 
@end

@protocol ZPActionSheetViewDelegate<NSObject>

-(void)zpActionSheet :(ZPActionSheetView *)view :(NSInteger)buttonIndex;

@end
