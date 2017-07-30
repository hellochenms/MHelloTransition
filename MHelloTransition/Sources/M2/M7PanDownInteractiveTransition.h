//
//  M2ImageNavigationInteractiveTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, M7PDIActionType) {
    M7PDIActionTypePop,
    M7PDIActionTypeDismiss,
};

@interface M7PanDownInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
@property (nonatomic) double panTotalHeightScreenHeightFactor;
@property (nonatomic) double minShouldFinishProgress;
+ (instancetype)transitionWithType:(M7PDIActionType)type;
- (instancetype)initWithType:(M7PDIActionType)type;
- (void)bindViewController:(UIViewController *)popViewController;
@end
