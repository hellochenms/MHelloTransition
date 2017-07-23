//
//  ImageCell.h
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
@property (nonatomic) UIImageView *imageView;
- (void)configWithData:(NSString *)imageName;
@end
