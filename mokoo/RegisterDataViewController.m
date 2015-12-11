//
//  RegisterDataViewController.m
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RegisterDataViewController.h"
#import "MokooMacro.h"
#import "RegisterOptionalDataViewController.h"
#import "RequestCustom.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MBProgressHUD.h"
#import "HJCActionSheet.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface RegisterDataViewController ()<UITextFieldDelegate,HJCActionSheetDelegate,VPImageCropperDelegate>
{
    CustomTopBarView *topBar;
    DemoTextField *tmpTF;
    CGSize keyboardSize;
}
@property (nonatomic,copy)NSString *user_img;
@end

@implementation RegisterDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBgColor;
    self.contentScrollView.scrollEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight +90);
//    [self initRequiredField];
    UILabel *cmLabel = [[UILabel alloc]init];
    [cmLabel setTextAlignment:NSTextAlignmentLeft];
    cmLabel.text = @"cm ";
    cmLabel.frame = CGRectMake(0, 0, 33, 42);
    _heightTextField.rightView = cmLabel;
    _heightTextField.rightViewMode =UITextFieldViewModeAlways;
    UILabel *kgLabel = [[UILabel alloc]init];
    [kgLabel setTextAlignment:NSTextAlignmentLeft];
    kgLabel.text = @"kg ";
    kgLabel.frame = CGRectMake(0, 0, 30, 42);
    _weightTextField.rightViewMode = UITextFieldViewModeAlways;
    _weightTextField.rightView = kgLabel;
    _countryTextField.isPickView = YES;
    [_countryTextField setCountryField:YES];
    _destinationTextField.isPickView = YES;
    [_destinationTextField setLocationField:YES];
    _sexTextField.isPickView = YES;
    [_sexTextField setSexField:YES];
    _goodAtStyleTextField.isMulChooseView = YES;
    [_goodAtStyleTextField setStyleField:YES];
    _occupationalTypesTextField.isMulChooseView = YES;
    [_occupationalTypesTextField setTypeField:YES];
    _threeDimensionalTextField.isMulChooseView = YES;
    [_threeDimensionalTextField setThreeTextField:YES];
    [self initTopBar];
    [self initDelegate];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];
    self.headBtnWidth.constant = 66;
    self.leftOfBtn.constant = kDeviceWidth/2 - 32;
    self.petNameWidth.constant = (kDeviceWidth - 32-6)*0.62;
    self.sexWidth.constant = (kDeviceWidth - 32-6)*0.38;
    self.heightWidth.constant = (kDeviceWidth - 32 -6)/2;
    self.threeWidth.constant = (kDeviceWidth - 32 -6)/2;
    self.weightWidth.constant = (kDeviceWidth - 32 -6)/2;
    self.shoesSizeWidth.constant = (kDeviceWidth - 32 -6)/2;
    self.goodAtStyleWidth.constant = kDeviceWidth - 32;
    self.occupationalTypeWidth.constant = kDeviceWidth - 32;
    self.countryWidth.constant = kDeviceWidth - 32;
    self.destinationWidth.constant = kDeviceWidth -32;
    self.submitBtnWidth.constant = kDeviceWidth - 32;
    
    self.headBtn.autoresizingMask = UIViewAutoresizingNone;
    self.headBtn.layer.masksToBounds = YES;
    self.headBtn.layer.cornerRadius = self.headBtn.frame.size.width/2;
    self.headBtn.layer.borderWidth = 1.5;
    self.headBtn.layer.borderColor = [whiteFontColor CGColor];
// Do any additional setup after loading the view from its nib.
}
-(void)dealloc
{
    _petNameTextField.delegate = nil;
    _sexTextField.delegate = nil;
    _heightTextField.delegate = nil;
    _weightTextField.delegate = nil;
    _threeDimensionalTextField.delegate = nil;
    _shoesSizeTextField.delegate = nil;
    _goodAtStyleTextField.delegate = nil;
    _occupationalTypesTextField.delegate = nil;
    _countryTextField.delegate = nil;
    _destinationTextField.delegate = nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"填写资料(必填)"];

    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
-(void)initRequiredField
{
    _petNameTextField.required = YES;
    _sexTextField.required = YES;
    _heightTextField.required = YES;
    _weightTextField.required = YES;
    _threeDimensionalTextField.required = YES;
    _shoesSizeTextField.required = YES;
    _goodAtStyleTextField.required = YES;
    _occupationalTypesTextField.required = YES;
    _countryTextField.required = YES;
    _destinationTextField.required = YES;
}
-(void)initDelegate
{
    _petNameTextField.delegate = self;
    _sexTextField.delegate = self;
    _heightTextField.delegate = self;
    _weightTextField.delegate = self;
    _threeDimensionalTextField.delegate = self;
    _shoesSizeTextField.delegate = self;
    _goodAtStyleTextField.delegate = self;
    _occupationalTypesTextField.delegate = self;
    _countryTextField.delegate = self;
    _destinationTextField.delegate = self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    tmpTF = (DemoTextField *)textField;
    if (tmpTF.isMulChooseView) {

        [self keyBoardHide];

        
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

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
    
    if (self.heightTextField == textField||self.weightTextField == textField)
    {
        if ([toBeString length] > 3) {
            textField.text = [toBeString substringToIndex:2];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入3位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }else if(self.shoesSizeTextField == textField)
    {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:1];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入2位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //取消第一响应者，就是结束输入病隐藏键盘
    [tmpTF resignFirstResponder];
    return YES;
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    [self.view addSubview:HUD];
    //    HUD.removeFromSuperViewOnHide = YES;
    ////    HUD.delegate = self;
    //    HUD.labelText = @"Loading";
    //    [self startAnimation];
    [self.view addSubview:HUD];
    
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
    [RequestCustom addHeadImage:editedImage complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.headBtn setImage:editedImage forState:UIControlStateNormal];
                    [HUD hide:YES];
                });
                NSDictionary *dataDict = [obj objectForKey:@"data"];
                
                _user_img = [dataDict objectForKey:@"user_img"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

                [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
            }
        }
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
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

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < kDeviceWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = kDeviceWidth;
        btWidth = sourceImage.size.width * (kDeviceWidth / sourceImage.size.height);
    } else {
        btWidth = kDeviceWidth;
        btHeight = sourceImage.size.height * (kDeviceWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
        {
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }

        }
            break;
        case 2:
        {
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }            // 创建控制器
            // 默认显示相册里面的内容SavePhotos
            // 默认最多能选9张图片
            
            
        }
            break;
        
    }
}

