//
//  GuidePageViewController.m
//  mokoo
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "GuidePageViewController.h"
#import "MokooMacro.h"
@interface GuidePageViewController ()<UIScrollViewDelegate>
{
    UIPageControl *_pageCtrl;
    int _lastCount;
    BOOL _isFirst;//判断scrollView是否滚到底
}
@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lastCount = 0;
    _isFirst = YES;
    
    //初始化UI
    [self initUI];
    // Do any additional setup after loading the view.
}
- (void)initUI
{
    [self createBgScrollView];
}

- (void)createBgScrollView
{
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    for (int i=0; i<4; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(i * kDeviceWidth
, 0, kDeviceWidth
, kDeviceHeight);
        bgView.tag = i;
        switch (i) {
            case 0:{//引导页第一页
                UIImageView *imageV2 = [[UIImageView alloc] init];
                UIImage *image2 = [UIImage imageNamed:@"1"];
                imageV2.frame = CGRectMake((kDeviceWidth
 - image2.size.width) / 2, kDeviceHeight - image2.size.height, image2.size.width, image2.size.height);
                imageV2.image = image2;
                imageV2.tag = 2000;
                [bgView addSubview:imageV2];
                UIImageView *imageV1 = [[UIImageView alloc] init];
                
                UIImage *image1 = [UIImage imageNamed:@"1_zi"];
                imageV1.frame = CGRectMake(kDeviceWidth
, kDeviceHeight/2 - 150/2,kDeviceWidth
- image1.size.width, image1.size.height);
                imageV1.tag = 1000;
                imageV1.image = image1;
                [bgView addSubview:imageV1];

                
                [UIView animateWithDuration:1.0 animations:^{
                    imageV1.frame = CGRectMake(0, kDeviceHeight/2 - 150/2, image1.size.width, image1.size.height);

                }];
                

                bgView.backgroundColor = [UIColor redColor];
//                bgView.backgroundColor = [UIColor colorWithHexString:@"#da025e"];
                
                break;
            }
            case 1:{//引导页第二页
                
                
                UIImageView *imageV2 = [[UIImageView alloc] init];
                UIImage *image2 = [UIImage imageNamed:@"2"];
                imageV2.frame = CGRectMake((kDeviceWidth
 - image2.size.width) / 2, kDeviceHeight - image2.size.height, image2.size.width, image2.size.height);
                imageV2.image = image2;
                [bgView addSubview:imageV2];
                
//                bgView.backgroundColor = [UIColor colorWithHexString:@"#00cdcb"];
                break;
            }
            case 2:{//引导页第三页
                
                
                UIImageView *imageV2 = [[UIImageView alloc] init];
                UIImage *image2 = [UIImage imageNamed:@"3"];
                imageV2.frame = CGRectMake((kDeviceWidth
 - image2.size.width) / 2, kDeviceHeight - image2.size.height, image2.size.width, image2.size.height);
                imageV2.image = image2;
                [bgView addSubview:imageV2];
                
//                bgView.backgroundColor = [UIColor colorWithHexString:@"#faca09"];
                break;
            }
            case 3:{//引导页第四页
                
                UIImageView *imageV2 = [[UIImageView alloc] init];
                UIImage *image2 = [UIImage imageNamed:@"4"];
                imageV2.frame = CGRectMake((kDeviceWidth
 - image2.size.width) / 2, kDeviceHeight - image2.size.height, image2.size.width, image2.size.height);
                imageV2.image = image2;
                [bgView addSubview:imageV2];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [UIImage imageNamed:@"4_go"];
                btn.frame = CGRectMake((kDeviceWidth - image.size.width) / 2, kDeviceHeight - image.size.height - 20, image.size.width, image.size.height);
                [btn setBackgroundImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:btn];
//                bgView.backgroundColor = [UIColor colorWithHexString:@"#2c6799"];
                break;
            }
            case 4:{//引导页第五页
                
                
                break;
            }
            default:
                break;
        }
        [sv addSubview:bgView];
    }
    sv.contentSize = CGSizeMake(4 * kDeviceWidth
, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.bounces = NO;
    sv.delegate = self;
    [self.view addSubview:sv];
    
    //创建UIPageControl
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake((kDeviceWidth
 - 100) / 2, kDeviceHeight - 20, 100, 20)];  //创建UIPageControl，位置在屏幕最下方。
    _pageCtrl.numberOfPages = 4;//总的图片页数
    _pageCtrl.currentPage = 0; //当前页
//    _pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#333333"];
//    _pageCtrl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#333333" alpha:0.5];
    [self.view addSubview:_pageCtrl];
}

