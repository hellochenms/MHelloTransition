//
//  PresentationControllerDetailViewController.m
//  MHelloTransition
//
//  Created by Chen,Meisong on 2017/8/17.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "PresentationControllerDetailViewController.h"

@interface PresentationControllerDetailViewController ()
@property (nonatomic) UIView *container;
@property (nonatomic) UIButton *button;
@end

@implementation PresentationControllerDetailViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.container];
    [self.container addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    double containerHeight = CGRectGetHeight(self.view.bounds) / 2;
    self.container.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - containerHeight, CGRectGetWidth(self.view.bounds), containerHeight);
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
