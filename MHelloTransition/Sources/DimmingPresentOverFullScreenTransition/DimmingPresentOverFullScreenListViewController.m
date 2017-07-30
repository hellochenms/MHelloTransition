//
//  DeepeningPresentListViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingPresentOverFullScreenListViewController.h"
#import "DimmingPresentOverFullScreenDetailViewController.h"
#import "M7DimmingPresentOverFullScreenTransition.h"
#import "M7PanDownInteractiveTransition.h"

@interface DimmingPresentOverFullScreenListViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) M7DimmingPresentOverFullScreenTransition *presentTransition;
@property (nonatomic) M7DimmingPresentOverFullScreenTransition *dismissTransition;
@property (nonatomic) M7PanDownInteractiveTransition *interactiveTransition;
@end

@implementation DimmingPresentOverFullScreenListViewController

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
    return self.presentTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.isInteracting ? self.interactiveTransition : nil;
}

#pragma mark - Event
- (void)onTap {
    DimmingPresentOverFullScreenDetailViewController *controller = [DimmingPresentOverFullScreenDetailViewController new];
    [self.interactiveTransition bindViewController:controller];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
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

- (M7DimmingPresentOverFullScreenTransition *)presentTransition {
    if (!_presentTransition) {
        _presentTransition = [M7DimmingPresentOverFullScreenTransition transitionWithType:M7DimmingPresentOverFullScreenTransitionTypePresent];
    }
    
    return _presentTransition;
}

- (M7DimmingPresentOverFullScreenTransition *)dismissTransition {
    if (!_dismissTransition) {
        _dismissTransition = [M7DimmingPresentOverFullScreenTransition transitionWithType:M7DimmingPresentOverFullScreenTransitionTypeDismiss];
    }
    
    return _dismissTransition;
}

- (M7PanDownInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [M7PanDownInteractiveTransition transitionWithType:M7PDIActionTypeDismiss];
        _interactiveTransition.panTotalAndScreenHeightFactor = .5;
    }
    
    return _interactiveTransition;
}

@end
