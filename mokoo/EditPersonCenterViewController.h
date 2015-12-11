//
//  EditPersonCenterViewController.h
//  mokoo
//
//  Created by Mac on 15/9/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditPersonCenterViewControllerDelegate<NSObject>
-(void)editPersonCenterInfoRefrensh;
@end
@interface EditPersonCenterViewController : UIViewController
+ (UILabel *)initLabelWithTitle:(NSString *)title;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,assign) id<EditPersonCenterViewControllerDelegate>delegate;
@end
