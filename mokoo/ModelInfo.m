//
//  ModelInfo.m
//  mokoo
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelInfo.h"
#import <MJExtension.h>

@implementation ModelInfo
+(instancetype)initModelInfoWithDict:(NSDictionary *)dict
{
    ModelInfo *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}

@end
