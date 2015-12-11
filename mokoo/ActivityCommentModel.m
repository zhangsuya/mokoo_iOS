//
//  ActivityCommentModel.m
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityCommentModel.h"
#import <MJExtension.h>
@implementation ActivityCommentModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    ActivityCommentModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
