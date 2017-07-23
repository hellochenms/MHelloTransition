//
//  ImageCell.m
//  MHelloTransition
//
//  Created by chenms on 17/7/23.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

#pragma mark - Public
- (void)configWithData:(NSString *)imageName {
    self.imageView.image = [UIImage imageNamed:imageName];
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    
    return _imageView;
}

@end
