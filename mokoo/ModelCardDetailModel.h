//
//  ModelCardDetailModel.h
//  mokoo
//
//  Created by Mac on 15/9/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModelCardDetailModel : NSObject
//"user_id":"用户ID",
//"img1":"图片1",
//"img2":"图片2",
//"img3":"图片3",
//"img4":"图片4",
//"img5":"图片5",
//"jingli":[{
//    "jl_id":"经历ID",
//    "type":"经历类型",
//    "desc":"经历描述",
//}],
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *img1;
@property (nonatomic,copy)NSString *img2;
@property (nonatomic,copy)NSString *img3;
@property (nonatomic,copy)NSString *img4;
@property (nonatomic,copy)NSString *img5;
@property (nonatomic,strong)NSArray *jingli;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
+(instancetype)initModelCardDetailWithDict:(NSDictionary *)dict;

@end
