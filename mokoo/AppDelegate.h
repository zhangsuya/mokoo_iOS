//
//  AppDelegate.h
//  mokoo
//
//  Created by Mac on 15/8/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import "WeiboApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager* _mapManager; //实例化
}
@property (nonatomic, strong) CTTelephonyNetworkInfo *networkInfo;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)UserInfo *userInfo;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property float autoSizeScaleX;
@property float autoSizeScaleY;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

