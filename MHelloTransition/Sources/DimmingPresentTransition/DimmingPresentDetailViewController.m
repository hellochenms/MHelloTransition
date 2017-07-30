//
//  DimmingPresentDetailViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/30.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "DimmingPresentDetailViewController.h"

@interface DimmingPresentDetailViewController ()
@property (nonatomic) UIButton *button;
@end

@implementation DimmingPresentDetailViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    self.button.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 20 - 80, 20, 80, 40);
}

#pragma mark - Event
- (void)onTap {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Getter
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
