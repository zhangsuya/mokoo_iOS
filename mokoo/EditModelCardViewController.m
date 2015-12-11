//
//  EditModelCardViewController.m
//  mokoo
//
//  Created by Mac on 15/9/22.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "EditModelCardViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
#import "ExperienceTableViewCell.h"
#import "ModelTypeModel.h"
#import "ModelInfosModel.h"
#import "UIView+SDExtension.h"
#import "HJCActionSheet.h"
#import "AddExperienceViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FixOrientation.h"
@interface EditModelCardViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,HJCActionSheetDelegate,AddExperienceViewControllerDelegate>
{
    NSArray *typeArray;
    UIImageView *tmpView;
    NSMutableArray *selectedImageArray;
    NSMutableArray *endImageArray;
    NSMutableArray *existedHeight;
    NSString *jl_ids ;
    NSUInteger beforeCount;
    NSUInteger isSelectedImage;
}
@property (nonatomic,strong)ModelInfosModel *model;
@property (nonatomic,strong)NSMutableArray *experienceArray;
@end

@implementation EditModelCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedImageArray = [NSMutableArray array];
    existedHeight = [NSMutableArray array];
    _experienceArray = [NSMutableArray array];
//    [self.experienceTableView registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.view.autoresizesSubviews = NO;
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _addTypeBtn.layer.masksToBounds = YES;
    _addTypeBtn.layer.borderColor = blackFontColor.CGColor;
    _addTypeBtn.layer.borderWidth = 0.5;
    _addTypeBtn.layer.cornerRadius = 3;
    [_addTypeBtn addTarget:self action:@selector(addTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    _experienceTableView.delegate = self;
    _experienceTableView.dataSource = self;
    [_experienceTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setUpNavigationItem];
    [self initConstraint];
    [self initTypeArray];
    [self requestInfo];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initConstraint
{
    self.bigImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.firstImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.secondImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.threeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.fourImageView.translatesAutoresizingMaskIntoConstraints = NO;

    _submitBtnTopConstraint.constant  = 36;
    _addTypeBtnTopConstraint.constant = 20;
    _twoSamllConstraint.constant = (kDeviceWidth -290)/3;
    _threeSmallConstraint.constant = (kDeviceWidth -290)/3;
    _fourSmallConstraint.constant = (kDeviceWidth -290)/3;
    _submitBtnConstraint.constant = kDeviceWidth - 16;
    _addCatagoryLeftConstraint.constant = (kDeviceWidth -161)/2;
    _tableViewWidthConstraint.constant = kDeviceWidth - 32;
//    _tableviewConstraint.constant = [_experienceArray count]*90;
}
-(void)initGes
{
    UITapGestureRecognizer  *tapBig     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer  *tapOne     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer  *tapTwo     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer  *tapThree    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer  *tapFour     = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    self.bigImageView.userInteractionEnabled = YES;
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bigImageView.clipsToBounds = YES;//裁剪边缘
    self.bigImageView.autoresizingMask=UIViewAutoresizingNone;
    self.bigImageView.autoresizesSubviews = NO;
    self.firstImageView.userInteractionEnabled = YES;
    self.firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.firstImageView.clipsToBounds = YES;//裁剪边缘
    
    self.secondImageView.userInteractionEnabled = YES;
    self.secondImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.secondImageView.clipsToBounds = YES;//裁剪边缘
    self.threeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.threeImageView.clipsToBounds = YES;//裁剪边缘
    self.threeImageView.userInteractionEnabled = YES;
    self.fourImageView.userInteractionEnabled = YES;
    self.fourImageView.clipsToBounds = YES;//裁剪边缘
    self.fourImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bigImageView addGestureRecognizer:tapBig];
    [self.firstImageView addGestureRecognizer:tapOne];
    [self.secondImageView addGestureRecognizer:tapTwo];
    [self.threeImageView addGestureRecognizer:tapThree];
    [self.fourImageView addGestureRecognizer:tapFour];

//    [self.threeImageView addGestureRecognizer:tap];
//    [self.fourImageView addGestureRecognizer:tap];
    

}
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    tmpView = (UIImageView *)tap.view;
//    ZPActionSheetView *delegateTest = [[ZPActionSheetView alloc]init];
//    [delegateTest setDelegate:self];  //设置代理
//    [self.view addSubview:delegateTest];
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照",@"从手机相册选择", nil];
    sheet.tag = 1002;
    [sheet show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"制作模特卡"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)initTypeArray
{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
    typeArray = [typeDict objectForKey:@"Type"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)zpActionSheet:(ZPActionSheetView *)view :(NSInteger)buttonIndex
{
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
    camera.delegate = self;
    camera.allowsEditing = NO;
    
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else
    {
        camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:camera animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *fixImage = [image fixOrientation:image];

    if ([tmpView isEqual:_bigImageView]) {
//        [tmpView sd]
        tmpView.image = fixImage;
//        [tmpView setNeedsLayout];
        [selectedImageArray addObject:fixImage];
        isSelectedImage =1;
    }else
    {
        MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
        imageCrop.delegate = self;
        imageCrop.ratioOfWidthAndHeight = 300.0f/400.0f;
        imageCrop.image = fixImage;
        [imageCrop showWithAnimation:NO];
    }
    
    [ picker dismissViewControllerAnimated: YES completion: nil ];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [ picker dismissViewControllerAnimated: YES completion: nil ];
}
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 1003) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}
#pragma mark - crop delegate
- (void)cropImage:(UIImage*)cropImage forOriginalImage:(UIImage*)originalImage
{
    tmpView.image = cropImage;
    isSelectedImage = 1;
//    [tmpView setNeedsLayout];
    [selectedImageArray addObject:cropImage];
}
- (IBAction)submiteBtnClicked:(UIButton *)sender {
    if ([selectedImageArray count]>=5) {
        endImageArray = [NSMutableArray array];
        [endImageArray addObject:self.bigImageView.image];
        [endImageArray addObject:self.firstImageView.image];
        [endImageArray addObject:self.secondImageView.image];
        [endImageArray addObject:self.threeImageView.image];
        [endImageArray addObject:self.fourImageView.image];
    }
    if ([endImageArray count]==5) {
        
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        [self.navigationController.view addSubview:HUD];
        
        //     The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
        //     Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
        HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uploading"]];
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.9;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 100000;
        [HUD.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        // Set custom view mode
        HUD.mode = MBProgressHUDModeCustomView;
        
        //    HUD.labelText = @"Completed";
        
        [HUD show:YES];
        //    NSString *jl_ids ;
        //    for (int i =0; i<[_experienceArray count];i++) {
        //        ModelTypeModel *model = _experienceArray[i];
        //        if (jl_ids ==nil) {
        //            jl_ids = [NSString stringWithFormat:@"%@",model.jl_id];
        //        }else
        //        {
        //            jl_ids = [jl_ids stringByAppendingString:[NSString stringWithFormat:@",%@",model.jl_id]];
        //        }
        //    }
        [RequestCustom addModelCardJL:jl_ids images:[endImageArray copy] complete:^(BOOL succed, id obj) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [HUD hide:YES afterDelay:0];
                if ([self.delegate respondsToSelector:@selector(editModelCardViewRefrensh)]) {
                    [_delegate editModelCardViewRefrensh];
                }
                [self.navigationController popViewControllerAnimated:NO];
            }
        }];

    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"必须选择5张图片";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    
}
-(void)backBtnClicked:(UIButton *)sender
{
    if (isSelectedImage||jl_ids) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消编辑" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1003;
        [myAlertView show];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_experienceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section !=0) {
        return 10;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ModelTypeModel *model = _experienceArray[indexPath.section];
    if(cell == nil){
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        cell = [[ExperienceTableViewCell alloc]initExperienceCellWithModel:model];
    }
    cell.contentTextView.userInteractionEnabled = NO;
    [existedHeight addObject:@(cell.sd_height)];
    if (indexPath.section ==[_experienceArray count] -1) {
        CGFloat height = 0;
        for (int i =0; i<[existedHeight count]; i++) {
            height = height +[existedHeight[i] floatValue] +10;
        }
        self.tableviewConstraint.constant = height -10;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section<beforeCount) {
        [cell.rightBtn setImage:[UIImage imageNamed:@"sort_on.pdf"] forState:UIControlStateNormal];
        cell.selected = NO;
        if (jl_ids!=nil) {
            NSArray *jlArray = [jl_ids componentsSeparatedByString:@","];
            for (int i =0; i<[jlArray count]; i++) {
                if ([model.jl_id isEqualToString:jlArray[i]]) {
                    [cell.rightBtn setImage:[UIImage imageNamed:@"sort_off.pdf"] forState:UIControlStateNormal];
                    cell.selected = YES;
                }
            }
        }
        
        
    }
    
    [cell.rightBtn addTarget:self action:@selector(deleteExperience:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    //    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
    //    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    //    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
    //    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    //    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
    //    NSArray *typeArray = [typeDict objectForKey:@"Type"];
    ModelTypeModel *experienceModel = _experienceArray[indexPath.section];
    //    NSInteger index = [experienceModel.type integerValue];
    //    UILabel *typeLabel = (UILabel *)[[self class] initLabelWithTitle:typeArray[index]];
    CGSize textSize = [experienceModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 63 -32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if (textSize.height  < 28) {
        return 84;
    }else
    {
        return textSize.height +84;
    }
    
    
    return 84;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddExperienceViewController *addVC = [[AddExperienceViewController alloc] init];
    addVC.delegate = self;
    ModelTypeModel *experienceModel = _experienceArray[indexPath.section];
    addVC.selected = [experienceModel.type integerValue] -1;
    addVC.typeName = typeArray[[experienceModel.type integerValue]-1];
    addVC.jlDesc = experienceModel.desc;
    addVC.jl_id = experienceModel.jl_id;
    [self.navigationController pushViewController:addVC animated:NO];
    
}
// 实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag ==1001) {
        AddExperienceViewController *addVC = [[AddExperienceViewController alloc] init];
        addVC.delegate = self;
        addVC.selected = buttonIndex -1;
        addVC.typeName = typeArray[buttonIndex -1];
        [self.navigationController pushViewController:addVC animated:NO];
    }else if (actionSheet.tag == 1002)
    {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.delegate = self;
        camera.allowsEditing = NO;
        
        if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else
        {
            camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:camera animated:YES completion:nil];
    }
    
    
}
//AddExperienceViewControllerdelegate
-(void)addSucced
{
//    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self updateInfo];
}
-(void)deleteExperience:(UIButton *)btn
{
    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.experienceTableView indexPathForCell:cell];
    ModelTypeModel *model = self.experienceArray[indexPath.section];
    if (indexPath.section <beforeCount) {
        if (btn.selected ==NO) {
            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor grayColor]];
            [btn setImage:[UIImage imageNamed:@"sort_off.pdf"] forState:UIControlStateNormal];
            if (jl_ids ==nil) {
                jl_ids = [NSString stringWithFormat:@"%@",model.jl_id];
            }else
            {
                jl_ids = [jl_ids stringByAppendingString:[NSString stringWithFormat:@",%@",model.jl_id]];
            }

        }else
        {
            btn.selected = NO;
            [btn setImage:[UIImage imageNamed:@"sort_on.pdf"] forState:UIControlStateNormal];
            NSArray *jlArray = [jl_ids componentsSeparatedByString:@","];
            jl_ids = nil;
            for (int i =0; i<[jlArray count]; i++) {
                if ([model.jl_id isEqualToString:jlArray[i]]) {
                    
                }else
                {
                    if (jl_ids ==nil) {
                        jl_ids = [NSString stringWithFormat:@"%@",jlArray[i]];
                    }else
                    {
                        jl_ids = [jl_ids stringByAppendingString:[NSString stringWithFormat:@",%@",jlArray[i]]];
                    }
                }
            }
        }

    }else
    {
            [RequestCustom delExperienceInfoById:model.jl_id complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        [self.experienceTableView beginUpdates];
                        [self.experienceArray removeObjectAtIndex:[indexPath section]];
                        //                NSArray *_tempIndexPathArr = [NSArray arrayWithObject:indexPath];
                        NSIndexSet *index = [NSIndexSet indexSetWithIndex:[indexPath section]];
                        [self.experienceTableView deleteSections:index withRowAnimation:UITableViewRowAnimationFade];
//                        self.experienceTableView.sd_height = self.experienceTableView.sd_height - [existedHeight[indexPath.section]floatValue];
                        
                        //                [self.tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationNone];
                        [self.experienceTableView endUpdates];
                        self.tableviewConstraint.constant = self.tableviewConstraint.constant -[existedHeight[indexPath.section]floatValue];
                    }
                }
                
            }];
    }
    