#pragma mark - 监听按钮的响应事件
- (void)btnClick:(id)sender
{
    self.callBack();
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageCtrl setCurrentPage:offset.x / bounds.size.width];
    
    int count = offset.x / bounds.size.width;
    
    //scrollview滚到头部和尾部时,不能调用scrollViewDidEndDecelerating,用return实现
    if (count == 4 || count == 0) {
        if (count == 4) {
            _pageCtrl.hidden = YES;
        }else{
            _pageCtrl.hidden = NO;
        }
        if (_isFirst) {
            _isFirst = NO;
        }else{
            return;
        }
    }else{
        _pageCtrl.hidden = NO;
        _isFirst = YES;
    }
    
    
    if (_lastCount != count) {//移除上一个滚动视图中的imageView
        
        if (_lastCount == 0) {//0需要移除两个imageView
            UIImageView *imageV1 = (UIImageView *)[scrollView viewWithTag:1000];
//            UIImageView *imageV2 = (UIImageView *)[scrollView viewWithTag:2000];
            [imageV1 removeFromSuperview];
//            [imageV2 removeFromSuperview];
//            UIImageView *imageV = (UIImageView *)[scrollView viewWithTag:100 + _lastCount];
//            [imageV removeFromSuperview];
            
        }else{
            
            UIImageView *imageV = (UIImageView *)[scrollView viewWithTag:100 + _lastCount];
            [imageV removeFromSuperview];
        }
    }else{//相等时返回,不然会有动画
        return;
    }
    
    _lastCount = count;
    
    
    
    
    if (count == 0) {//0时视图添加特殊处理
        

        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_zi",count +1]];
        imageV.frame = CGRectMake((kDeviceWidth
 - image.size.width) / 2, - image.size.height, image.size.width, image.size.height);
        imageV.image = image;
        imageV.tag = 1000;
        UIView *bgView = (UIView *)[scrollView viewWithTag:count];
        [bgView addSubview:imageV];
//        [bgView addSubview:imageV2];
        
        [UIView animateWithDuration:1.0 animations:^{
            imageV.frame = CGRectMake((kDeviceWidth
 - image.size.width) / 2, kDeviceHeight/2 -150/2, image.size.width, image.size.height);
        }];
        
    }else if(count ==1){
        
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_zi",count +1]];
        imageV.frame = CGRectMake(-image.size.width, kDeviceHeight- image.size.height -85/2, image.size.width, image.size.height);
        imageV.image = image;
        imageV.tag = 100 + count;
        UIView *bgView = (UIView *)[scrollView viewWithTag:count];
        [bgView addSubview:imageV];
        
        
        [UIView animateWithDuration:1.0 animations:^{
            imageV.frame = CGRectMake(25, kDeviceHeight- image.size.height -85/2, image.size.width, image.size.height);
        }];
        
    }else if(count ==2){
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_zi",count +1]];
        imageV.frame = CGRectMake(kDeviceWidth
 ,kDeviceHeight - image.size.height -90/2, image.size.width, image.size.height);
        imageV.image = image;
        imageV.tag = 100 + count;
        UIView *bgView = (UIView *)[scrollView viewWithTag:count];
        [bgView addSubview:imageV];
        
        
        [UIView animateWithDuration:1.0 animations:^{
            imageV.frame = CGRectMake(kDeviceWidth
 - image.size.width -25/2 , kDeviceHeight - image.size.height -90/2, image.size.width, image.size.height);
        }];
    }else if(count ==3){
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_zi",count +1]];
        imageV.frame = CGRectMake((kDeviceWidth
 - image.size.width) / 2, kDeviceHeight + image.size.height, image.size.width, image.size.height);
        imageV.image = image;
        imageV.tag = 100 + count;
        UIView *bgView = (UIView *)[scrollView viewWithTag:count];
        [bgView addSubview:imageV];
        
        
        [UIView animateWithDuration:1.0 animations:^{
            imageV.frame = CGRectMake((kDeviceWidth
 - image.size.width) / 2, kDeviceHeight - image.size.height -110, image.size.width, image.size.height);
        }];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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