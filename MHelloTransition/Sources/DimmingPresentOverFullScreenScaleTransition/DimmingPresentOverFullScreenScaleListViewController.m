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
@property (nonatomic) M7DimmingPresentOverFullScreenScaleTransition *transition;
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
    return self.transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transition;
}

#pragma mark - Event
- (void)onTap {
    DimmingPresentOverFullScreenScaleDetailViewController *controller = [DimmingPresentOverFullScreenScaleDetailViewController new];
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
        [_button setTitle:@"Present-不支持手势" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (M7DimmingPresentOverFullScreenScaleTransition *)transition {
    if (!_transition) {
        _transition = [M7DimmingPresentOverFullScreenScaleTransition transition];
    }
    
    return _transition;
}

@end
