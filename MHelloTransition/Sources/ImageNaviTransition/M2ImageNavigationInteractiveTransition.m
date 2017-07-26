//
//  M2ImageNavigationInteractiveTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M2ImageNavigationInteractiveTransition.h"

@interface M2ImageNavigationInteractiveTransition ()
@property (nonatomic, weak) UIViewController *popViewController;
@property (nonatomic) BOOL shouldFinish;
@property (nonatomic) BOOL isInteracting;
@end

@implementation M2ImageNavigationInteractiveTransition
- (void)bindPopViewController:(UIViewController *)popViewController {
    self.popViewController = popViewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    self.popViewController.view.userInteractionEnabled = YES;
    [self.popViewController.view addGestureRecognizer:pan];
}

#pragma mark - Event
- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            [self.popViewController.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            double progress = translation.y / CGRectGetHeight(self.popViewController.view.bounds);
            progress = fmin(fmax(progress, 0), 1.0);
            self.shouldFinish = (progress >= .5);
            [self updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (!self.shouldFinish || pan.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            self.isInteracting = NO;
            break;
        }
        default:
            break;
    }
}

@end
