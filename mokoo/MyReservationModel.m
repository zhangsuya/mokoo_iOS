//
//  MyReservationModel.m
//  mokoo
//
//  Created by Mac on 15/10/12.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "MyReservationModel.h"
#import <MJExtension.h>

@implementation MyReservationModel
+ (instancetype)listModelWithDict:(NSDictionary *)dict
{
    MyReservationModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
