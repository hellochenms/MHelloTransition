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

@interface ImageListViewController ()
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *datas;
@property (nonatomic) UIImageView *selectedImageView;
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

#pragma mark - M2ImageNavigationTransitionDelegate
- (UIImageView *)m2_imageView {
    return self.selectedImageView;
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
    ImageCell *cell = (ImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedImageView = cell.imageView;
    
    ImageDetailViewController *controller = [ImageDetailViewController new];
    NSString *imageName = self.datas[indexPath.row];
    controller.imageName = imageName;
    self.navigationController.delegate = controller;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
