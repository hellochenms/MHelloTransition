//
//  DimmingPresentOverFullScreenScaleListViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingPresentOverFullScreenScaleListViewController.h"
#import "M7DimmingPresentOverFullScreenScaleTransition.h"
#import "DimmingPresentOverFullScreenScaleDetailViewController.h"

@interface DimmingPresentOverFullScreenScaleListViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic) UIButton *button;
@property (nonatomic) M7DimmingPresentOverFullScreenScaleTransition *presentTransition;
@property (nonatomic) M7DimmingPresentOverFullScreenScaleTransition *dismissTransition;
@end

@implementation DimmingPresentOverFullScreenScaleListViewController

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

#pragma mark - Event
- (void)onTap {
    DimmingPresentOverFullScreenScaleDetailViewController *controller = [DimmingPresentOverFullScreenScaleDetailViewController new];
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
        [_button setTitle:@"Present-不支持手势" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (M7DimmingPresentOverFullScreenScaleTransition *)presentTransition {
    if (!_presentTransition) {
        _presentTransition = [M7DimmingPresentOverFullScreenScaleTransition transitionWithType:M7DimmingPresentOverFullScreenScaleTransitionTypePresent];
    }
    
    return _presentTransition;
}

- (M7DimmingPresentOverFullScreenScaleTransition *)dismissTransition {
    if (!_dismissTransition) {
        _dismissTransition = [M7DimmingPresentOverFullScreenScaleTransition transitionWithType:M7DimmingPresentOverFullScreenScaleTransitionTypeDismiss];
    }
    
    return _dismissTransition;
}

@end
