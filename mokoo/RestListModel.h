//
//  RestListModel.h
//  mokoo
//
//  Created by Mac on 15/11/5.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestListModel : NSObject
//"plan_id":"日程ID",
//"date":"日期",
@property (nonatomic,copy)NSString *plan_id;
@property (nonatomic,copy)NSString *date;
+(instancetype)initRestListWithDict:(NSDictionary *)dict;
@end
