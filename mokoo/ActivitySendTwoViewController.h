//
//  ActivitySendTwoViewController.h
//  mokoo
//
//  Created by Mac on 15/10/30.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"
#import "MHTextField.h"
#import "ActivityTextField.h"
@interface ActivitySendTwoViewController : UIViewController
@property (weak, nonatomic) IBOutlet ActivityTextField *contentTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *feeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *startTimeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *endTimeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *cityTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *locationDetailTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *peopleNumTF;
@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
