//
//  ShowSendViewController.m
//  mokoo
//
//  Created by Mac on 15/9/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowSendViewController.h"
#import "MokooMacro.h"
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
@interface ShowSendViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>
@property (nonatomic,strong)NSMutableArray *selectedImageArray;
@property (nonatomic,strong)NSMutableArray *selectedAssetArray;
@property (nonatomic,strong)NSMutableArray *selectedOriImageArray;
@property (nonatomic,strong)MLSelectPhotoPickerViewController *pickerVc;
@end

@implementation ShowSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedImageArray = [NSMutableArray array];
    _selectedOriImageArray = [NSMutableArray array];
    _selectedAssetArray = [_selectArray mutableCopy];
    _commentTextView.delegate = self;
    _textViewConstraint.constant = kDeviceWidth -16;
    _textViewLeftConstraint.constant = 8;
    _placeholderLeftConstraint.constant = 8;
    _scrollViewTopConstraint.constant = 8;
    _placehoderTopConstraint.constant =5;
    [self setUpNavigationItem];
    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewHeightConstant.constant = 0;
    self.imageViewWeightConstant.constant = kDeviceWidth - 16;
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];
    [self initSelectedImageArray];
    [self setUpPhotoView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@""];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"close.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    [self.rightBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    self.rightBtn.userInteractionEnabled = NO;
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)initSelectedImageArray
{

    for (NSInteger i = 0; i < _selectArray.count;i++) {
        MLSelectPhotoAssets *tempAlAsset = (MLSelectPhotoAssets *)_selectArray[i];
        UIImage *img = [MLSelectPhotoPickerViewController getImageWithImageObj:tempAlAsset];
        UIImage *OriImg = [MLSelectPhotoPickerViewController getOriginImageWithImageObj:tempAlAsset];
        [_selectedOriImageArray addObject:OriImg];
        [_selectedImageArray addObject:img];
    }
    if (_cameraImage) {
        [_selectedImageArray addObject:_cameraImage];
        [_selectedOriImageArray addObject:_cameraImage];
    }
}
-(void)setUpPhotoView
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) ];
    if ([_selectedImageArray containsObject:[UIImage imageNamed:@"add_pic_s.pdf"]]) {
        
    }else
    {
        [_selectedImageArray addObject:[UIImage imageNamed:@"add_pic_s.pdf"]];

    }

    if (_selectedImageArray.count <=4) {
        self.imageViewHeightConstant.constant = 80;
    }else if (_selectedImageArray.count >4 &&_selectedImageArray.count<=7)
    {
        self.imageViewHeightConstant.constant = 153;
    }else if (_selectedImageArray.count>7 )
    {
        self.imageViewHeightConstant.constant = 226;
    }

    for(NSInteger i=0;i<_selectedImageArray.count  ;i++){
        
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
//        imageView1.backgroundColor = [UIColor blueColor];
        [imageView1 setImage:_selectedImageArray[i]];
        imageView1.tag = i;
        imageView1.translatesAutoresizingMaskIntoConstraints = NO;
        [self.photoView addSubview:imageView1];
//        [self.imageViewArray addObject:imageView1];
        NSInteger j = (i)%4;
        if (_selectedImageArray.count !=0) {
            [self.photoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpacing-[imageView1(==65)]-rightSpacing-|" options:0 metrics:@{@"leftSpacing":@(j*74),@"rightSpacing":@(kDeviceWidth-j*74-65 -16)} views:NSDictionaryOfVariableBindings(imageView1)]];
            
        }
        
        if (i <=3) {
            
            [self.photoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpacing-[imageView1(==65)]-bottomSpacing-|" options:0 metrics:@{@"topSpacing":@7,@"bottomSpacing":@(self.imageViewHeightConstant.constant -72)} views:NSDictionaryOfVariableBindings(imageView1)]];
        }else if (i >3 &&i<=7)
        {
            [self.photoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpacing-[imageView1(==65)]-bottomSpacing-|" options:0 metrics:@{@"topSpacing":@80,@"bottomSpacing":@(self.imageViewHeightConstant.constant -145)} views:NSDictionaryOfVariableBindings(imageView1)]];
        }else if (i>7 )
        {
            [self.photoView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpacing-[imageView1(==65)]-bottomSpacing-|" options:0 metrics:@{@"topSpacing":@153,@"bottomSpacing":@(self.imageViewHeightConstant.constant -218)} views:NSDictionaryOfVariableBindings(imageView1)]];
        }
        
        if (i == _selectedImageArray.count - 1) {
            imageView1.userInteractionEnabled  = YES;
            UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddPhotoClick)];
            [imageView1 addGestureRecognizer:tap];
        } else {//其他照片浏览器
            imageView1.userInteractionEnabled  = YES;
            UITapGestureRecognizer *tapToBrowser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToBrowser:)];
            [imageView1 addGestureRecognizer:tapToBrowser];
        }
    }

    
    //显示图片
    [_selectedImageArray removeLastObject];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    _placeholderLabel.hidden = YES;
