//
//  M7ScreenEdgePanInteractiveTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7ScreenEdgePanInteractiveTransition.h"

static double const kMinShouldFinishProgress = .5;

@interface M7ScreenEdgePanInteractiveTransition ()
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic) BOOL shouldFinish;
@property (nonatomic) BOOL isInteracting;
@property (nonatomic) double panTotalWidth;
@end

@implementation M7ScreenEdgePanInteractiveTransition
+ (instancetype)transition {
    return [M7ScreenEdgePanInteractiveTransition new];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _minShouldFinishProgress = kMinShouldFinishProgress;
    }
    
    return self;
}


#pragma mark - Public
- (void)bindViewController:(UIViewController *)popViewController {
    self.viewController = popViewController;
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    pan.edges = UIRectEdgeLeft;
    self.viewController.view.userInteractionEnabled = YES;
    [self.viewController.view addGestureRecognizer:pan];
}

#pragma mark - Event
- (void)onPan:(UIScreenEdgePanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            self.panTotalWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
            [self.viewController
                 .navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            double progress = translation.x / self.panTotalWidth;
            progress = fmin(fmax(progress, 0), 1.0);
            self.shouldFinish = (progress >= self.minShouldFinishProgress);
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
            self.panTotalWidth = 0;
            self.isInteracting = NO;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Setter
- (void)setMinShouldFinishProgress:(double)minShouldFinishProgress {
    _minShouldFinishProgress = fmin(fmax(minShouldFinishProgress, .1), .9);
}

@end
