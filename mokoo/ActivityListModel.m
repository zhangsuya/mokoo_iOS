//
//  ActivityListModel.m
//  mokoo
//
//  Created by Mac on 15/9/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityListModel.h"
#import <MJExtension.h>

@implementation ActivityListModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    ActivityListModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
