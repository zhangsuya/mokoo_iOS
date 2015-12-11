//
//  ShowLikeCellModel.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowLikeCellModel.h"
#import "MJExtension.h"
@implementation ShowLikeCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    ShowLikeCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
