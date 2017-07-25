//
//  ImageDetailViewController.h
//  MHelloTransition
//
//  Created by chenms on 17/7/22.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M2ImageNavigationTransition.h"

@interface ImageDetailViewController : UIViewController<M2ImageNavigationTransitionDelegate>
@property (nonatomic, copy) NSString *imageName;
@end
