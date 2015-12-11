//
//  AllPlanListModel.h
//  mokoo
//
//  Created by Mac on 15/11/5.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllPlanListModel : NSObject
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,copy)NSString *sleep;
+(instancetype)initAllPlanListWithDict:(NSDictionary *)dict;
@end
