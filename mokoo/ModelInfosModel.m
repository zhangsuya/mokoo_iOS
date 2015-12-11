//
//  ModelInfosModel.m
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelInfosModel.h"
#import "MJExtension.h"

@implementation ModelInfosModel
+(instancetype)initModelInfosWithDict:(NSDictionary *)dict
{
    ModelInfosModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
