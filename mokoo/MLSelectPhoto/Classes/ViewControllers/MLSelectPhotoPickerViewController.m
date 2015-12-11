//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  PickerViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoNavigationViewController.h"
#import "MLSelectPhotoPickerGroupViewController.h"
#import "MLSelectPhotoCommon.h"
#import "MLSelectPhotoAssets.h"
#import "ShowSendViewController.h"
@interface MLSelectPhotoPickerViewController ()
@property (nonatomic , weak) MLSelectPhotoPickerGroupViewController *groupVc;
@end

@implementation MLSelectPhotoPickerViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - init Action
- (void) createNavigationController{
    MLSelectPhotoPickerGroupViewController *groupVc = [[MLSelectPhotoPickerGroupViewController alloc] init];
    MLSelectPhotoNavigationViewController *nav = [[MLSelectPhotoNavigationViewController alloc] initWithRootViewController:groupVc];
    nav.view.frame = self.view.bounds;
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    self.groupVc = groupVc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self createNavigationController];
    }
    return self;
}

- (void)setSelectPickers:(NSArray *)selectPickers{
    _selectPickers = selectPickers;
    self.groupVc.selectAsstes = selectPickers;
}

- (void)setStatus:(PickerViewShowStatus)status{
    _status = status;
    self.groupVc.status = status;
}

- (void)setMinCount:(NSInteger)minCount{
    if (minCount <= 0) return;
    _minCount = minCount;
    self.groupVc.minCount = minCount;
}

#pragma mark - 展示控制器
- (void)showPickerVc:(UIViewController *)vc{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    __weak typeof(vc)weakVc = vc;
    if (weakVc != nil) {
        [weakVc presentViewController:self animated:YES completion:nil];
    }
}


- (void) addNotification{
    // 监听异步done通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:PICKER_TAKE_DONE object:nil];
    });
}

- (void) done:(NSNotification *)note{
    NSArray *selectArray =  note.userInfo[@"selectAssets"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
            [self.delegate pickerViewControllerDoneAsstes:selectArray];
        }else if (self.callBack){
            self.callBack(selectArray);
        }
        ShowSendViewController *sendVC = [[ShowSendViewController alloc]initWithNibName:@"ShowSendViewController" bundle:nil];
        sendVC.selectArray = selectArray;
//        [self dismissViewControllerAnimated:YES completion:nil];

        [self.navigationController pushViewController:sendVC animated:YES];
//        [self presentViewController:sendVC animated:YES completion:nil];
        
    });
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker{
    _topShowPhotoPicker = topShowPhotoPicker;
    self.groupVc.topShowPhotoPicker = topShowPhotoPicker;
}

- (void)setDelegate:(id<ZLPhotoPickerViewControllerDelegate>)delegate{
    _delegate = delegate;
    self.groupVc.delegate = delegate;
}

#pragma mark - 通过传入一个图片对象（MLSelectPhotoAssets/ALAsset）获取一张缩略图
+ (UIImage *)getImageWithImageObj:(id)imageObj{
    __block UIImage *image = nil;
    if ([imageObj isKindOfClass:[UIImage class]]) {
        return imageObj;
    }else if ([imageObj isKindOfClass:[ALAsset class]]){
        @autoreleasepool {
            ALAsset *asset = (ALAsset *)imageObj;
            

            return [UIImage imageWithCGImage:[asset thumbnail]];
        }
    }else if ([imageObj isKindOfClass:[MLSelectPhotoAssets class]]){
        return [imageObj thumbImage];
    }
    return image;
}
#pragma mark - 通过传入一个图片对象（MLSelectPhotoAssets/ALAsset）获取一张原图

+ (UIImage *)getOriginImageWithImageObj:(id)imageObj{
    __block UIImage *image = nil;
    if ([imageObj isKindOfClass:[UIImage class]]) {
        return imageObj;
    }else if ([imageObj isKindOfClass:[ALAsset class]]){
        @autoreleasepool {
            ALAsset *asset = (ALAsset *)imageObj;
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            //
            //
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
            
            return img;
        }
    }else if ([imageObj isKindOfClass:[MLSelectPhotoAssets class]]){
        return [imageObj originImage];
    }
    return image;
}

//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        //开始绘图生成水印图片
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        //结束绘图
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
