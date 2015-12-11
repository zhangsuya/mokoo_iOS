//
//  MessageSendTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/11/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSendTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UISwitch *messageSwitch;
@property (nonatomic,strong) UILabel *rightTitleLabel;
-(UITableViewCell *)initShowCell;
-(id)initFirstTableViewCell;
-(id)initSecondTableViewCell;
@end
