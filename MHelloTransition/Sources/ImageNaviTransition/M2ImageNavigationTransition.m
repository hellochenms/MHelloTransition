//
//  M2ImagePushTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/22.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M2ImageNavigationTransition.h"

static double const kAnimationDuration = .3;

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
    return kAnimationDuration;
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
    UIView *container = [transitionContext containerView];
    UIViewController<M2ImageNavigationTransitionDelegate> *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIImageView *fromImageView = [fromViewController m2_imageView];
    UIViewController<M2ImageNavigationTransitionDelegate> *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView *toImageView = [toViewController m2_imageView];
    
    // before
    fromImageView.hidden = YES;
    
    [container addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    toImageView.hidden = YES;
    
    UIView *tempImageView = [fromImageView snapshotViewAfterScreenUpdates:NO];
    [container addSubview:tempImageView];
    CGRect tempFromFrame = [container convertRect:fromImageView.frame fromView:fromImageView.superview];
    CGRect tempToFrame = [container convertRect:toImageView.frame fromView:toImageView.superview];
    tempImageView.frame = tempFromFrame;
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         tempImageView.frame = tempToFrame;
                         toViewController.view.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         fromImageView.hidden = NO;
                         toImageView.hidden = NO;
                         [tempImageView removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController<M2ImageNavigationTransitionDelegate> *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIImageView *fromImageView = [fromViewController m2_imageView];
    UIViewController<M2ImageNavigationTransitionDelegate> *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView *toImageView = [toViewController m2_imageView];
    
    // before
    fromImageView.hidden = YES;
    [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    toImageView.hidden = YES;
    
    UIView *tempImageView = [fromImageView snapshotViewAfterScreenUpdates:NO];
    [container addSubview:tempImageView];
    CGRect tempFromFrame = [container convertRect:fromImageView.frame fromView:fromImageView.superview];
    CGRect tempToFrame = [container convertRect:toImageView.frame fromView:toImageView.superview];
    tempImageView.frame = tempFromFrame;
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         tempImageView.frame = tempToFrame;
                         fromViewController.view.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         fromImageView.hidden = NO;
                         toImageView.hidden = NO;
                         [tempImageView removeFromSuperview];
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
