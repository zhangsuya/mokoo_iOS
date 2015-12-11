//
//  HomeCellModel.m
//  mokoo
//
//  Created by Mac on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "HomeCellModel.h"
#import <MJExtension.h>
@implementation HomeCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    HomeCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
