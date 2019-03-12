//
//  LViewController.h
//  MTZZ
//
//  Created by Seven on 2018/6/25.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImageCompletionCallBack)(void);

@interface LViewController : UIViewController


- (void)animateWithImageView:(void (^)(void))successBlock;
@end
