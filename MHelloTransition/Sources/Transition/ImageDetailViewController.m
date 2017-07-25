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
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) M2ImageNavigationInteractiveTransition *interactiveTransition;
@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:self.imageName];
    
    [self.interactiveTransition bindPopViewController:self];
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self layoutMySubviews];
}

- (void)viewWillLayoutSubviews {
    [self layoutMySubviews];
}

- (void)layoutMySubviews {
    double containerWidth = CGRectGetWidth(self.view.bounds);
    double margin = 20;
    double imageWidth = containerWidth - margin * 2;
    self.imageView.frame = CGRectMake(margin, 64 + 20, imageWidth, imageWidth);
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

#pragma mark - M2ImageNavigationTransitionDelegate
- (UIImageView *)m2_imageView {
    return self.imageView;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    
    return _imageView;
}


- (M2ImageNavigationInteractiveTransition *)interactiveTransition {
    if (!_interactiveTransition) {
        _interactiveTransition = [M2ImageNavigationInteractiveTransition new];
    }
    
    return _interactiveTransition;
}

@end
