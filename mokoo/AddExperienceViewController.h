//
//  AddExperienceViewController.h
//  mokoo
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddExperienceViewControllerDelegate<NSObject>
-(void)addSucced;
@end
@interface AddExperienceViewController : UIViewController
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,assign)NSInteger selected;
@property (nonatomic,copy)NSString *jlDesc;
@property (nonatomic,copy)NSString *jl_id;
@property (nonatomic,assign) id<AddExperienceViewControllerDelegate>delegate;
@end
