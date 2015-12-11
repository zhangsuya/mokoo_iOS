//
//  ModelCardModel.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelCardModel.h"
#import "MJExtension.h"
@implementation ModelCardModel
+(instancetype)initModelCardListWithDict:(NSDictionary *)dict
{
    ModelCardModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
