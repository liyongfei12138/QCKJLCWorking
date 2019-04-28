//
//  NSBundle+QCKJBundlle.m
//  QCKJLib
//
//  Created by Bingo on 2019/3/8.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import "NSBundle+QCKJBundlle.h"
#import "MyAppDelegate.h"
@implementation NSBundle (QCKJBundlle)

+ (instancetype)qckj_refreshBundle
{
    static NSBundle *qckjBundle = nil;
    if (qckjBundle == nil) {

        qckjBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MyAppDelegate class]] pathForResource:@"QCKJBundle" ofType:@"bundle"]];
        
    }
    return qckjBundle;
    
}
+ (UIImage *)qckj_BackImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self qckj_refreshBundle] pathForResource:@"web_back_nor" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
    
}
+ (NSString *)qckj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
            
            
        } else if ([language hasPrefix:@"zh"]) {
            
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"en"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle qckj_refreshBundle] pathForResource:language ofType:@"lproj"]];
        
        
        
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
+ (NSString *)qckj_localizedStringForKey:(NSString *)key
{
    return [self qckj_localizedStringForKey:key value:nil];
}

@end
