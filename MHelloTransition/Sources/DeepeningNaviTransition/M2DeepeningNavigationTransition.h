//
//  M2DeepeningNavigationTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/26.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M2DNTDeepeningNavigationTransitionType) {
    M2DNTDeepeningNavigationTransitionTypePush,
    M2DNTDeepeningNavigationTransitionTypePop,
};

@interface M2DeepeningNavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithType:(M2DNTDeepeningNavigationTransitionType)type;
- (instancetype)initWithType:(M2DNTDeepeningNavigationTransitionType)type;

@end
