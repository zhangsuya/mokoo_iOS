//
//  PersonalCenterHeadModel.m
//  mokoo
//
//  Created by Mac on 15/9/19.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "PersonalCenterHeadModel.h"
#import "MJExtension.h"

@implementation PersonalCenterHeadModel
+(instancetype)initHeadModelWithDict:(NSDictionary *)dict
{
    PersonalCenterHeadModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
MJCodingImplementation
@end
