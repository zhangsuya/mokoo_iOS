//
//  ModelCardModel.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModelCardModel : NSObject
@property (nonatomic,copy)NSString *card_id;
@property(nonatomic,copy)NSString * img_url;
@property(nonatomic,assign)CGFloat  width;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,copy)NSString *user_id;
+(instancetype)initModelCardListWithDict:(NSDictionary *)dict;
@end
