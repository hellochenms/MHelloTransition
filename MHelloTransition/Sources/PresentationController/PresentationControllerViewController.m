//
//  PresentationControllerViewController.m
//  MHelloTransition
//
//  Created by Chen,Meisong on 2017/8/17.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "PresentationControllerViewController.h"
#import "PresentationControllerDetailViewController.h"
#import "M7DimmingPresentCustomTransition.h"
#import "M7PanDownInteractiveTransition.h"
#import "M7DimmingPresentationController.h"

@interface PresentationControllerViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) M7DimmingPresentCustomTransition *transition;
@property (nonatomic) M7PanDownInteractiveTransition *interactiveTransition;
@end

@implementation PresentationControllerViewController

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

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[M7DimmingPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

#pragma mark - Event
- (void)onTap {
    PresentationControllerDetailViewController *controller = [PresentationControllerDetailViewController new];
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
        [_button setTitle:@"Present" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (M7DimmingPresentCustomTransition *)transition {
    if (!_transition) {
        _transition = [M7DimmingPresentCustomTransition transition];
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
