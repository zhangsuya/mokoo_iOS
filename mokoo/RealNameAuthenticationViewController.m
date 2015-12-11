//
//  RealNameAuthenticationViewController.m
//  mokoo
//
//  Created by Mac on 15/10/10.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"
#import "MokooMacro.h"
#import "CustomTextField.h"
#import "RequestCustom.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLPhotoBrowserAssets.h"
#import "MLPhotoBrowserViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MBProgressHUD.h"
#import "UIButton+EnlargeTouchArea.h"
@interface RealNameAuthenticationViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate,UITextFieldDelegate>
{
    CustomTextField *nameTF;
    CustomTextField *numberTF;
}
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,strong)MLSelectPhotoPickerViewController *pickerVc;
@property (nonatomic,strong)UIImageView *tmpView;
@property (nonatomic,strong)NSMutableArray *imgArray;
@end

@implementation RealNameAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgArray = [NSMutableArray array];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    [self setUpNavigationItem];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)keyBoardHidden
{
    [nameTF resignFirstResponder];
    [numberTF resignFirstResponder];
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"实名认证"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)initView
{
    UILabel *topNoticelabel = [[UILabel alloc]init];
    NSString *topNotice = [NSString stringWithFormat:@"通过实名认证可获得专属“V”标识，更值得信任同时获得更多权限"];
    [topNoticelabel setFont:[UIFont systemFontOfSize:14]];
    topNoticelabel.lineBreakMode = NSLineBreakByCharWrapping;
    topNoticelabel.numberOfLines = 0;
    //以上两行代码保证文本多行显示
    CGSize textSize = [topNotice boundingRectWithSize:CGSizeMake(kDeviceWidth -32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    topNoticelabel.text = topNotice;
    topNoticelabel.frame = CGRectMake(16, 16+64, kDeviceWidth - 32, textSize.height);
    _height = textSize.height +32 +64;
    nameTF =[[CustomTextField alloc] initWithFrame:CGRectMake(16, _height, kDeviceWidth -32, 42)];
    nameTF.background = [UIImage imageNamed:@"box_m.pdf"];
    nameTF.placeholder = @"身份证名字";
    nameTF.delegate = self;
    _height = _height +52;
    numberTF =[[CustomTextField alloc] initWithFrame:CGRectMake(16, _height, kDeviceWidth -32, 42)];
    numberTF.placeholder = @"身份证号码";
    numberTF.keyboardType = UIKeyboardTypePhonePad;
    numberTF.delegate = self;
    _height = _height +42 +21;
    numberTF.background = [UIImage imageNamed:@"box_m.pdf"];
    
    UILabel *faceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, _height, kDeviceWidth/2 -16, 15)];
    faceLabel.text = [NSString stringWithFormat:@"身份证正面照"];
    [faceLabel setFont:[UIFont systemFontOfSize:14]];
    UILabel *exampleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2, _height, kDeviceWidth/2 -16, 15)];
    exampleLabel.text = [NSString stringWithFormat:@"示例图片"];
    [exampleLabel setFont:[UIFont systemFontOfSize:14]];
    _height = _height +15 + 15;
    
    UIImageView *faceImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add_pic_l.pdf"]];
    faceImageView.frame = CGRectMake(16, _height, 112, 112);
    faceImageView.layer.masksToBounds = YES;
    faceImageView.layer.cornerRadius = 5;
    faceImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddPhotoClick:)];
    [faceImageView addGestureRecognizer:tap];
    UIImageView *exampleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"case_1"]];
    exampleView.frame = CGRectMake(kDeviceWidth/2 , _height, 112, 112);
    _height = _height +20 +112;
    
    UILabel *handleCardFaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, _height, kDeviceWidth/2 -16, 15)];
    handleCardFaceLabel.text = [NSString stringWithFormat:@"手持身份证正面照"];
    [handleCardFaceLabel setFont:[UIFont systemFontOfSize:14]];
    UILabel *handleCardFaceExampleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2, _height, kDeviceWidth/2 -16, 15)];
    handleCardFaceExampleLabel.text = [NSString stringWithFormat:@"示例图片"];
    [handleCardFaceExampleLabel setFont:[UIFont systemFontOfSize:14]];
    _height = _height +15 +15;
    
    UIImageView *handleCardFaceImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add_pic_l.pdf"]];
    handleCardFaceImageView.layer.masksToBounds = YES;
    handleCardFaceImageView.layer.cornerRadius = 8;
    handleCardFaceImageView.userInteractionEnabled = YES;
    handleCardFaceImageView.frame = CGRectMake(16, _height, 112, 112);
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddPhotoClick:)];
    [handleCardFaceImageView addGestureRecognizer:handleTap];

    UIImageView *handleCardFaceExampleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"case_2"]];
    handleCardFaceExampleView.frame = CGRectMake(kDeviceWidth/2 , _height, 112, 112);
    _height = _height +30 +112;
    
    UIButton *submitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitTypeBtn.frame = CGRectMake(16, _height, kDeviceWidth -32, 42);
    [submitTypeBtn setBackgroundColor:[UIColor blackColor]];
    [submitTypeBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    submitTypeBtn.layer.masksToBounds = YES;
    submitTypeBtn.layer.cornerRadius = 3;
    [submitTypeBtn addTarget:self action:@selector(submitTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topNoticelabel];
    [self.view addSubview:nameTF];
    [self.view addSubview:numberTF];
    [self.view addSubview:faceLabel];
    [self.view addSubview:exampleLabel];
    [self.view addSubview:faceImageView];
    [self.view addSubview:faceImageView];
    [self.view addSubview:exampleView];
    [self.view addSubview:handleCardFaceLabel];
    [self.view addSubview:handleCardFaceExampleLabel];
    [self.view addSubview:handleCardFaceImageView];
    [self.view addSubview:handleCardFaceExampleView];
    [self.view addSubview:submitTypeBtn];

}

-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)submitTypeBtnClicked
{
    if ([nameTF.text length]==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入真实姓名";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    if ([numberTF.text length]!=18) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入18位身份证号";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    [RequestCustom addRealNameAut:nameTF.text number:numberTF.text images:_imgArray complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
    }];
}
//textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    
   
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    tmpTF = (DemoTextField *)textField;
    //    if (tmpTF.isMulChooseView) {
    //        [self keyBoardHide];
    //
    //
    //    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (numberTF == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:17];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入18个数字";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }else if (nameTF == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:17];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入18个字符";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger length= textField.text.length;
    
    if(length>18)
    {
        NSString *memo = [textField.text substringWithRange:NSMakeRange(0, 18)];
        textField.text=memo;
    }
}
#pragma mark camera uitility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    [_selectedImageArray addObject:image];
//    [_selectedOriImageArray addObject:image];
    //    [self performSelectorOnMainThread:@selector(updatePhotoviewOne) withObject:nil waitUntilDone:YES];
    _tmpView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    picker = nil;
