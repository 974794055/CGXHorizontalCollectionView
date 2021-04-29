//
//  CGXHorizontalCollectionLayout.h
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2021/1/20.
//  Copyright © 2021 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXHorizontalCollectionLayout : UICollectionViewFlowLayout
/*
 是否停止在特定滚动位置
 */
@property (nonatomic, assign) BOOL stop;
@end

NS_ASSUME_NONNULL_END
