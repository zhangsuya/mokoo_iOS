//
//  ModelTypeModel.m
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelTypeModel.h"
#import "MJExtension.h"
@implementation ModelTypeModel
+(instancetype)initModelTypeWithDict:(NSDictionary *)dict
{
    ModelTypeModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
