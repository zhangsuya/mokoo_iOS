//
//  SGTextFieldMenu.h
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SGBaseMenu.h"

@interface SGTextFieldMenu : SGBaseMenu
- (id)initTextFieldViewWithDict:(NSDictionary *)dict;

- (void)triggerSelectedAction:(void(^)(NSDictionary *))SGChooseFieldActionHandler;
@end