//    _commentTextView.selectedRange = NSMakeRange(-6,0);
//    [_placeholderLabel removeConstraints:_placeholderLabel.constraints];
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
        self.rightBtn.userInteractionEnabled = NO;
        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    //    textview 改变字体的行间距
    
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //
    //    paragraphStyle.lineSpacing = 3;// 字体的行间距
    //
    //    NSDictionary *attributes = @{
    //
    //                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
    //
    //                                 NSParagraphStyleAttributeName:paragraphStyle
    //
    //                                 };
    //
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (![textView.text isEqualToString:@""])
    {
        
        _placeholderLabel.hidden = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        
    }
    
    if ([textView.text isEqualToString:@""])
    {
        
//        _placeholderLabel.hidden = NO;
        self.rightBtn.userInteractionEnabled = NO;
        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
        
    }
    return YES;
    
}
//- (void)textViewDidChangeSelection:(UITextView *)textView
//
//{
//    
//    NSRange range;
//    
//    range.location = 0;
//    
//    range.length = 320;
//    
//    textView.selectedRange = range;
//    
//}
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
    [_selectedImageArray addObject:image];
    [_selectedOriImageArray addObject:image];
    //    [self performSelectorOnMainThread:@selector(updatePhotoviewOne) withObject:nil waitUntilDone:YES];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    picker = nil;
    [self performSelectorOnMainThread:@selector(setUpPhotoView) withObject:nil waitUntilDone:YES];
    
}
//-(void)startAnimation
//{
////    NSInteger angle =0;
//    CGAffineTransform endAngle = CGAffineTransformMakeRotation(1.0 * (M_PI / 180.0f));
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uploading"]];
//    imageView.frame = CGRectMake(0, 0, 56, 56);
//    imageView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
//    [self.view addSubview:imageView];
//    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        imageView.transform = endAngle;
//    } completion:^(BOOL finished) {
////        endAngle += 10;
//        [self startAnimation];
//    }];
//}
- (void)sendBtnClicked:(UIButton *)btn
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.view addSubview:HUD];
//    HUD.removeFromSuperViewOnHide = YES;
////    HUD.delegate = self;
//    HUD.labelText = @"Loading";
//    [self startAnimation];
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
//    [HUD hide:YES afterDelay:3];
    
    
    
    
//    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//    [_selectedImageArray removeLastObject];
//    [RequestCustom addShowByTitle:_commentTextView.text images:_selectedOriImageArray complete:^(BOOL succed, id obj) {
//        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//        if ([status isEqual:@"1"]) {
//            [HUD hide:YES afterDelay:0];
//            if ([_delegate respondsToSelector:@selector(showSendRefrensh)]) {
//                [_delegate showSendRefrensh];
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//    
}
- (void)backBtnClicked :(UIButton *)btn
{
    if (_commentTextView.text ==nil) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消编辑" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1001;
        [myAlertView show];
        
    }
    
}
- (void)keyBoardHide:(UITapGestureRecognizer*)tap
{
    [_commentTextView resignFirstResponder];
}
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex ==1)
        {
            
        }
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
#pragma mark - 进入相册浏览器/相机
- (void)AddPhotoClick{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //    if (_DataAllPic.count != 0) {
    //        [_DataAllPic removeLastObject];
    //    }
    if ([_selectedImageArray count] ==9) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您已选择9张图片";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

        return;
    }
    if (buttonIndex == 1) {
        //相册
        if (!_pickerVc ){
            _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
            _pickerVc.minCount = 9 - [_selectedImageArray count];
            //            _pickerVc.selectPickers = _selectArray;
            _pickerVc.status = PickerViewShowStatusCameraRoll;
            //            [self.navigationController pushViewController:_pickerVc animated:YES];
            
            [_pickerVc showPickerVc:self];
            __weak typeof(self) weakSelf = self;
            _pickerVc.callBack = ^(NSArray *assets){
                //                [weakSelf.pickerVc.navigationController popToViewController:self animated:YES];
                [weakSelf.pickerVc dismissViewControllerAnimated:NO completion:nil];
                //                ShowSendViewController *sendVC = [[ShowSendViewController alloc]initWithNibName:@"ShowSendViewController" bundle:nil];
                weakSelf.selectArray = assets;
                [weakSelf initSelectedImageArray];
                [weakSelf setUpPhotoView];
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
-(void)ToBrowser:(UITapGestureRecognizer *)tap
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tap.view.tag inSection:0];
    //图片浏览器
    MLPhotoBrowserViewController    *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
    // 缩放动画
    //    photoBrowser.status = UIViewAnimationAnimationStatusNotAnimation;
    //    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
    photoBrowser.status = UIViewAnimationAnimationStatusFade;
    
    // 可以删除
    photoBrowser.editing = YES;
    // 数据源/delegate
    photoBrowser.delegate = self;
    photoBrowser.dataSource = self;
    // 当前选中的值
    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    [photoBrowser show];
    // 展示控制器
//    [self.navigationController pushViewController:photoBrowser animated:YES];
//    [photoBrowser showPickerVc:self];
//    [self.navigationController.visibleViewController presentViewController:photoBrowser animated:YES completion:nil];
}
#pragma mark - <MLPhotoBrowserViewControllerDataSource>
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section {
    return _selectedOriImageArray.count;
}
//每组展示
- (MLPhotoBrowserPhoto *)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser photoAtIndexPath:(NSIndexPath *)indexPath {
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    MLPhotoBrowserPhoto *photo = [[MLPhotoBrowserPhoto alloc] init];
    photo.photoObj = [_selectedOriImageArray objectAtIndex:indexPath.row];
    //缩略图
    UIImageView *imagview = (UIImageView *)[_photoView viewWithTag:indexPath.row];
    photo.toView    = imagview;
    //    photo.thumbImage    = imagview.image;
    photo.thumbImage    = photo.photoObj;
    return photo;
}

#pragma mark - <MLPhotoBrowserViewControllerDelegate>
- (void)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    
    [_selectedImageArray removeObjectAtIndex:indexPath.row];
    [_selectedOriImageArray removeObjectAtIndex:indexPath.row];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePhoto" object:_selectedImageArray[indexPath.row]];
    
    [self setUpPhotoView];
}

@end