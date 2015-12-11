//
//  ImgaeListModel.h
//  mokoo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageListModel : NSObject
@property (nonatomic,copy)NSString *img_id;
@property (nonatomic,copy)NSString *url;
+(instancetype)initListModelWithDict:(NSDictionary *)dict;
@end
