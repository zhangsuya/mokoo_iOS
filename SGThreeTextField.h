//
//  SGThreeTextField.h
//  mokoo
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "SGBaseMenu.h"

@interface SGThreeTextField : SGBaseMenu
- (id)initTextFieldViewWithString:(NSString *)dict;

- (void)triggerSelectedAction:(void(^)(NSString *))SGChooseStringActionHandler;
@end
