//
//  M2ImagePushTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/22.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M2ImageNavigationTransition.h"

@interface M2ImageNavigationTransition ()
@property (nonatomic) M2IPTImageNavigationTransitionType type;
@end

@implementation M2ImageNavigationTransition

+ (instancetype)transitionWithType:(M2IPTImageNavigationTransitionType)type {
    return [[M2ImageNavigationTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M2IPTImageNavigationTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.type == M2IPTImageNavigationTransitionTypePush) {
        [self push:transitionContext];
    } else {
        [self pop:transitionContext];
    }
}

#pragma mark - 
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    toViewController.view.frame = CGRectOffset(toViewController.view.frame, 0, CGRectGetHeight(screenBounds));
    UIView *container = [transitionContext containerView];
    [container addSubview:toViewController.view];
    
    CGRect toViewControllerFinalRect = [transitionContext finalFrameForViewController:toViewController];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toViewController.view.frame = toViewControllerFinalRect;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    CGRect fromViewControllerInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect fromViewControllerFinalRect = CGRectOffset(fromViewControllerInitialFrame, 0, CGRectGetHeight(screenBounds));
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = fromViewControllerFinalRect;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
