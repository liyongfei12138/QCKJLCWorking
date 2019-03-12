//
//  MyAppDelegate.h
//  QCKJLib
//
//  Created by Bingo on 2019/1/24.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//22222




typedef void (^initWithSTViewControllerBlock)(void);


@interface MyAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, copy) initWithSTViewControllerBlock initWithSTViewControllerBlock;
@property (strong, nonatomic) UIWindow *window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;



@end

NS_ASSUME_NONNULL_END