- (void) backBtnClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)keyBoardHide
{
    //这样写确实很low
    [_petNameTextField resignFirstResponder];
    [_sexTextField resignFirstResponder];
    [_heightTextField resignFirstResponder];
    [_weightTextField resignFirstResponder];
    [_threeDimensionalTextField resignFirstResponder];
    [_shoesSizeTextField resignFirstResponder];
    [_goodAtStyleTextField resignFirstResponder];
    [_occupationalTypesTextField resignFirstResponder];
    [_countryTextField resignFirstResponder];
    [_destinationTextField resignFirstResponder];

}




-(void) keyboardDidShow:(NSNotification *) notification
{
    //    if (_textField == nil) return;
    //    if (keyboardIsShown) return;
    //    if (![_textField isKindOfClass:[MHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];
    
    //    self.keyboardIsShown = YES;
    
}
-(void) keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
            [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
- (void)scrollToField
{
    
    CGRect textFieldRect = tmpTF.frame;
    
    CGRect aRect = self.contentScrollView.bounds;
    
    aRect.origin.y = -self.contentScrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height  + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || self.contentScrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0,  tmpTF.frame.origin.y + tmpTF.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
}
- (IBAction)headBtnClicked:(UIButton *)sender {
    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", @"视频", nil];
    // 2.显示出来
    [sheet show];
}
- (IBAction)nextBtnClicked:(UIButton *)sender {

    if ([_petNameTextField.text isEqualToString:@""] ||[_sexTextField.text isEqualToString:@""] || [_heightTextField.text isEqualToString:@""] || [_weightTextField.text isEqualToString:@""] || [_threeDimensionalTextField.text isEqualToString:@""] || [_shoesSizeTextField.text isEqualToString:@""] || [_goodAtStyleTextField.text isEqualToString:@""] || [_occupationalTypesTextField.text isEqualToString:@""] || [_countryTextField.text isEqualToString:@""] || [_destinationTextField.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请把资料填写完整";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;

    }else if ([_heightTextField.text integerValue]<50||[_heightTextField.text integerValue]>300)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"身高范围值为50-300cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;

    }else if ([_weightTextField.text integerValue]<10||[_weightTextField.text integerValue]>300)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"体重范围值为10-300kg";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    else if ([_shoesSizeTextField.text integerValue]<20||[_shoesSizeTextField.text integerValue]>50)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"鞋码范围值为20-50";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    else
    {
        NSDictionary *dict;
        if (_user_img) {
           dict = [[NSDictionary alloc]initWithObjectsAndKeys:_userID,@"user_id",_user_img,@"user_img",_petNameTextField.text,@"nick_name",[NSString stringWithFormat:@"%@",@(_sexTextField.selectedItem)],@"sex",_heightTextField.text,@"height",_weightTextField.text,@"weight",_threeDimensionalTextField.text,@"three_size",_shoesSizeTextField.text,@"shoe_size",_goodAtStyleTextField.mulSelectedItem,@"style",_occupationalTypesTextField.mulSelectedItem,@"work_type",[NSString stringWithFormat:@"%@",@(_countryTextField.selectedItem)],@"country",[NSString stringWithFormat:@"%@",@(_destinationTextField.selectedItem)],@"address", nil];
        }else
        {
            dict = [[NSDictionary alloc]initWithObjectsAndKeys:_userID,@"user_id",_petNameTextField.text,@"nick_name",[NSString stringWithFormat:@"%@",@(_sexTextField.selectedItem)],@"sex",_heightTextField.text,@"height",_weightTextField.text,@"weight",_threeDimensionalTextField.text,@"three_size",_shoesSizeTextField.text,@"shoe_size",_goodAtStyleTextField.mulSelectedItem,@"style",_occupationalTypesTextField.mulSelectedItem,@"work_type",[NSString stringWithFormat:@"%@",@(_countryTextField.selectedItem)],@"country",[NSString stringWithFormat:@"%@",@(_destinationTextField.selectedItem)],@"address", nil];
        }
        
        ModelInfo *info = [ModelInfo initModelInfoWithDict:dict];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:info.nick_name forKey:@"nick_name"];
        RegisterOptionalDataViewController *optionalViewController = [[RegisterOptionalDataViewController alloc]initWithNibName:@"RegisterOptionalDataViewController" bundle:nil];
//        RegisterOptionalDataViewController *optionalViewController = [[RegisterOptionalDataViewController alloc]init];
        optionalViewController.modelInfo = info;
        if (_isPersonal) {
            optionalViewController.isPersonal = _isPersonal;

        }
        [self presentViewController:optionalViewController animated:YES completion:nil];

    }
    }
@end
