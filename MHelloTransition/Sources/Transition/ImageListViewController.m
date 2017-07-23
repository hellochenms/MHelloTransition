//
//  ImageTransitionViewController.m
//  MHelloTransition
//
//  Created by chenms on 17/7/21.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "ImageListViewController.h"
#import "M2ImageNavigationTransition.h"
#import "ImageCell.h"
#import "ImageDetailViewController.h"

static NSString * const kCellIdentifier = @"kCellIdentifier";

@interface ImageListViewController (Collection)<UICollectionViewDataSource, UICollectionViewDelegate>
- (void)initDatas;
@end

@interface ImageListViewController ()<UINavigationControllerDelegate>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *datas;
@end

@implementation ImageListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDatas];
    [self addMySubviews];
}

#pragma mark - Init
- (void)addMySubviews {
    [self.view addSubview:self.collectionView];
}

#pragma mark - Life Cycle
- (void)viewWillLayoutSubviews {
    self.collectionView.frame = self.view.bounds;
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
    if (operation == UINavigationControllerOperationPush) {
        return [M2ImageNavigationTransition transitionWithType:M2IPTImageNavigationTransitionTypePush];
    }
    
    return nil;
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(200, 200);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:kCellIdentifier];
    }
    
    return _collectionView;
}

@end

#pragma mark - 
#pragma mark - ImageListViewController (Collection)
@implementation ImageListViewController (Collection)
#pragma mark - Init
- (void)initDatas {
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 60; i++) {
        NSInteger index = i % 6;
        [datas addObject:[NSString stringWithFormat:@"image%ld", index]];
    }
    self.datas = datas;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.datas count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSString *imageName = self.datas[indexPath.row];
    [cell configWithData:imageName];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageDetailViewController *controller = [ImageDetailViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
