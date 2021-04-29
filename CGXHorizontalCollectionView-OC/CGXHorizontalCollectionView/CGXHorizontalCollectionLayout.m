//
//  CGXHorizontalCollectionLayout.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2021/1/20.
//  Copyright © 2021 曹贵鑫. All rights reserved.
//

#import "CGXHorizontalCollectionLayout.h"
@interface CGXHorizontalCollectionLayout ()

@end

@implementation CGXHorizontalCollectionLayout
- (void)prepareLayout
{
    [super prepareLayout];

}
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (self.stop) {
        return YES;
    }
    return NO;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if (self.stop) {
        CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:0];
        CGSize itemSize = [self gx_sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGFloat finalPointX = 0;
        NSInteger index = ceil(proposedContentOffset.x / (itemSize.width+ minimumLineSpacing));
        finalPointX = (itemSize.width+ minimumLineSpacing)*index;
        CGPoint finalPoint = CGPointMake(finalPointX, proposedContentOffset.y);
        return finalPoint;
    }else{
        return proposedContentOffset;
    }
}

- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.minimumLineSpacing;
    }
}
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    } else{
        size = self.headerReferenceSize;
    }
    return size;
}
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    } else{
        size = self.footerReferenceSize;
    }
    return size;
}
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return self.sectionInset;
    }
}
- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    } else {
        return self.itemSize;
    }
}
@end
