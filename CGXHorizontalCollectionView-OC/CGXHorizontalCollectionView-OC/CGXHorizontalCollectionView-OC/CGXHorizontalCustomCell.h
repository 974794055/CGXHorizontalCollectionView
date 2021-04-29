//
//  CGXHorizontalCustomCell.h
//  CGXHorizontalCollectionView-OC
//
//  Created by MacMini-1 on 2021/4/16.
//  Copyright © 2021 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHorizontalCollectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXHorizontalCustomCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *urlImageView;

- (void)updateWithModel:(CGXHorizontalCollectionModel *)model;
@end

NS_ASSUME_NONNULL_END
