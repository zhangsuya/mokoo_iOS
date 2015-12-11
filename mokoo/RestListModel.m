//
//  RestListModel.m
//  mokoo
//
//  Created by Mac on 15/11/5.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "RestListModel.h"
#import "MJExtension.h"
@implementation RestListModel
+(instancetype)initRestListWithDict:(NSDictionary *)dict
{
    RestListModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
