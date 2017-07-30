//
//  M2DeepeningPresentTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M7DPTDimmingPresentTransitionType) {
    M7DPTDimmingPresentTransitionTypePresent,
    M7DPTDimmingPresentTransitionTypeDismiss,
};

@interface M7DimmingPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithType:(M7DPTDimmingPresentTransitionType)type;
- (instancetype)initWithType:(M7DPTDimmingPresentTransitionType)type;
@end
