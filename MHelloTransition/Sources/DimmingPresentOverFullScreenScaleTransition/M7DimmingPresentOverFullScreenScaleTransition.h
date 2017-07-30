//
//  M7DimmingPresentOverFullScreenScaleTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M7DimmingPresentOverFullScreenScaleTransitionType) {
    M7DimmingPresentOverFullScreenScaleTransitionTypePresent,
    M7DimmingPresentOverFullScreenScaleTransitionTypeDismiss,
};

@interface M7DimmingPresentOverFullScreenScaleTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(M7DimmingPresentOverFullScreenScaleTransitionType)type;
- (instancetype)initWithType:(M7DimmingPresentOverFullScreenScaleTransitionType)type;
@end
