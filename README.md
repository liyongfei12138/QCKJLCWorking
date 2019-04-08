# QCKJLCWorking


[![Version](1.0.2)](https://cocoapods.org/pods/QCKJLCWorking)
[![Platform](iOS)](https://cocoapods.org/pods/QCKJLCWorking)


## Requirements
```ruby
依赖库有WebViewJavascriptBridge(6.0.3),AVOSCloud(11.6.1)
但是目前不做版本限制，默认使用最新版本依赖库，如有问题可手动导入固定版本依赖库。
'pod install'时如有问题可切换为'pod update'来拉取。
```
## Installation

```ruby
pod 'QCKJLCWorking' 
```

## Author

liyongfei12138, miap972712779@qq.com

## Method of use
在<AppDelegate.h>中
导入<MyAppDelegate.h>并继承<MyAppDelegate> 
```ruby

#import <MyAppDelegate.h>
@interface AppDelegate : MyAppDelegate 

@end
```
在<AppDelegate.m>中



```ruby

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    WS(weakSelf);
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

      self.initWithSTViewControllerBlock = ^{

      weakSelf.window.rootViewController = [[ViewController alloc] init];
      [weakSelf.window makeKeyAndVisible];
   };

    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

其中ViewController表示你项目中的rootViewController
```
