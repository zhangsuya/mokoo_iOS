//
//  PlanListModel.h
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanListModel : NSObject
//"plan_id":"日程ID",
//"user_id":"用户ID",
//"content":"内容",
//"start":"开始时间",
//"end":"结束时间",
//"status":"日程计划状态",  1.已预约   1.空闲
@property (nonatomic,copy)NSString *plan_id;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *start;
@property (nonatomic,copy)NSString *end;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *status_name;
+(instancetype)initPlanListWithDict:(NSDictionary *)dict;
@end
