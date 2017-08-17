//
//  M7DimmingPresentationController.m
//  MHelloTransition
//
//  Created by Chen,Meisong on 2017/8/17.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7DimmingPresentationController.h"

static double const kBlackCoverColorAlpha = .5;
static NSInteger const kBlackCoverTag = 15634;

@interface M7DimmingPresentationController ()
@property (nonatomic, weak) UIViewController *blackCoverViewController;
@property (nonatomic) UIView *containerBlackCover;
@property (nonatomic) UIView *presentedBlackCover;
@end

@implementation M7DimmingPresentationController

- (void)presentationTransitionWillBegin {
    // 动画中的黑色遮罩，和from、to的动画不同，故加在container上
    UIView *containerBlackCover = [[UIView alloc] initWithFrame:self.containerView.bounds];
    containerBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    containerBlackCover.alpha = 0;
    [self.containerView insertSubview:containerBlackCover belowSubview:self.presentedViewController.view];
    self.containerBlackCover = containerBlackCover;
    
    // 非动画中的黑色遮罩，目的是接受tap事件，触发dismiss，故加在presentedViewController上
    UIView *presentedBlackCover = [[UIView alloc] initWithFrame:self.containerView.bounds];
    presentedBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    presentedBlackCover.tag = kBlackCoverTag;
    presentedBlackCover.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlackCover)];
    [presentedBlackCover addGestureRecognizer:tap];
    self.blackCoverViewController = self.presentedViewController;
    presentedBlackCover.hidden = YES;
    [self.presentedViewController.view addSubview:presentedBlackCover];
    [self.presentedViewController.view sendSubviewToBack:presentedBlackCover];
    self.presentedBlackCover = presentedBlackCover;
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        containerBlackCover.alpha = 1;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    [self.containerBlackCover removeFromSuperview];
    self.containerBlackCover = nil;
    self.presentedBlackCover.hidden = NO;
}

- (void)dismissalTransitionWillBegin {
    // 非动画中的黑色遮罩
    self.presentedBlackCover.hidden = YES;
    
    // 动画中的黑色遮罩
    UIView *containerBlackCover = [[UIView alloc] initWithFrame:self.containerView.bounds];
    containerBlackCover.backgroundColor = [UIColor colorWithWhite:0 alpha:kBlackCoverColorAlpha];
    containerBlackCover.alpha = 1;
    [self.containerView insertSubview:containerBlackCover belowSubview:self.presentedViewController.view];
    self.containerBlackCover = containerBlackCover;
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        containerBlackCover.alpha = 0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [self.containerBlackCover removeFromSuperview];
    self.containerBlackCover = nil;
    if (completed) {
        [self.presentedBlackCover removeFromSuperview];
        self.presentedBlackCover = nil;
        self.blackCoverViewController = nil;
    } else {
        self.presentedBlackCover.hidden = NO;
    }
}

#pragma mark - Event
- (void)onTapBlackCover {
    [self.blackCoverViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter

@end
