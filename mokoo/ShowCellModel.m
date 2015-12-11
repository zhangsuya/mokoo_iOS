//
//  ShowCellModel.m
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowCellModel.h"
#import "MJExtension.h"
@implementation ShowCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    ShowCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
