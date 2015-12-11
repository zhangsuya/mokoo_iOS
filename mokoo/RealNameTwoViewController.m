//
//  RealNameTwoViewController.m
//  mokoo
//
//  Created by Mac on 15/10/30.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "RealNameTwoViewController.h"
#import "MokooMacro.h"
#import "DemoTextField.h"
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
#import "PersonalCenterViewController.h"
@interface RealNameTwoViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate,UITextFieldDelegate>
{
    DemoTextField *nameTF;
    DemoTextField *numberTF;
    DemoTextField *tmpTF;
    CGSize keyboardSize;
    UIScrollView *_contentView;
    UIImageView *sfzImageView;
    UIImageView *faceToImageView;
}
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,strong)MLSelectPhotoPickerViewController *pickerVc;
@property (nonatomic,strong)UIImageView *tmpView;
@property (nonatomic,strong)NSMutableArray *imgArray;
@end

@implementation RealNameTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];

    _imgArray = [NSMutableArray array];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];

    [self setUpNavigationItem];

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
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight )];
    [self.view addSubview:_contentView];
    //137.5,211
    UILabel *sfzLabel = [[UILabel alloc] init];
    sfzLabel.text = @"*根据以下照片提示，上传相关照片完成实名认证";
    [sfzLabel setFont:[UIFont systemFontOfSize:14]];
    sfzLabel.frame = CGRectMake(15, 15 , kDeviceWidth -15, 15);
    faceToImageView = [[UIImageView alloc]init];
    faceToImageView.frame = CGRectMake(15, 45, (kDeviceWidth -45)/2, kDeviceHeight*0.37);
    faceToImageView.image= [UIImage imageNamed:@"zp"];
    faceToImageView.userInteractionEnabled = YES;
    faceToImageView.contentMode = UIViewContentModeScaleAspectFill;
    faceToImageView.clipsToBounds = YES;
    UITapGestureRecognizer *faceGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddPhotoClick:)];
    [faceToImageView addGestureRecognizer:faceGes];
    sfzImageView = [[UIImageView alloc]init];
    sfzImageView.frame = CGRectMake(kDeviceWidth/2 +7.5, 45, (kDeviceWidth -45)/2, kDeviceHeight*0.37);
    sfzImageView.image = [UIImage imageNamed:@"sfz"];
    sfzImageView.userInteractionEnabled = YES;
    sfzImageView.clipsToBounds = YES;
    sfzImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *sfzGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddPhotoClick:)];
    [sfzImageView addGestureRecognizer:sfzGes];
    
    UILabel *topNoticelabel = [[UILabel alloc]init];
    NSString *topNotice = [NSString stringWithFormat:@"通过实名认证可获得专属“V”标识，更值得信任同时获得更多权限"];
    [topNoticelabel setFont:[UIFont systemFontOfSize:14]];
    topNoticelabel.lineBreakMode = NSLineBreakByCharWrapping;
    topNoticelabel.numberOfLines = 0;
    //以上两行代码保证文本多行显示
    CGSize textSize = [topNotice boundingRectWithSize:CGSizeMake(kDeviceWidth -32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    topNoticelabel.text = topNotice;
    topNoticelabel.frame = CGRectMake(16, 45+kDeviceHeight*0.37  +22, kDeviceWidth - 32, textSize.height);
    _height = textSize.height +45+kDeviceHeight*0.37+35 ;
    nameTF =[[DemoTextField alloc] initWithFrame:CGRectMake(16, _height, kDeviceWidth -32, 42)];
//    nameTF.background = [UIImage imageNamed:@"box_m.pdf"];
    nameTF.placeholder = @"身份证名字";
    nameTF.delegate = self;
    nameTF.backgroundColor = [UIColor clearColor];
    _height = _height +52;
    numberTF =[[DemoTextField alloc] initWithFrame:CGRectMake(16, _height, kDeviceWidth -32, 42)];
    numberTF.placeholder = @"身份证号码";
    numberTF.keyboardType = UIKeyboardTypePhonePad;
    numberTF.delegate = self;
    _height = _height +42 +21;
    numberTF.backgroundColor = [UIColor clearColor];
//    numberTF.background = [UIImage imageNamed:@"box_m.pdf"];
    

    
    UIButton *submitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitTypeBtn.frame = CGRectMake(16, _height, kDeviceWidth -32, 42);
    [submitTypeBtn setBackgroundColor:[UIColor blackColor]];
    [submitTypeBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    submitTypeBtn.layer.masksToBounds = YES;
    submitTypeBtn.layer.cornerRadius = 3;
    [submitTypeBtn addTarget:self action:@selector(submitTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:sfzLabel];
    [_contentView addSubview:faceToImageView];
    [_contentView addSubview:sfzImageView];

    [_contentView addSubview:topNoticelabel];
    [_contentView addSubview:nameTF];
    [_contentView addSubview:numberTF];
//    [self.view addSubview:faceLabel];
//    [self.view addSubview:exampleLabel];
//    [self.view addSubview:faceImageView];
//    [self.view addSubview:faceImageView];
//    [self.view addSubview:exampleView];
//    [self.view addSubview:handleCardFaceLabel];
//    [self.view addSubview:handleCardFaceExampleLabel];
//    [self.view addSubview:handleCardFaceImageView];
//    [self.view addSubview:handleCardFaceExampleView];
    [_contentView addSubview:submitTypeBtn];
    
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
    if (sfzImageView.image ==nil) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请上传身份证照片";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }else
    {
        [_imgArray addObject:sfzImageView.image];
    }
    if (faceToImageView.image ==nil) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请上传正面照照片";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }else
    {
        [_imgArray addObject:faceToImageView.image];
    }
    [RequestCustom addRealNameAut:nameTF.text number:numberTF.text images:_imgArray complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"上传成功！" message:@"您的资料已提交审核" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag = 10001;
                [alertView show];
//                [self.navigationController popViewControllerAnimated:NO];
            }
        }
    }];
}
//textFieldDelegate
//textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    
    
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        tmpTF = (DemoTextField *)textField;
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
    if (numberTF == textField)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"只能输入18个数字";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }else if (nameTF == textField)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"只能输入18个字符";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }

}
-(void) keyboardDidShow:(NSNotification *) notification
{
    //    if (_textField == nil) return;
    //    if (keyboardIsShown) return;
    //    if (![_textField isKindOfClass:[MHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    //    [self scrollToField];
    
    //    self.keyboardIsShown = YES;
    
}
-(void) keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (_contentView.contentOffset.y >-64) {
            [_contentView setContentOffset:CGPointMake(0, -64) animated:NO];
        }
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
- (void)scrollToField
{
    CGRect textFieldRect = tmpTF.frame;
    
    CGRect aRect = _contentView.bounds;
    
    aRect.origin.y = -_contentView.contentOffset.y;
    aRect.size.height -= keyboardSize.height  + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || _contentView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0,  tmpTF.frame.origin.y + tmpTF.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [_contentView setContentOffset:scrollPoint animated:YES];
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
                weakSelf.pickerVc = nil;
                if (assets.count ==0) {
                    return ;
                }
                //                ShowSendViewController *sendVC = [[ShowSendViewController alloc]initWithNibName:@"ShowSendViewController" bundle:nil];
                //                weakSelf.selectArray = assets;
                //                [weakSelf initSelectedImageArray];
                //                [weakSelf setUpPhotoView];
                MLSelectPhotoAssets *tempAlAsset = (MLSelectPhotoAssets *)assets[0];
//                UIImage *img = [MLSelectPhotoPickerViewController getImageWithImageObj:tempAlAsset];
                UIImage *OriImg = [MLSelectPhotoPickerViewController getOriginImageWithImageObj:tempAlAsset];
                weakSelf.tmpView.image = OriImg;
                
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 10001) {
        if (buttonIndex == 0) {
            if ([_delegate respondsToSelector:@selector(realNameTwoViewControllerReturnRefrensh)]) {
                [_delegate realNameTwoViewControllerReturnRefrensh];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}

@end
