//
//  DeepeningDetailViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/26.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingDetailViewController.h"
#import "M7DimmingNavigationTransition.h"

@interface DimmingDetailViewController ()

@end

@implementation DimmingDetailViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [M7DimmingNavigationTransition transitionWithType:M7DNTDimmingNavigationTransitionTypePush];
    } else {
        return [M7DimmingNavigationTransition transitionWithType:M7DNTDimmingNavigationTransitionTypePop];
    }
    
    return nil;
}

@end
