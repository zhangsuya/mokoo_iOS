//
//  NSString+DrExtension.m
//  mokoo
//
//  Created by 陈栋梁 on 15/11/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "NSString+DrExtension.h"

@implementation NSString (DrExtension)


+(BOOL)isEmptyString:(NSString *)str {
    
    if (str == nil || ![str isKindOfClass:[NSString class]] || [str isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}


@end
