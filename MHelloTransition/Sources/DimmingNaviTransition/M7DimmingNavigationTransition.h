//
//  M2DeepeningNavigationTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/26.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M7DNTDimmingNavigationTransitionType) {
    M7DNTDimmingNavigationTransitionTypePush,
    M7DNTDimmingNavigationTransitionTypePop,
};

@interface M7DimmingNavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithType:(M7DNTDimmingNavigationTransitionType)type;
- (instancetype)initWithType:(M7DNTDimmingNavigationTransitionType)type;

@end