//    [self performSelectorOnMainThread:@selector(setUpPhotoView) withObject:nil waitUntilDone:YES];
    
}
#pragma mark - 进入相册浏览器/相机
- (void)AddPhotoClick:(UIGestureRecognizer *)Ges{
    _tmpView = (UIImageView *)Ges.view;
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //    if (_DataAllPic.count != 0) {
    //        [_DataAllPic removeLastObject];
    //    }
        if (buttonIndex == 1) {
        //相册
        if (!_pickerVc ){
            _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
            _pickerVc.minCount = 1;
            //            _pickerVc.selectPickers = _selectArray;
            _pickerVc.status = PickerViewShowStatusCameraRoll;
            //            [self.navigationController pushViewController:_pickerVc animated:YES];
            
            [_pickerVc showPickerVc:self];
            __weak typeof(self) weakSelf = self;
            _pickerVc.callBack = ^(NSArray *assets){
                //                [weakSelf.pickerVc.navigationController popToViewController:self animated:YES];
                [weakSelf.pickerVc dismissViewControllerAnimated:NO completion:nil];
                //                ShowSendViewController *sendVC = [[ShowSendViewController alloc]initWithNibName:@"ShowSendViewController" bundle:nil];
//                weakSelf.selectArray = assets;
//                [weakSelf initSelectedImageArray];
//                [weakSelf setUpPhotoView];
                MLSelectPhotoAssets *tempAlAsset = (MLSelectPhotoAssets *)assets[0];
                UIImage *img = [MLSelectPhotoPickerViewController getImageWithImageObj:tempAlAsset];
                UIImage *OriImg = [MLSelectPhotoPickerViewController getOriginImageWithImageObj:tempAlAsset];
                weakSelf.tmpView.image = img;
                weakSelf.pickerVc = nil;
                //                [weakSelf.navigationController pushViewController:sendVC animated:YES];
                //                [weakSelf.navigationController pushViewController:sendVC animated:YES];
                //                [weakSelf.assets addObjectsFromArray:assets];
                //                [weakSelf.tableView reloadData];
            };
            
            
        }
        // 默认显示相册里面的内容SavePhotos
        // 默认最多能选9张图片
        
        //        [self.navigationController pushViewController:_pickerVc animated:YES];
        //        [self presentViewController:_pickerVc animated:YES completion:nil];
    } else if (buttonIndex == 0) {
        //相机
        [self openCamera];
    }
}
- (void)openCamera {
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType   = UIImagePickerControllerSourceTypeCamera;
        
        if ([self isRearCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        controller.delegate = self;
        //        [self.navigationController pushViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
