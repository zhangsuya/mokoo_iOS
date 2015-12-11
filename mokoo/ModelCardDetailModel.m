//
//  ModelCardDetailModel.m
//  mokoo
//
//  Created by Mac on 15/9/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelCardDetailModel.h"
#import "MJExtension.h"
@implementation ModelCardDetailModel
+(instancetype)initModelCardDetailWithDict:(NSDictionary *)dict
{
    ModelCardDetailModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
