//
//  MyAppDelegate.m
//  QCKJLib
//
//  Created by Bingo on 2019/1/24.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import "MyAppDelegate.h"
#import "LViewController.h"
#import "AVOSCloud.h"
#import "QCKJLibMyViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "NSBundle+QCKJBundlle.h"

typedef NS_ENUM(int, AppCode){
    AppCodeByDefault = 2018,                    /* 审核中  */
    AppCodeByWB = 2019,                    /* web  */
    AppCodeBySF = 2020,                 /* sf  */
};

@interface MyAppDelegate()<UNUserNotificationCenterDelegate>
@end
@implementation MyAppDelegate
#define kDeviceStatusHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceTabBarHeight self.tabBarController.tabBar.bounds.size.height
#define kDeviceNavHeight  [UIApplication sharedApplication].statusBarFrame.size.height + 44

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [AVOSCloud setApplicationId:[self stringWithKey:@"CL_APPID"] clientKey:[self stringWithKey:@"CL_APPKEY"]];
    [AVOSCloud setAllLogsEnabled:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LViewController *lviewController = [LViewController new];
    [self.window setRootViewController:lviewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];

    [self st];
    
    [self registerForRemoteNotification];



    return YES;
}

-(void)st
{
    
    AVQuery *query = [AVQuery queryWithClassName:@"checkDate"];
    NSString *yyVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    

    
    [query whereKey:@"version" equalTo:yyVersion];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        if (error == nil) {
            
            if (objects.count > 0) {
                 [self jcsjsbskzd:objects];
            }else
            {
                [self qckjgtwlqqwsb];
                
            }
 
        }
        else
        {
            [self qckjgtwlqqwsb];
        }
        

        
    }];
    


}
- (void)jcsjsbskzd:(NSArray *)objects
{
 
    
    AVObject *avObjct = [objects firstObject];
   

    
    NSDictionary *infoDict =  [avObjct objectForKey:@"_localData"];

    
    NSInteger years = [[infoDict objectForKey:@"year"] integerValue];
    
    NSString *month = [infoDict objectForKey:@"month"];
    
    NSString *str = [infoDict objectForKey:@"day"];
    
    NSArray *dayArr = [NSArray arrayWithArray:[str componentsSeparatedByString:@"@"]];
    
    
    LViewController *lviewController = [LViewController new];
    
    CGRect frame = CGRectMake(0, kDeviceStatusHeight, kDeviceWidth, kDeviceHeight - kDeviceStatusHeight);
    QCKJLibMyViewController *myVC = [[QCKJLibMyViewController alloc] initWithUrl:month frame:frame payRules:dayArr];

    
    
    switch (years) {
        case AppCodeByDefault:
            
            if (self.initWithSTViewControllerBlock) {
                self.initWithSTViewControllerBlock();
            }
            
            break;
        case AppCodeByWB:
            
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [self.window setRootViewController:myVC];
            [self.window makeKeyAndVisible];
            [self.window setBackgroundColor:[UIColor whiteColor]];
            
            
            break;
        case AppCodeBySF:
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [self.window setRootViewController:lviewController];
            [self.window makeKeyAndVisible];
            [self.window setBackgroundColor:[UIColor whiteColor]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:month]];
            break;
        default:
            
            [self qckjgtwlqqwsb];
            break;
    }

}
- (void)qckjgtwlqqwsb
{

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LViewController *lviewController = [LViewController new];
    [self.window setRootViewController:lviewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSBundle qckj_localizedStringForKey:@"remind"]  preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:[NSBundle qckj_localizedStringForKey:@"sure"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self st];
    }];
    [alert addAction:action];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

}



-(NSString *)stringWithKey:(NSString *)key
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *keyName = [infoDict objectForKey:key];
    
    return keyName;
}
/**
 * 初始化UNUserNotificationCenter
 */
- (void)registerForRemoteNotification {
    // iOS10 兼容
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        // 监听回调事件
        [uncenter setDelegate:self];
        //iOS10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                                    });
                                    
                                    //TODO:授权状态改变
//                                    NSLog(@"%@" , granted ? @"授权成功" : @"授权失败");
                                }];
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
            /*
             UNAuthorizationStatusNotDetermined : 没有做出选择
             UNAuthorizationStatusDenied : 用户未授权
             UNAuthorizationStatusAuthorized ：用户已授权
             */
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
//                NSLog(@"未选择");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
//                NSLog(@"未授权");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
//                NSLog(@"已授权");
            }
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
#pragma clang diagnostic pop
}



- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AVOSCloud handleRemoteNotificationsWithDeviceToken:deviceToken];
    
//    NSLog(@"Receive DeviceToken: %@", deviceToken);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"注册失败，无法获取设备 ID, 具体错误: %@", error);
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSInteger num=application.applicationIconBadgeNumber;
    if(num!=0){
        AVInstallation *currentInstallation = [AVInstallation defaultInstallation];
        [currentInstallation setBadge:0];
        [currentInstallation saveEventually];
        application.applicationIconBadgeNumber=0;
    }
}



@end
