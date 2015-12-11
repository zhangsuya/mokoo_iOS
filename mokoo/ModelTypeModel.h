//
//  ModelTypeModel.h
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelTypeModel : NSObject
//"jl_id":"经历ID",
//"type":"经历类型",
//"desc":"经历描述",
//"type_name":"经历类型名称",

@property (nonatomic,copy)NSString *jl_id;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *type_name;
@property (nonatomic,copy)NSString *desc;
+(instancetype)initModelTypeWithDict:(NSDictionary *)dict;
@end
