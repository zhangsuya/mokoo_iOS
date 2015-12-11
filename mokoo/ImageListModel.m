//
//  ImgaeListModel.m
//  mokoo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ImageListModel.h"
#import "MJExtension.h"

@implementation ImageListModel
+(instancetype)initListModelWithDict:(NSDictionary *)dict
{
    ImageListModel *model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}
@end
