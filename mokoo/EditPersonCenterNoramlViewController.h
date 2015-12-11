//
//  EditPersonCenterNoramlViewController.h
//  mokoo
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterHeadModel.h"
@protocol EditPersonCenterNoramlViewControllerDelegate<NSObject>
-(void)refrenshPerssonalInfoView;
@end
@interface EditPersonCenterNoramlViewController : UIViewController
+ (UILabel *)initLabelWithTitle:(NSString *)title;
@property (nonatomic,strong) PersonalCenterHeadModel *model;
//@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,assign) id<EditPersonCenterNoramlViewControllerDelegate>delegate;
@end
