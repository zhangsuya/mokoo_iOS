//
//  FansListModel.m
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "FansListModel.h"
#import <MJExtension.h>

@implementation FansListModel
+ (instancetype)listModelWithDict:(NSDictionary *)dict
{
    FansListModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
