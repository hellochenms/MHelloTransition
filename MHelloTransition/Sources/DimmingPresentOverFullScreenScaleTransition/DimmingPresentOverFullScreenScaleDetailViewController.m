//
//  DimmingPresentOverFullScreenScaleDetailViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingPresentOverFullScreenScaleDetailViewController.h"

@interface DimmingPresentOverFullScreenScaleDetailViewController ()
@property (nonatomic) UIView *container;
@property (nonatomic) UIButton *button;
@end

@implementation DimmingPresentOverFullScreenScaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.container];
    [self.container addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    self.container.frame = CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 300);
    self.button.frame = CGRectMake(CGRectGetWidth(self.container.bounds) - 20 - 80, 20, 80, 40);
}

#pragma mark - Event
- (void)onTap {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Getter
- (UIView *)container {
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor whiteColor];
    }
    
    return _container;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor brownColor];
        [_button setTitle:@"Dismiss" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

@end
