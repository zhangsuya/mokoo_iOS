//
//  ShowPersonalInfoTableViewController.m
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowPersonalInfoTableViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "ModelInfosModel.h"
#import "ModelTypeModel.h"
#import "ShowPersonalnfoTableViewCell.h"
#import "DemoTextField.h"
#import "EMMallSectionView.h"
#import "RegisterDataViewController.h"
#import "MJRefresh.h"
#import "UIView+SDExtension.h"
@interface ShowPersonalInfoTableViewController ()
@property (nonatomic,strong)ModelInfosModel *model;
@property (nonatomic,strong)NSMutableArray *experienceArray;
//@property (nonatomic,strong)ModelTypeModel *experienceModel;
@end
#define kFileName @"showNormalPersonalInfo.plist"
@implementation ShowPersonalInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ShowPersonalnfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.tableView.style = UITableViewStyleGrouped;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if ([_personalModel.user_type isEqualToString:@"1"]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
            if ([_personalModel.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                UIButton *addTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                addTypeBtn.frame = CGRectMake(0, 201,161, 42);
                [addTypeBtn.titleLabel setTextColor:blackFontColor];
                [addTypeBtn setTitle:@"申请成为模特" forState:UIControlStateNormal];
                [addTypeBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
                [addTypeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [addTypeBtn.titleLabel setText:@"申请成为模特"];
                //    addTypeBtn.backgroundColor = [UIColor whiteColor];
                addTypeBtn.layer.masksToBounds = YES;
                addTypeBtn.layer.borderColor = blackFontColor.CGColor;
                addTypeBtn.layer.borderWidth = 0.5;
                addTypeBtn.center = CGPointMake(kDeviceWidth/2, 201);
                addTypeBtn.layer.cornerRadius = 3;
                [addTypeBtn addTarget:self action:@selector(addTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                [self.tableView addSubview:addTypeBtn];
            }
        }
        
        
        [self.tableView reloadData];
    }else if ([_personalModel.user_type isEqualToString:@"2"])
    {
        [self initRefresh];
        [self requestInfo];

    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    
    
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestInfo];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([_personalModel.user_type isEqualToString:@"1"]) {
        return 2;

    }else if ([_personalModel.user_type isEqualToString:@"2"])
    {
        return 3 +[_experienceArray count];

    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([_personalModel.user_type isEqualToString:@"1"]) {
        if (section ==0) {
            return 2;
        }else if (section ==1 )
        {
            return 1;
        }
    }else if ([_personalModel.user_type isEqualToString:@"2"])
    {
        if (section ==0) {
            return 2;
        }else if (section ==1 )
        {
            return 6;
        }else if (section ==2)
        {
            return 8;
        }else
        {
            return 1;
        }
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height=0 ;
    if (section ==0) {
        height = 10;
    }else
    {
        height = 6;
    }
    EMMallSectionView *sectionView =  [EMMallSectionView showWithName:height];
    sectionView.tableView = self.tableView;
    sectionView.section = section;
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [EMMallSectionView getSectionHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellId = [NSString stringWithFormat:@"cell"];
//    ShowPersonalnfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ShowPersonalnfoTableViewCell *cell = [[ShowPersonalnfoTableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5f)];
    lineLabel.backgroundColor = lineSystemColor;
    [cell.contentView addSubview:lineLabel];
        
        
    if ([_personalModel.user_type isEqualToString:@"1"]) {
        [self initWithNoVCell:cell withIndexPath:indexPath];
    }else if ([_personalModel.user_type isEqualToString:@"2"])
    {
        [self initWithCell:cell withIndexPath:indexPath];

    }
    
            //    cell.titleLabel = [[UILabel alloc]init];
            //    cell.dateLabel = [[UILabel alloc]init];
            //    cell.contentLabel = [[UILabel alloc]init];
//        cell.backgroundColor = viewBgColor;
    
    return cell;
}
-(void)initWithNoVCell:(ShowPersonalnfoTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            UIButton *vBtn = [[UIButton alloc]init];
            vBtn.frame = CGRectMake(16, 9.5f, 95, 25);
            [vBtn setTitle:@"实名认证" forState:UIControlStateNormal];
            [vBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            UILabel *vLabel = [[UILabel alloc]init];
            
            [vLabel setTextAlignment:NSTextAlignmentCenter];
            vLabel.frame = CGRectMake(16, 9.5f, 65, 25);
            //            [vLabel setba]
            [vLabel setFont:[UIFont systemFontOfSize:13]];
            vLabel.layer.masksToBounds = YES;
            vLabel.layer.cornerRadius = 12;
            vLabel.layer.borderWidth = 1;
            if ([_personalModel.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                if ([_personalModel.is_verify isEqualToString:@"1"]) {
                    [vLabel setText:@"实名认证"];
                    [vLabel setTextColor:orangeFontColor];
                    vLabel.layer.borderColor = [orangeFontColor CGColor];
                }else if ([_personalModel.is_verify isEqualToString:@"0"])
                {
                    [vLabel setText:@"未认证"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }else if ([_personalModel.is_verify isEqualToString:@"2"])
                {
                    [vLabel setText:@"审核中"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }else if ([_personalModel.is_verify isEqualToString:@"3"])
                {
                    [vLabel setText:@"认证拒绝"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }
                
                
            }else
            {
                if ([_personalModel.is_verify isEqualToString:@"1"]) {
                    [vLabel setText:@"实名认证"];
                    [vLabel setTextColor:orangeFontColor];
                    vLabel.layer.borderColor = [orangeFontColor CGColor];
                }else
                {
                    [vLabel setText:@"未认证"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                    
                }
            }
            UITextField *nickNameTF = [[UITextField alloc]initWithFrame:CGRectMake(96, 2, kDeviceWidth -34 -88, 40)];
            [nickNameTF setFont:[UIFont systemFontOfSize:15]];
            //            nickNameTF.textColor = placehoderFontColor;
            nickNameTF.borderStyle = UITextBorderStyleNone;
            nickNameTF.userInteractionEnabled = NO;
            nickNameTF.text = _personalModel.nick_name;
            [cell.contentView addSubview:vLabel];
            [cell.contentView addSubview:nickNameTF];
        }else if(indexPath.row ==1){
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5f, kDeviceWidth, 0.5f)];
            lineLabel.backgroundColor = lineSystemColor;
            [cell.contentView addSubview:lineLabel];
            UITextField *moodTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth - 32, 40)];
            //            moodTF.textColor = placehoderFontColor;
            [moodTF setFont:[UIFont systemFontOfSize:15]];
            moodTF.borderStyle = UITextBorderStyleNone;
            moodTF.userInteractionEnabled = NO;
            if (_personalModel.sign ==nil ||[_personalModel.sign length]==0) {
               moodTF.text = @"TA比较懒,什么也没写...";
            }else
            {
               moodTF.text = _personalModel.sign;
            }

            [cell.contentView addSubview:moodTF];
        }
    }else if (indexPath.section ==1)
    {
        if (indexPath.row ==0) {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5f, kDeviceWidth, 0.5f)];
            lineLabel.backgroundColor = lineSystemColor;
            [cell.contentView addSubview:lineLabel];
            UILabel *destinationLabel = (UILabel *)[[self class] initLabelWithTitle:@"地区"];
            UITextField *destinationTextField = [[UITextField alloc]initWithFrame:CGRectMake(destinationLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -destinationLabel.frame.size.width , 40)];
            [destinationTextField setFont:[UIFont systemFontOfSize:14]];
            
            [destinationTextField setTextAlignment:NSTextAlignmentRight];
            destinationTextField.borderStyle = UITextBorderStyleNone;
            destinationTextField.text = _personalModel.address;
            destinationTextField.userInteractionEnabled = NO;
            destinationTextField.textColor = placehoderFontColor;
            
            [cell.contentView addSubview:destinationLabel];
            [cell.contentView addSubview:destinationTextField];
            
        }
    }
}

-(void)initWithCell:(ShowPersonalnfoTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            UIButton *vBtn = [[UIButton alloc]init];
            vBtn.frame = CGRectMake(16, 9.5f, 95, 25);
            [vBtn setTitle:@"实名认证" forState:UIControlStateNormal];
            [vBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            UILabel *vLabel = [[UILabel alloc]init];
            
            [vLabel setTextAlignment:NSTextAlignmentCenter];
            vLabel.frame = CGRectMake(16, 9.5f, 65, 25);
//            [vLabel setba]
            [vLabel setFont:[UIFont systemFontOfSize:13]];
            vLabel.layer.masksToBounds = YES;
            vLabel.layer.cornerRadius = 12;
            vLabel.layer.borderWidth = 1;
            if ([_model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                if ([_model.is_verify isEqualToString:@"1"]) {
                    [vLabel setText:@"实名认证"];
                    [vLabel setTextColor:orangeFontColor];
                    vLabel.layer.borderColor = [orangeFontColor CGColor];
                }else if ([_model.is_verify isEqualToString:@"0"])
                {
                    [vLabel setText:@"未认证"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }else if ([_model.is_verify isEqualToString:@"2"])
                {
                    [vLabel setText:@"审核中"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }else if ([_model.is_verify isEqualToString:@"3"])
                {
                    [vLabel setText:@"认证拒绝"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                }

                
            }else
            {
                if ([_model.is_verify isEqualToString:@"1"]) {
                    [vLabel setText:@"实名认证"];
                    [vLabel setTextColor:orangeFontColor];
                    vLabel.layer.borderColor = [orangeFontColor CGColor];
                }else
                {
                    [vLabel setText:@"未认证"];
                    [vLabel setTextColor:placehoderFontColor];
                    vLabel.layer.borderColor = [placehoderFontColor CGColor];
                    
                }
            }
            UITextField *nickNameTF = [[UITextField alloc]initWithFrame:CGRectMake(96, 2, kDeviceWidth -34 -88, 40)];
            [nickNameTF setFont:[UIFont systemFontOfSize:15]];
//            nickNameTF.textColor = placehoderFontColor;
            nickNameTF.borderStyle = UITextBorderStyleNone;
            nickNameTF.userInteractionEnabled = NO;
            nickNameTF.text = _model.nick_name;
            [cell.contentView addSubview:vLabel];
            [cell.contentView addSubview:nickNameTF];
        }else if(indexPath.row ==1){
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5f, kDeviceWidth, 0.5f)];
            lineLabel.backgroundColor = lineSystemColor;
            [cell.contentView addSubview:lineLabel];
            UITextField *moodTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth - 32, 40)];
//            moodTF.textColor = placehoderFontColor;
            [moodTF setFont:[UIFont systemFontOfSize:15]];
            moodTF.borderStyle = UITextBorderStyleNone;
            moodTF.userInteractionEnabled = NO;
            if (_model.sign.length ==0) {
                moodTF.text = @"这个人很懒，没有写心情";
            }else
            {
                moodTF.text = _model.sign;

            }
            [cell.contentView addSubview:moodTF];
        }
    }else if (indexPath.section ==1)
    {
        if (indexPath.row ==0) {
            UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:@"身高"];
            UITextField *heightTF = [[UITextField alloc]initWithFrame:CGRectMake(threeLabel.frame.size.width +16, 1, kDeviceWidth/2 -threeLabel.frame.size.width -34, 40)];
            [heightTF setFont:[UIFont systemFontOfSize:14]];

            heightTF.borderStyle = UITextBorderStyleNone;
            [heightTF setTextAlignment:NSTextAlignmentRight];
            heightTF.userInteractionEnabled = NO;
            heightTF.text = [NSString stringWithFormat:@"%@cm",_model.height];
            heightTF.textColor = placehoderFontColor;
            UILabel *weightLab = [[UILabel alloc]init];
            [weightLab setText:@"体重"];
            [weightLab setFont:[UIFont systemFontOfSize:15]];
//            [weightLab setTextColor:grayFontColor];
            CGSize textSize = [@"体重" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            weightLab.frame = CGRectMake(kDeviceWidth/2 + 16, 0, textSize.width, 42);
            UITextField *weightTF = [[UITextField alloc]initWithFrame:CGRectMake(weightLab.frame.size.width +16 +kDeviceWidth/2, 1, kDeviceWidth/2-weightLab.frame.size.width - 35, 40)];
            [weightTF setFont:[UIFont systemFontOfSize:14]];

            weightTF.borderStyle = UITextBorderStyleNone;
            weightTF.userInteractionEnabled = NO;
            weightTF.text = [NSString stringWithFormat:@"%@cm",_model.weight];
            weightTF.textColor = placehoderFontColor;
            [weightTF setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:threeLabel];
            [cell.contentView addSubview:heightTF];
            [cell.contentView addSubview:weightLab];
            [cell.contentView addSubview:weightTF];

        }else if (indexPath.row == 1)
        {
            UILabel *BWHLabel = (UILabel *)[[self class] initLabelWithTitle:@"三围"];
            UITextField *BWHTF = [[UITextField alloc]initWithFrame:CGRectMake(BWHLabel.frame.size.width +16, 1, kDeviceWidth/2 -BWHLabel.frame.size.width -34, 40)];
            [BWHTF setFont:[UIFont systemFontOfSize:14]];

            BWHTF.borderStyle = UITextBorderStyleNone;
            BWHTF.userInteractionEnabled = NO;
            BWHTF.text = _model.three_size;
            BWHTF.textColor = placehoderFontColor;
            [BWHTF setTextAlignment:NSTextAlignmentRight];
            UILabel *shoesSizeLab = [[UILabel alloc]init];
            [shoesSizeLab setText:@"鞋码"];
            [shoesSizeLab setFont:[UIFont systemFontOfSize:15]];
//            [shoesSizeLab setTextColor:grayFontColor];
            CGSize shoesSizeLabSize = [@"鞋码" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            shoesSizeLab.frame = CGRectMake(kDeviceWidth/2 + 16, 0, shoesSizeLabSize.width, 42);
            UITextField *shoesSizeTF = [[UITextField alloc]initWithFrame:CGRectMake(shoesSizeLab.frame.size.width +16 +kDeviceWidth/2, 1, kDeviceWidth/2-shoesSizeLab.frame.size.width - 35, 40)];
            [shoesSizeTF setFont:[UIFont systemFontOfSize:14]];

            [shoesSizeTF setTextAlignment:NSTextAlignmentRight];
            shoesSizeTF.borderStyle = UITextBorderStyleNone;
            shoesSizeTF.text = _model.shoe_size;
            shoesSizeTF.textColor = placehoderFontColor;
            shoesSizeTF.userInteractionEnabled = NO;
            [cell.contentView addSubview:BWHLabel];
            [cell.contentView addSubview:BWHTF];
            [cell.contentView addSubview:shoesSizeLab];
            [cell.contentView addSubview:shoesSizeTF];
        }else if(indexPath.row ==2)
        {
            UILabel *goodAtStyleLabel = (UILabel *)[[self class] initLabelWithTitle:@"擅长风格"];
            UITextField *goodAtStyleTF = [[UITextField alloc]initWithFrame:CGRectMake(goodAtStyleLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -goodAtStyleLabel.frame.size.width  , 40)];
            [goodAtStyleTF setFont:[UIFont systemFontOfSize:14]];

            goodAtStyleTF.borderStyle = UITextBorderStyleNone;
            goodAtStyleTF.text = _model.style_name;
            goodAtStyleTF.textColor = placehoderFontColor;
            goodAtStyleTF.userInteractionEnabled = NO;
            [goodAtStyleTF setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:goodAtStyleLabel];
            [cell.contentView addSubview:goodAtStyleTF];
            
            
        }else if (indexPath.row ==3)
        {
            UILabel *occupationalTypesLabel = (UILabel *)[[self class] initLabelWithTitle:@"职业类型"];
            UITextField *occupationalTypesTextField = [[UITextField alloc]initWithFrame:CGRectMake(occupationalTypesLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -occupationalTypesLabel.frame.size.width , 40)];
            [occupationalTypesTextField setFont:[UIFont systemFontOfSize:14]];

            [occupationalTypesTextField setTextAlignment:NSTextAlignmentRight];
            occupationalTypesTextField.borderStyle = UITextBorderStyleNone;
            occupationalTypesTextField.text = _model.work_type_name;
            occupationalTypesTextField.textColor = placehoderFontColor;
            occupationalTypesTextField.userInteractionEnabled = NO;
            [cell.contentView addSubview:occupationalTypesLabel];
            [cell.contentView addSubview:occupationalTypesTextField];
        }else if (indexPath.row ==4)
        {
            UILabel *countryLabel = (UILabel *)[[self class] initLabelWithTitle:@"国籍"];
            UITextField  *countryTextField = [[UITextField alloc]initWithFrame:CGRectMake(countryLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -countryLabel.frame.size.width , 40)];
            [countryTextField setFont:[UIFont systemFontOfSize:14]];

            [countryTextField setTextAlignment:NSTextAlignmentRight];
            countryTextField.borderStyle = UITextBorderStyleNone;
            countryTextField.text = _model.country_name;
            countryTextField.userInteractionEnabled = NO;
            countryTextField.textColor= placehoderFontColor;
            
            [cell.contentView addSubview:countryLabel];
            [cell.contentView addSubview:countryTextField];
            
            
        }else if (indexPath.row == 5)
        {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5f, kDeviceWidth, 0.5f)];
            lineLabel.backgroundColor = lineSystemColor;
            [cell.contentView addSubview:lineLabel];
            UILabel *destinationLabel = (UILabel *)[[self class] initLabelWithTitle:@"目前所在地"];
            UITextField *destinationTextField = [[UITextField alloc]initWithFrame:CGRectMake(destinationLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -destinationLabel.frame.size.width , 40)];
            [destinationTextField setFont:[UIFont systemFontOfSize:14]];

            [destinationTextField setTextAlignment:NSTextAlignmentRight];
            destinationTextField.borderStyle = UITextBorderStyleNone;
            destinationTextField.text = _model.address_name;
            destinationTextField.userInteractionEnabled = NO;
            destinationTextField.textColor = placehoderFontColor;
            
            [cell.contentView addSubview:destinationLabel];
            [cell.contentView addSubview:destinationTextField];
        }
    }else if (indexPath.section == 2)
    {
        if (indexPath.row ==0) {
            UILabel *hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发"];
            UITextField *hairTextField = [[UITextField alloc]initWithFrame:CGRectMake(hairLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -hairLabel.frame.size.width , 40)];
            [hairTextField setFont:[UIFont systemFontOfSize:14]];

            [hairTextField setTextAlignment:NSTextAlignmentRight];
            hairTextField.borderStyle = UITextBorderStyleNone;
            hairTextField.text = _model.hair_name;
            hairTextField.userInteractionEnabled = NO;
            hairTextField.textColor = placehoderFontColor;
            [cell.contentView addSubview:hairLabel];
            [cell.contentView addSubview:hairTextField];
            
        }else if (indexPath.row ==1)
        {
            UILabel *skinColorLabel = (UILabel *)[[self class] initLabelWithTitle:@"肤色"];
            UITextField *skinColorTextField = [[UITextField alloc]initWithFrame:CGRectMake(skinColorLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -skinColorLabel.frame.size.width , 40)];
            [skinColorTextField setFont:[UIFont systemFontOfSize:14]];

            skinColorTextField.borderStyle = UITextBorderStyleNone;
            skinColorTextField.text = _model.color_name;
            skinColorTextField.userInteractionEnabled = NO;
            skinColorTextField.textColor = placehoderFontColor;
            [skinColorTextField setTextAlignment:NSTextAlignmentRight];
            
            
            [cell.contentView addSubview:skinColorLabel];
            [cell.contentView addSubview:skinColorTextField];
        }else if (indexPath.row ==2)
        {
            UILabel *eyeLabel = (UILabel *)[[self class] initLabelWithTitle:@"眼睛"];
            UITextField *eyeField = [[UITextField alloc]initWithFrame:CGRectMake(eyeLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -eyeLabel.frame.size.width , 40)];
            [eyeField setFont:[UIFont systemFontOfSize:14]];

            [eyeField setTextAlignment:NSTextAlignmentRight];
            eyeField.borderStyle = UITextBorderStyleNone;
            eyeField.text = _model.eye_name;
            eyeField.userInteractionEnabled = NO;
            eyeField.textColor = placehoderFontColor;
            [cell.contentView addSubview:eyeLabel];
            [cell.contentView addSubview:eyeField];

        }else if (indexPath.row ==3)
        {
            UILabel *shoulderLabel = (UILabel *)[[self class] initLabelWithTitle:@"肩宽"];
            UITextField *shoulderField = [[UITextField alloc]initWithFrame:CGRectMake(shoulderLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -shoulderLabel.frame.size.width , 40)];
            [shoulderField setFont:[UIFont systemFontOfSize:14]];

            [shoulderField setTextAlignment:NSTextAlignmentRight];
            shoulderField.borderStyle = UITextBorderStyleNone;
            if (_model.shoulder) {
                shoulderField.text = [NSString stringWithFormat:@"%@cm",_model.shoulder];

            }
            shoulderField.userInteractionEnabled = NO;
            shoulderField.textColor = placehoderFontColor;
            [cell.contentView addSubview:shoulderLabel];
            [cell.contentView addSubview:shoulderField];
        }else if (indexPath.row ==4)
        {
            UILabel *legLabel = (UILabel *)[[self class] initLabelWithTitle:@"腿长"];
            UITextField *legField = [[UITextField alloc]initWithFrame:CGRectMake(legLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -legLabel.frame.size.width , 40)];
            [legField setFont:[UIFont systemFontOfSize:14]];

            [legField setTextAlignment:NSTextAlignmentRight];
            legField.borderStyle = UITextBorderStyleNone;
            if (_model.legs) {
                legField.text = [NSString stringWithFormat:@"%@cm",_model.legs];
            }
            legField.userInteractionEnabled = NO;
            legField.textColor = placehoderFontColor;
            [cell.contentView addSubview:legLabel];
            [cell.contentView addSubview:legField];

        }else if (indexPath.row ==5)
        {
            UILabel *languageLabel = (UILabel *)[[self class] initLabelWithTitle:@"语言"];
            UITextField *languageField = [[UITextField alloc]initWithFrame:CGRectMake(languageLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -languageLabel.frame.size.width , 40)];
            [languageField setFont:[UIFont systemFontOfSize:14]];

            [languageField setTextAlignment:NSTextAlignmentRight];
            languageField.borderStyle = UITextBorderStyleNone;
            languageField.text = _model.language_name;
            languageField.userInteractionEnabled = NO;
            languageField.textColor = placehoderFontColor;
            [cell.contentView addSubview:languageLabel];
            [cell.contentView addSubview:languageField];
        }else if (indexPath.row ==6)
        {
            UILabel *priceLabel = (UILabel *)[[self class] initLabelWithTitle:@"价格"];
            UITextField *priceField = [[UITextField alloc]initWithFrame:CGRectMake(priceLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -priceLabel.frame.size.width , 40)];
            [priceField setFont:[UIFont systemFontOfSize:14]];

            priceField.borderStyle = UITextBorderStyleNone;
            priceField.text = _model.price_name;
            priceField.userInteractionEnabled = NO;
            [priceField setTextAlignment:NSTextAlignmentRight];
            priceField.textColor = placehoderFontColor;
            [cell.contentView addSubview:priceLabel];
            [cell.contentView addSubview:priceField];

        }else if (indexPath.row ==7)
        {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5f, kDeviceWidth, 0.5f)];
            lineLabel.backgroundColor = lineSystemColor;
            [cell.contentView addSubview:lineLabel];
            UILabel *companyLabel = (UILabel *)[[self class] initLabelWithTitle:@"经纪人/公司"];
            UITextField *companyField = [[UITextField alloc]initWithFrame:CGRectMake(companyLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -companyLabel.frame.size.width , 40)];
            [companyField setFont:[UIFont systemFontOfSize:15]];

            companyField.borderStyle = UITextBorderStyleNone;
            companyField.text = _model.company;
            companyField.userInteractionEnabled = NO;
            [companyField setTextAlignment:NSTextAlignmentRight];
//            companyField.textColor = placehoderFontColor;
            [cell.contentView addSubview:companyLabel];
            [cell.contentView addSubview:companyField];
        }
    }else
    {
        //    定义一个NSBundle对象获取得到应用程序的main bundle
        
//        NSBundle *mainBundle = [NSBundle mainBundle];
        
        //    用对象mainBundle获取图片路径
        
//        NSDictionary *typeDict = [mainBundle pathForResource:@"Experience" ofType:@"plist"];
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
        NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
//        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
        NSArray *typeArray = [typeDict objectForKey:@"Type"];
        
        ModelTypeModel *experienceModel = _experienceArray[indexPath.section -3];
        NSInteger index = [experienceModel.type integerValue]-1;
        UILabel *typeLabel = (UILabel *)[[self class] initLabelWithTitle:typeArray[index]];
        UILabel *contentLabel = [[UILabel alloc]init];
        CGSize textSize = [experienceModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 15 -16 -16 -CGRectGetWidth(typeLabel.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        [contentLabel setTextColor:placehoderFontColor];
        contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = lineSystemColor;
        [cell.contentView addSubview:lineLabel];
        if (textSize.height  < 23) {
            cell.sd_height = 44;
            lineLabel.frame = CGRectMake(0, 43.5f, kDeviceWidth, 0.5f);
        }else
        {
            cell.sd_height = textSize.height +44;
            lineLabel.frame = CGRectMake(0, textSize.height +44 -0.5f, kDeviceWidth, 0.5f);
        }
        
        contentLabel.frame = CGRectMake(  15 +16  +CGRectGetWidth(typeLabel.frame), 14, textSize.width, textSize.height);
        contentLabel.text = experienceModel.desc;

//        UITextField *companyField = [[UITextField alloc]initWithFrame:CGRectMake(companyLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -companyLabel.frame.size.width , 40)];
//        [companyField setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:typeLabel];
        [cell.contentView addSubview:contentLabel];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<3)
    {
        return 44;
    }
    else
    {
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
        NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
        //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
        NSArray *typeArray = [typeDict objectForKey:@"Type"];
        ModelTypeModel *experienceModel = _experienceArray[indexPath.section -3];
        NSInteger index = [experienceModel.type integerValue];
        UILabel *typeLabel = (UILabel *)[[self class] initLabelWithTitle:typeArray[index]];
        CGSize textSize = [experienceModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 15 -16 -16 -CGRectGetWidth(typeLabel.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        if (textSize.height  < 23) {
            return 44;
        }else
        {
            return textSize.height +44;
        }

    }
    
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        if ([_personalModel.user_type isEqualToString:@"1"]) {
            if ([_personalModel.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]&&([_personalModel.is_verify isEqualToString:@"0"]||[_personalModel.is_verify isEqualToString:@"3"])) {
                RealNameTwoViewController *realVC = [[RealNameTwoViewController alloc]init];
                if ([_delegate respondsToSelector:@selector(pushRealNameController:)]) {
                    [_delegate pushRealNameController: realVC];
                }
            }
        }else if ([_personalModel.user_type isEqualToString:@"2"])
        {
            if ([_model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]&&([_model.is_verify isEqualToString:@"0"]||[_model.is_verify isEqualToString:@"3"])) {
                RealNameTwoViewController *realVC = [[RealNameTwoViewController alloc]init];
                if ([_delegate respondsToSelector:@selector(pushRealNameController:)]) {
                    [_delegate pushRealNameController: realVC];
                }
            }
        }
        
        
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section ==0) {
//        return 10;
//    }else
//    {
//        return 6;
//    }
//    return 0;
//}
+ (UILabel *)initLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:15]];
//    [lab setTextColor:grayFontColor];
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    lab.frame = CGRectMake(16, 2, textSize.width, 40);
    return lab;
}
-(void)addTypeBtnClicked
{
    RegisterDataViewController *dataViewController = [[RegisterDataViewController alloc]initWithNibName:@"RegisterDataViewController" bundle:nil];
    dataViewController.userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    dataViewController.isPersonal = YES;
    [self presentViewController:dataViewController animated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",_user_id?_user_id:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],kFileName]];
}
-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSDictionary *dataDict = [[NSDictionary alloc]initWithContentsOfFile:filePath];
        _model = [ModelInfosModel initModelInfosWithDict:dataDict];
        _experienceArray = [NSMutableArray array];
        for (int i = 0; i<[_model.jingli count]; i ++) {
            ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
            [_experienceArray addObject:experienceModel];
        }
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    }
    [self.tableView.header performSelector:@selector(beginRefreshing) withObject:nil];
}

-(void)requestInfo
{
    NSString *userId;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userId = [userDefaults objectForKey:@"user_id"];
    }
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                _experienceArray = [NSMutableArray array];
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
                [self.tableView.header endRefreshing];
                [self.tableView reloadData];
            }
        }
        
    }];
}
@end
