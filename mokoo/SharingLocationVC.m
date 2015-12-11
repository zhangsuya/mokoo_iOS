
//
//  SharingLocationVC.m
//  
//
//  Created by 常大人 on 15/8/26.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import "SharingLocationVC.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "UIButton+EnlargeTouchArea.h"
@interface SharingLocationVC ()<BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BMKLocationService  *_locService;//百度地图
    CGFloat              _latitude;//经度
    CGFloat              _longitude;//维度
    
    NSString            *_defaultAddress;//默认位置
    NSArray             *_addressArr;//位置信息 数组
    
    UITableView         *_tableview;
}
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,weak)UILabel *titleView;
@end

@implementation SharingLocationVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _locService.delegate    = self;
//    [self getLocation];
}
- (void)viewDidDisappear:(BOOL)animated {
    _locService.delegate    = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addressArr  = [NSArray array];
    [self setUpNavigationItem];
    [self createUI];
    [self getLocation];
    
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 50, 30);
    [titleLabel setText:@"定位"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    //    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    //    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    //    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    //    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    //    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}

- (void)createUI {
    _tableview  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
    _tableview.delegate     = self;
    _tableview.dataSource   = self;
    _tableview.backgroundColor  = viewBgColor;
    _tableview.tableFooterView  = [UIView new];
    
    [self.view   addSubview:_tableview];
}

#pragma mark - 获取经纬度
- (void)getLocation {
    
    _locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];

    
}
- (void)didFailToLocateUserWithError:(NSError *)error {
//    SLog(@"location%@",error );
}
//位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    _latitude   = userLocation.location.coordinate.latitude;
    _longitude  = userLocation.location.coordinate.longitude;
    if (_latitude != 0 && _longitude != 0) {
        [_locService stopUserLocationService];
        [self getLocationDes:_longitude andLati:_latitude];
    }
//    SLog(@"*****经纬度%f:%f",_longitude,_latitude);

    
}
//方向更新
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    
    _latitude   = userLocation.location.coordinate.latitude;
    _longitude  = userLocation.location.coordinate.longitude;
    if (_latitude != 0 && _longitude != 0) {
        [_locService stopUserLocationService];
        [self getLocationDes:_longitude andLati:_latitude];
    }
//    SLog(@"*****经纬度%f:%f",_longitude,_latitude);


}

- (void)getLocationDes:(CGFloat)longitude andLati:(CGFloat)latitude {
//    NSString    *lng    = [NSString stringWithFormat:@"%@",@(longitude)];
//    NSString    *lati   = [NSString stringWithFormat:@"%@",@(latitude)];
//    http://api.map.baidu.com/geocoder/v2/?ak=E4805d16520de693a3fe707cdc962045&callback=renderReverse&location=39.983424,116.322987&output=json&pois=1
//    [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=E4805d16520de693a3fe707cdc962045&callback=renderReverse&location=%@,%@&output=json&pois=1",@(longitude),@(latitude)];
//    &mcode=4F:1E:F5:65:E0:91:D1:44:BA:BC:1B:5B:FA:F3:DF:06:40:79:8F:DF;com.company.mokoo
    NSString *strUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=3OnxVEBd3kFC3yXubrhuwxyi&location=%@,%@&output=json&pois=1&mcode=com.Shaiba.mokoo",@(latitude),@(longitude)];
    [RequestCustom getRequestByUrl:strUrl analysisDataComplete:^(BOOL succed, id obj) {
        if (succed) {
            NSLog(@"%@",[obj objectForKey:@"status"]);
            NSDictionary    *dicResult = [obj  objectForKey:@"result"];
            _defaultAddress = [dicResult objectForKey:@"formatted_address"];
            NSArray *poisArr = [dicResult objectForKey:@"pois"];
            _addressArr =poisArr;
            //            _addressArr = [ShareModel objectArrayWithKeyValuesArray:poisArr];
            
            [_tableview reloadData];
        } else {
            //            SLog(@"获取地理位置失败");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
//    [RequestCustom requestSharingLocationLng:lng Latitude:lati complete:^(BOOL succed, id obj) {
//        if (succed) {
//            NSDictionary    *dicResult = [[obj objectForKey:@"data"] objectForKey:@"result"];
//            _defaultAddress = [dicResult objectForKey:@"formatted_address"];
//            NSArray *poisArr = [dicResult objectForKey:@"pois"];
////            _addressArr = [ShareModel objectArrayWithKeyValuesArray:poisArr];
//            
//            [_tableview reloadData];
//        } else {
////            SLog(@"获取地理位置失败");
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];

}


#pragma mark - tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressArr.count + 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString    *cellid = @"cellid";
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"不使用位置";
        cell.detailTextLabel.text = @"";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (当前位置)",_defaultAddress];
    } else {
//        ShareModel  *model = _addressArr[indexPath.row-2];
        cell.textLabel.text = [_addressArr[indexPath.row-2] objectForKey:@"name"];
        cell.detailTextLabel.text   = [_addressArr[indexPath.row-2] objectForKey:@"addr"];
    }

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(UpdataLocation:)]) {
        if (indexPath.row != 1) {
            [self.delegate UpdataLocation:cell.textLabel.text];
        } else {
            [self.delegate  UpdataLocation:_defaultAddress];
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backBtnClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:NO];
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
