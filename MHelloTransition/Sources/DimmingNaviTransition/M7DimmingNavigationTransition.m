//
//  M2DeepeningNavigationTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/26.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingNavigationTransition.h"

static double const kAnimationDuration = .3;
static double const kBlackCoverColorAlpha = .5;
static double const kScale = .95;

@interface M7DimmingNavigationTransition ()
@property (nonatomic) M7DNTDimmingNavigationTransitionType type;
@end

@implementation M7DimmingNavigationTransition

+ (instancetype)transitionWithType:(M7DNTDimmingNavigationTransitionType)type {
    return [[M7DimmingNavigationTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M7DNTDimmingNavigationTransitionType)type {
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
    if (self.type == M7DNTDimmingNavigationTransitionTypePush) {
        [self push:transitionContext];
    } else {
        [self pop:transitionContext];
    }
}

#pragma mark -
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *blackCover = [[UIView alloc] initWithFrame:container.bounds];
    blackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    blackCover.alpha = 0;
    [container addSubview:blackCover];
    
    CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toInitialFrame = CGRectOffset(toFinalFrame, CGRectGetWidth(container.bounds), 0);
    toViewController.view.frame = toInitialFrame;
    [container addSubview:toViewController.view];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(kScale, kScale);
                         blackCover.alpha = 1;
                         toViewController.view.frame = toFinalFrame;
                     } completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         [blackCover removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitialFrame, CGRectGetWidth(container.bounds), 0);

    UIView *blackCover = [[UIView alloc] initWithFrame:container.bounds];
    blackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    [container insertSubview:blackCover belowSubview:fromViewController.view];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.transform = CGAffineTransformMakeScale(kScale, kScale);
    [container insertSubview:toViewController.view belowSubview:blackCover];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = fromFinalFrame;
                         blackCover.alpha = 0;
                         toViewController.view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [blackCover removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
