//
//  LViewController.m
//  MTZZ
//
//  Created by Seven on 2018/6/25.
//  Copyright © 2018年 Seven. All rights reserved.
//


#import "LViewController.h"



@interface LViewController ()
{
    
}
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LViewController

#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    //横屏请设置成 @"Landscape"
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation
                                                       isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    UIImage *image = [UIImage imageNamed:launchImageName];
    
    if (image == nil) {
//        NSLog(@"___image___故事版启动");
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
        
        UIViewController *lauchVc = [story instantiateViewControllerWithIdentifier:@"launch"];

        image = [self makeImageWithView:lauchVc.view withSize:[UIApplication sharedApplication].keyWindow.bounds.size];
    }
    else{
//         NSLog(@"___image___assetd启动图");
    }
    
    
    _imageView = [UIImageView new];
    _imageView.userInteractionEnabled = YES;
    [_imageView setImage:image];
    [self.view addSubview:_imageView];
    


    _imageView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be  recreated.
}
#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


@end
