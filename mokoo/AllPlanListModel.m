//
//  AllPlanListModel.m
//  mokoo
//
//  Created by Mac on 15/11/5.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "AllPlanListModel.h"
#import "MJExtension.h"
@implementation AllPlanListModel
+(instancetype)initAllPlanListWithDict:(NSDictionary *)dict
{
    AllPlanListModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
