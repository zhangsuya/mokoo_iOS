//
//  EditPlanViewController.h
//  mokoo
//
//  Created by Mac on 15/11/6.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanListModel.h"
@protocol EditPlanViewControllerDelegate<NSObject>
-(void)editPlanRefrensh;
@end
@interface EditPlanViewController : UIViewController
//** 导航titileView */
@property (nonatomic,setter=setEdit:) BOOL isEdit;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong)PlanListModel *planModel;
@property (nonatomic,assign) id<EditPlanViewControllerDelegate>delegate;
@end
