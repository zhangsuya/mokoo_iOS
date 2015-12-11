//
//  ShowCommentCellModel.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowCommentCellModel.h"
#import "MJExtension.h"

@implementation ShowCommentCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    ShowCommentCellModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
