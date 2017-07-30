//
//  M2DeepeningPresentTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingPresentOverFullScreenTransition.h"

static double const kAnimationDuration = .3;
static double const kBlackCoverColorAlpha = .5;
static NSInteger const kBlackCoverTag = 15634;

@interface M7DimmingPresentOverFullScreenTransition ()
@property (nonatomic) M7DimmingPresentOverFullScreenTransitionType type;
@property (nonatomic, weak) UIViewController *blackCoverViewController;
@end

@implementation M7DimmingPresentOverFullScreenTransition
+ (instancetype)transitionWithType:(M7DimmingPresentOverFullScreenTransitionType)type {
    return [[M7DimmingPresentOverFullScreenTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M7DimmingPresentOverFullScreenTransitionType)type {
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
    if (self.type == M7DimmingPresentOverFullScreenTransitionTypePresent) {
        [self present:transitionContext];
    } else {
        [self dismiss:transitionContext];
    }
}

#pragma mark -
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 动画中的黑色遮罩，和from、to的动画不同，故加在container上
    UIView *containerBlackCover = [[UIView alloc] initWithFrame:container.bounds];
    containerBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    containerBlackCover.alpha = 0;
    [container addSubview:containerBlackCover];
    
    // 非动画中的黑色遮罩，目的是接受tap事件，触发dismiss，故加在presentedViewController上
    UIView *presentedBlackCover = [[UIView alloc] initWithFrame:container.bounds];
    presentedBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    presentedBlackCover.tag = kBlackCoverTag;
    presentedBlackCover.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlackCover)];
    [presentedBlackCover addGestureRecognizer:tap];
    self.blackCoverViewController = toViewController;
    presentedBlackCover.hidden = YES;
    [toViewController.view addSubview:presentedBlackCover];
    [toViewController.view sendSubviewToBack:presentedBlackCover];
    
    CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toInitialFrame = CGRectOffset(toFinalFrame, 0, CGRectGetHeight(container.bounds));
    toViewController.view.frame = toInitialFrame;
    [container addSubview:toViewController.view];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         containerBlackCover.alpha = 1;
                         toViewController.view.frame = toFinalFrame;
                     } completion:^(BOOL finished) {
                         [containerBlackCover removeFromSuperview];
                         presentedBlackCover.hidden = NO;
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)onTapBlackCover {
    [self.blackCoverViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitialFrame, 0, CGRectGetHeight(container.bounds));
    
    // 非动画中的黑色遮罩
    UIView *presentedBlackCover = [fromViewController.view viewWithTag:kBlackCoverTag];
    presentedBlackCover.hidden = YES;
    
    // 动画中的黑色遮罩
    UIView *containerBlackCover = [[UIView alloc] initWithFrame:container.bounds];
    containerBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    containerBlackCover.alpha = 1;
    [container insertSubview:containerBlackCover belowSubview:fromViewController.view];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = fromFinalFrame;
                         containerBlackCover.alpha = 0;
                     } completion:^(BOOL finished) {
                         [containerBlackCover removeFromSuperview];
                         
                         BOOL isCancelled = [transitionContext transitionWasCancelled];
                         if (isCancelled) {
                             presentedBlackCover.hidden = NO;
                         } else {
                             [presentedBlackCover removeFromSuperview];
                             self.blackCoverViewController = nil;
                         }
                         
                         [transitionContext completeTransition:!isCancelled];
                     }];
}

@end
