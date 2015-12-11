//
//  ExperienceTableViewCell.m
//  mokoo
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ExperienceTableViewCell.h"
#import "MokooMacro.h"
#import "UIView+SDExtension.h"
#import "UIButton+EnlargeTouchArea.h"
@implementation ExperienceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = placehoderFontColor.CGColor;
    self.lineLabel.sd_width = kDeviceWidth -32;
    self.rightBtn.sd_x = kDeviceWidth -32 -15;
    self.typeTF.sd_width = kDeviceWidth - 77 -32;
    [self.typeTF setTextColor:blackFontColor];
    self.contentTextView.sd_width = kDeviceWidth -63 -32;
    [self.typeTF setTextAlignment:NSTextAlignmentRight];
    self.typeTF.isPickView = YES;
    [self.typeTF setExperienceField:YES];
    self.typeTF.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initShowCell
{
    self.cell = [[[NSBundle mainBundle] loadNibNamed:@"ExperienceTableViewCell" owner:self options:nil] lastObject];
    

    //    cell.titleLabel = [[UILabel alloc]init];
    //    cell.dateLabel = [[UILabel alloc]init];
    //    cell.contentLabel = [[UILabel alloc]init];
    
    self.cell.backgroundColor = whiteFontColor;
    return self.cell;
}
-(id)initExperienceCellWithModel:(ModelTypeModel *)model
{
    ExperienceTableViewCell *cell     =(ExperienceTableViewCell *)[[ExperienceTableViewCell alloc] initShowCell];
    if (model.type) {
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
        NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
            //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
        NSArray *typeArray = [typeDict objectForKey:@"Type"];
        NSInteger index = [model.type integerValue];

        cell.typeTF.text = typeArray[index -1];
    }
    [cell.rightBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    if (model.desc) {
        CGSize textSize = [model.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 63 -32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

        cell.contentTextView.text = model.desc;
        if (textSize.height >28) {
            cell.contentTextView.sd_height = textSize.height +28;
            cell.sd_height = cell.sd_height +textSize.height ;

        }
    }
    return cell;
}
@end
