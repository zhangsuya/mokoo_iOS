//
//  ExperienceTableViewCell.h
//  mokoo
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTypeModel.h"
#import "PersonalTextField.h"
@interface ExperienceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet PersonalTextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (nonatomic,strong)ExperienceTableViewCell *cell;
-(id)initShowCell;
-(id)initExperienceCellWithModel:(ModelTypeModel *)model;
@end
