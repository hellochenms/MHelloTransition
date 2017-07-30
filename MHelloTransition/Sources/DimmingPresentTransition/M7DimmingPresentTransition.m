//
//  M2DeepeningPresentTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingPresentTransition.h"

static double const kAnimationDuration = .3;
static double const kBlackCoverColorAlpha = .5;
static double const kScale = .95;

@interface M7DimmingPresentTransition ()
@property (nonatomic) M7DPTDimmingPresentTransitionType type;
@end

@implementation M7DimmingPresentTransition
+ (instancetype)transitionWithType:(M7DPTDimmingPresentTransitionType)type {
    return [[M7DimmingPresentTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M7DPTDimmingPresentTransitionType)type {
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
    if (self.type == M7DPTDimmingPresentTransitionTypePresent) {
        [self present:transitionContext];
    } else {
        [self dismiss:transitionContext];
    }
}

#pragma mark -
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *blackCover = [[UIView alloc] initWithFrame:container.bounds];
    blackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    blackCover.alpha = 0;
    [container addSubview:blackCover];
    
    CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toInitialFrame = CGRectOffset(toFinalFrame, 0, CGRectGetHeight(container.bounds));
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

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitialFrame, 0, CGRectGetHeight(container.bounds));
    
    UIView *blackCover = [[UIView alloc] initWithFrame:container.bounds];
    blackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    [container insertSubview:blackCover belowSubview:fromViewController.view];
    
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
