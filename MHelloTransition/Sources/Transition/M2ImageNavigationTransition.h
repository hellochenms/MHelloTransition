//
//  M2ImagePushTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/22.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, M2IPTImageNavigationTransitionType) {
    M2IPTImageNavigationTransitionTypePush,
    M2IPTImageNavigationTransitionTypePop,
};

@interface M2ImageNavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithType:(M2IPTImageNavigationTransitionType)type;
- (instancetype)initWithType:(M2IPTImageNavigationTransitionType)type;

@end