//    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[[btn superview] superview];
//    NSIndexPath *indexPath = [self.experienceTableView indexPathForCell:cell];
//    ModelTypeModel *model = self.experienceArray[indexPath.section];

    
}
-(void)addTypeBtnClicked
{
    
    
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:typeArray[0], typeArray[1], typeArray[2],typeArray[3],typeArray[4],typeArray[5],typeArray[6], nil];
    sheet.tag = 1001;
    [sheet show];
}

-(void)requestInfo
{
    NSString *userId;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userId = [userDefaults objectForKey:@"user_id"];
    
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
                self.experienceTableView.scrollEnabled = NO;
                if ([_experienceArray count]==0) {
                    self.tableviewConstraint.constant = 0;
                }else
                {//区分是否新添加的
                    beforeCount =[_experienceArray count];
                    self.tableviewConstraint.constant = 90 *[_experienceArray count] +15;
                }
//                [self setUpView];
//                [self initConstraint];
                [self initGes];
                
                [self.experienceTableView reloadData];
                

            }
        }
        
    }];
}
-(void)updateInfo
{
    NSString *userId;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userId = [userDefaults objectForKey:@"user_id"];
    
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                [_experienceArray removeAllObjects];
                [existedHeight removeAllObjects];
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
                if ([_experienceArray count]==0) {
                    self.tableviewConstraint.constant = 0;
                }else
                {
                    self.tableviewConstraint.constant = 90 *[_experienceArray count] +15;
                }
                //                [self setUpView];
//                [self initConstraint];
//                [self initGes];
                
                [self.experienceTableView reloadData];
//                CGFloat height = 0;
//                for (int i =0; i<[existedHeight count]; i++) {
//                    height = height +[existedHeight[i] floatValue] +10;
//                }
//                self.tableviewConstraint.constant = height ;
            }
        }
        
    }];

}
@end
