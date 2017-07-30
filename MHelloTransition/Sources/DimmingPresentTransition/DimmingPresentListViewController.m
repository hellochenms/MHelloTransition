//
//  DimmingPresentListViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingPresentListViewController.h"
#import "M7DimmingPresentTransition.h"
#import "M7PanDownInteractiveTransition.h"
#import "DimmingPresentDetailViewController.h"

@interface DimmingPresentListViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) M7DimmingPresentTransition *presentTransition;
@property (nonatomic) M7DimmingPresentTransition *dismissTransition;
@property (nonatomic) M7PanDownInteractiveTransition *interactiveTransition;
@end

@implementation DimmingPresentListViewController

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
    DimmingPresentDetailViewController *controller = [DimmingPresentDetailViewController new];
    [self.interactiveTransition bindViewController:controller];
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

- (M7DimmingPresentTransition *)presentTransition {
    if (!_presentTransition) {
        _presentTransition = [M7DimmingPresentTransition transitionWithType:M7DPTDimmingPresentTransitionTypePresent];
    }
    
    return _presentTransition;
}

- (M7DimmingPresentTransition *)dismissTransition {
    if (!_dismissTransition) {
        _dismissTransition = [M7DimmingPresentTransition transitionWithType:M7DPTDimmingPresentTransitionTypeDismiss];
    }
    
    return _dismissTransition;
}

- (M7PanDownInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [M7PanDownInteractiveTransition transitionWithType:M7PDIActionTypeDismiss];
    }
    
    return _interactiveTransition;
}

@end
