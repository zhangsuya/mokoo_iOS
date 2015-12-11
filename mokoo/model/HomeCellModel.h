//
//  HomeCellModel.h
//  mokoo
//
//  Created by Mac on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject
/** cellTitle */
@property (nonatomic, copy) NSString *section_title;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/** 浏览次数 */
@property (nonatomic, copy) NSString *fav_count;
/** 底部名称 */
@property (nonatomic, copy) NSString *poi_name;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;
@end
