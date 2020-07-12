//
//  CGXHorizontalCollectionViewDelegate.h
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CGXHorizontalCollectionView;
@protocol CGXHorizontalCollectionViewDelegate <NSObject>

@required

@optional

/*
 展示cell 处理数据
 */
- (UICollectionViewCell *)collectionHorizontalView:(CGXHorizontalCollectionView *)baseView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;


- (void)collectionHorizontalView:(CGXHorizontalCollectionView *)baseView baseCell:(UICollectionViewCell *)baseCell cellShowItemAt:(NSIndexPath *)indexPath;
/*
 点击cell
 */
- (void)collectionHorizontalView:(CGXHorizontalCollectionView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
/*
 滚动
 */
- (void)collectionHorizontalView:(CGXHorizontalCollectionView *)baseView scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
