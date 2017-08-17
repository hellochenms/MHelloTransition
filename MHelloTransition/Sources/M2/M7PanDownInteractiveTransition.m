//
//  M2ImageNavigationInteractiveTransition.m
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "M7PanDownInteractiveTransition.h"

static double kPanTotalHeightScreenHeightFactor = 1;
static double kMinShouldFinishProgress = .3;

@interface M7PanDownInteractiveTransition ()
@property (nonatomic) M7PDIActionType type;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic) BOOL shouldFinish;
@property (nonatomic) BOOL isInteracting;
@property (nonatomic) double panTotalHeight;
@end

@implementation M7PanDownInteractiveTransition

#pragma mark - Init
+ (instancetype)transitionWithType:(M7PDIActionType)type {
    return [[M7PanDownInteractiveTransition alloc] initWithType:type];
}

- (instancetype)initWithType:(M7PDIActionType)type {
    self = [super init];
    if (self) {
        _type = type;
        _panTotalHeightScreenHeightFactor = kPanTotalHeightScreenHeightFactor;
        _minShouldFinishProgress = kMinShouldFinishProgress;
    }
    
    return self;
}


#pragma mark - Public
- (void)bindViewController:(UIViewController *)popViewController {
    self.viewController = popViewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    self.viewController.view.userInteractionEnabled = YES;
    [self.viewController.view addGestureRecognizer:pan];
}

#pragma mark - Event
- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            self.panTotalHeight = CGRectGetHeight([UIScreen mainScreen].bounds) * self.panTotalHeightScreenHeightFactor;
            if (self.type == M7PDIActionTypePop) {
                [self.viewController
                 .navigationController popViewControllerAnimated:YES];
            } else {
                [self.viewController dismissViewControllerAnimated:YES completion:nil];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            double progress = translation.y / self.panTotalHeight;
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
            self.panTotalHeight = 0;
            self.isInteracting = NO;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Setter
- (void)setPanTotalHeightScreenHeightFactor:(double)panTotalHeightScreenHeightFactor {
    _panTotalHeightScreenHeightFactor = fmin(fmax(panTotalHeightScreenHeightFactor, .1), 1);
}

- (void)setMinShouldFinishProgress:(double)minShouldFinishProgress {
    _minShouldFinishProgress = fmin(fmax(minShouldFinishProgress, .1), .9);
}

@end
