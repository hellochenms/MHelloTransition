//
//  M7DimmingPresentCustomTransition.m
//  MHelloTransition
//
//  Created by Chen,Meisong on 2017/8/17.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingPresentCustomTransition.h"

static double const kAnimationDuration = .3;

@interface M7DimmingPresentCustomTransition ()
@end

@implementation M7DimmingPresentCustomTransition
+ (instancetype)transition {
    return [M7DimmingPresentCustomTransition new];
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return kAnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (toViewController.isBeingPresented) {
        [self present:transitionContext];
    } else if (fromViewController.isBeingDismissed) {
        [self dismiss:transitionContext];
    }
}

#pragma mark -
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toInitialFrame = CGRectOffset(toFinalFrame, 0, CGRectGetHeight(container.bounds));
    toViewController.view.frame = toInitialFrame;
    [container addSubview:toViewController.view];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toViewController.view.frame = toFinalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitialFrame, 0, CGRectGetHeight(container.bounds));
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = fromFinalFrame;
                     } completion:^(BOOL finished) {
                         BOOL isCancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!isCancelled];
                     }];
}

@end
