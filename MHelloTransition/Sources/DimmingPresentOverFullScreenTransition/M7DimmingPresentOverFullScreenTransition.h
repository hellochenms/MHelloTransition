//
//  M2DeepeningPresentTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M7DimmingPresentOverFullScreenTransitionType) {
    M7DimmingPresentOverFullScreenTransitionTypePresent,
    M7DimmingPresentOverFullScreenTransitionTypeDismiss,
};

@interface M7DimmingPresentOverFullScreenTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithType:(M7DimmingPresentOverFullScreenTransitionType)type;
- (instancetype)initWithType:(M7DimmingPresentOverFullScreenTransitionType)type;
@end
