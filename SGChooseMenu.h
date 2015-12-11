//
//  SGChooseMenu.h
//  mokoo
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SGBaseMenu.h"

@interface SGChooseMenu : SGBaseMenu
- (id)initWithTitle:(NSArray *)selectedTitles itemTitles:(NSArray *)itemTitles limitedNum:(NSInteger) num;
- (void)triggerSelectedAction:(void(^)(NSArray *))actionHandle;

@end
