//
//  M2ImageNavigationInteractiveTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M2ImageNavigationInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
- (void)bindPopViewController:(UIViewController *)popViewController;
@end
