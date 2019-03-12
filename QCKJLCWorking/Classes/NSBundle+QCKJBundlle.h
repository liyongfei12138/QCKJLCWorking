//
//  NSBundle+QCKJBundlle.h
//  QCKJLib
//
//  Created by Bingo on 2019/3/8.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QCKJBundlle)
+ (instancetype)qckj_refreshBundle;
+ (UIImage *)qckj_BackImage;
+ (NSString *)qckj_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)qckj_localizedStringForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
