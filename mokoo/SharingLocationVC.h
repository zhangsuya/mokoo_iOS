//
//  SharingLocationVC.h
//  
//
//  Created by 常大人 on 15/8/26.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单
@protocol SharingGetLocationDelegate <NSObject>

- (void)UpdataLocation:(NSString *)location;

@end

@interface SharingLocationVC : UIViewController

@property (nonatomic,assign) id<SharingGetLocationDelegate> delegate;

@end
