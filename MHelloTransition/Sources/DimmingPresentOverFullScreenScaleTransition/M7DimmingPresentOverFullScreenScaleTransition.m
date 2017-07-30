//
//  M7DimmingPresentOverFullScreenScaleTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingPresentOverFullScreenScaleTransition.h"

static double const kAnimationDuration = .3;
static double const kBlackCoverColorAlpha = .5;
static double const kScale = .95;
static NSInteger const kBlackCoverTag = 15634;

@interface M7DimmingPresentOverFullScreenScaleTransition ()
@property (nonatomic) M7DimmingPresentOverFullScreenScaleTransitionType type;
@property (nonatomic, weak) UIViewController *blackCoverViewController;
@end

@implementation M7DimmingPresentOverFullScreenScaleTransition
+ (instancetype)transitionWithType:(M7DimmingPresentOverFullScreenScaleTransitionType)type {
    return [[M7DimmingPresentOverFullScreenScaleTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M7DimmingPresentOverFullScreenScaleTransitionType)type {
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
    if (self.type == M7DimmingPresentOverFullScreenScaleTransitionTypePresent) {
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
                         fromViewController.view.transform = CGAffineTransformMakeScale(kScale, kScale);
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
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitialFrame, 0, CGRectGetHeight(container.bounds));
    
    // 动画中的黑色遮罩
    UIView *containerBlackCover = [[UIView alloc] initWithFrame:container.bounds];
    containerBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    containerBlackCover.alpha = 1;
    [container insertSubview:containerBlackCover belowSubview:fromViewController.view];
    
    // 非动画中的黑色遮罩
    UIView *presentedBlackCover = [fromViewController.view viewWithTag:kBlackCoverTag];
    [presentedBlackCover removeFromSuperview];
    
    // animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromViewController.view.frame = fromFinalFrame;
                         containerBlackCover.alpha = 0;
                         toViewController.view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [containerBlackCover removeFromSuperview];
                             
                         // 不支持手势
                         [transitionContext completeTransition:YES];
                     }];
}

@end
