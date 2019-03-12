//
//  UIImage+QCKJImage.h
//  QCKJLib
//
//  Created by Bingo on 2019/1/4.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QCKJImage)
+ (UIImage *)imageWithOriginalRender:(NSString *)imageName;
    
    // 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
