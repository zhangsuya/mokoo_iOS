//
//  AvtivityCellModel.m
//  mokoo
//
//  Created by Mac on 15/9/10.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "AvtivityCellModel.h"
#import <MJExtension.h>
@implementation AvtivityCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    AvtivityCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
