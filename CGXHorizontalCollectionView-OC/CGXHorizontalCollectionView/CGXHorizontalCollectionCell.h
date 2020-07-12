//
//  CGXCollectionViewGeneralCell.h
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHorizontalCollectionModel.h"
@interface CGXHorizontalCollectionCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *urlImageView;

- (void)updateWithModel:(CGXHorizontalCollectionModel *)model;

@end
