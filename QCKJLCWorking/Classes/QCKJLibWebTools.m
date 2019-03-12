//
//  WebTools.m
//  LoanApp
//
//  Created by Bingo on 2019/1/2.
//  Copyright © 2019年 QiCaiShiKong. All rights reserved.
//

#import "QCKJLibWebTools.h"
#import <AdSupport/AdSupport.h>
@interface QCKJLibWebTools()
@end
@implementation QCKJLibWebTools
#define kSmallGray [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1.0f]

//获取IDFA
+ (NSString *)getIDFA
{
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        return [NSString stringWithFormat:@"%@%@",[self timeStamp],[self getRandomStringWithLength:6]];
    }
}
+ (NSString *)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    return [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
}
#pragma mark - 字符串相关处理
/**
 获取指定长度的随即字符串
 */
+ (NSString *)getRandomStringWithLength:(NSInteger)length
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++)
    {
        int number = arc4random() % 36;
        if (number < 10)
        {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }
        else
        {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+(BOOL)inRuleArr:(NSString *)string ruleArr:(NSArray *)rulesArr
{
    BOOL isP = NO;
    for (NSString *str in rulesArr) {
        if ([string hasPrefix:str]) {
            isP = YES;
            break;
        }else{
            isP = NO;
        }
    }
    return isP;
}

@end



