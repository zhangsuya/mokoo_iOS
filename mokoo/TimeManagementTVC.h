//
//  TimeManagementTVC.h
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanListModel.h"
//#import "RestListModel.h"
#import "AllPlanListModel.h"
@interface TimeManagementTVC : UITableViewCell
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UIImageView *colorImageView;
@property (nonatomic,strong)UILabel *restLabel;
@property (nonatomic,strong)UISwitch *restSwitch;
-(TimeManagementTVC *)initTimeCellWithPlanListModel:(PlanListModel *)model;
-(TimeManagementTVC *)initTimeCellWithAllPlanListModel:(AllPlanListModel *)model;
@end
