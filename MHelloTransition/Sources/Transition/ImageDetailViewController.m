//
//  ImageDetailViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/22.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "M2ImageNavigationInteractiveTransition.h"
#import "M2ImageNavigationTransition.h"
#import "M2ImageNavigationInteractiveTransition.h"

@interface ImageDetailViewController ()<UINavigationControllerDelegate>
@property (nonatomic) UIButton *popButton;
@property (nonatomic) M2ImageNavigationInteractiveTransition *interactiveTransition;
@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.popButton];
    
    
    [self.interactiveTransition bindPopViewController:self];
}

#pragma mark - Life Cycle
- (void)viewWillLayoutSubviews {
    self.popButton.frame = CGRectMake(20, 64 + 20, 100, 60);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [M2ImageNavigationTransition transitionWithType:M2IPTImageNavigationTransitionTypePop];
    }
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if ([animationController isKindOfClass:[M2ImageNavigationTransition class]]
        && self.interactiveTransition.isInteracting) {
        return self.interactiveTransition;
    }
    
    return nil;
}

#pragma mark - Event
- (void)onTapPop {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter
- (UIButton *)popButton {
    if (!_popButton) {
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _popButton.backgroundColor = [UIColor brownColor];
        [_popButton setTitle:@"pop" forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(onTapPop) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popButton;
}

- (M2ImageNavigationInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [M2ImageNavigationInteractiveTransition new];
    }
    
    return _interactiveTransition;
}

@end
