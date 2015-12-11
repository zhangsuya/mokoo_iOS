//
//  PlanListModel.m
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "PlanListModel.h"
#import "MJExtension.h"
@implementation PlanListModel
+(instancetype)initPlanListWithDict:(NSDictionary *)dict
{
    PlanListModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
