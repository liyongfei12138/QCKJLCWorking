# QCKJLCWorking


[![Version]( https://img.shields.io/cocoapods/v/QCKJLCWorking.svg?style=flat)](https://cocoapods.org/pods/QCKJLCWorking)


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
并删除AppDelegate.m中多余的代理方法
self.initWithSTViewControllerBlock = ^{};此block为审核状态下2018的回调
```


## Configuration

如果项目中启动页是加载LaunchScreen.storyboard中的控制器，需要将控制器的Storyboard ID设置为launch。否则会导致崩溃。
如果是加载Assets.xcassets中的图片作为启动页，则不需要以上配置操作。

在info.pist中需要添加<CL_APPKEY，CL_APPID>分别为key和id。
在info.pist中添加权限分别为
```ruby
Privacy - Camera Usage Description
Privacy - Location Always Usage Description
Privacy - Location When In Use Usage Description
Privacy - Photo Library Additions Usage Description
Privacy - Photo Library Usage Description
```
打开网络权限。
打开通知权限。

## Problem

```ruby
Showing Recent Messages
ld: bitcode bundle could not be generated because .........

以上问题需要把TARGETS中 Enable Bitcode 设置为NO。应用最低版本设置为iOS 10.0
```




