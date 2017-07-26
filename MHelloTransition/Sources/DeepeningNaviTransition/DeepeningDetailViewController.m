//
//  DeepeningDetailViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/26.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DeepeningDetailViewController.h"
#import "M2DeepeningNavigationTransition.h"

@interface DeepeningDetailViewController ()<UINavigationControllerDelegate>

@end

@implementation DeepeningDetailViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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
        return [M2DeepeningNavigationTransition transitionWithType:M2DNTDeepeningNavigationTransitionTypePop];
    }
    
    return nil;
}

@end
