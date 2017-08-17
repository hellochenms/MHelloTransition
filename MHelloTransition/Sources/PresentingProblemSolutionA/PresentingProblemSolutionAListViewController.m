//
//  PresentingProblemSolutionAListViewController.m
//  MHelloTransition
//
//  Created by Chen,Meisong on 2017/8/17.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "PresentingProblemSolutionAListViewController.h"
#import "PresentingProblemSolutionATransition.h"
#import "DimmingPresentOverFullScreenScaleDetailViewController.h"
#import "M7PanDownInteractiveTransition.h"


@interface PresentingProblemSolutionAListViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) PresentingProblemSolutionATransition *transition;
@property (nonatomic) M7PanDownInteractiveTransition *interactiveTransition;
@end

@implementation PresentingProblemSolutionAListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    self.button.frame = CGRectMake(20, 64 + 20, CGRectGetWidth(self.view.bounds) - 20 * 2, 60);
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.isInteracting ? self.interactiveTransition : nil;
}

#pragma mark - Event
- (void)onTap {
    DimmingPresentOverFullScreenScaleDetailViewController *controller = [DimmingPresentOverFullScreenScaleDetailViewController new];
    [self.interactiveTransition bindViewController:controller];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self;
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
}

#pragma mark - Getter
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor brownColor];
        [_button setTitle:@"Present-黑科技方案A（不推荐）" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (PresentingProblemSolutionATransition *)transition {
    if (!_transition) {
        _transition = [PresentingProblemSolutionATransition transition];
    }
    
    return _transition;
}

- (M7PanDownInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [M7PanDownInteractiveTransition transitionWithType:M7PDIActionTypeDismiss];
        _interactiveTransition.panTotalHeightScreenHeightFactor = .5;
    }
    
    return _interactiveTransition;
}

@end
