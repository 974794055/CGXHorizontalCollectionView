//
//  CGXCollectionViewGeneralView.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "CGXHorizontalCollectionView.h"

@interface CGXHorizontalCollectionView()

@property (nonatomic , strong , readwrite) NSMutableArray<CGXHorizontalCollectionModel *> *dataArray;

@end

@implementation CGXHorizontalCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.row = 3;
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionViewBGColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.space = 0;
    self.row = 3;
    self.section= 1;
    self.bounces = YES;
    UICollectionViewFlowLayout*flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
    _collectionView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator;
    _collectionView.bounces = self.bounces;
    _collectionView.backgroundColor = self.collectionViewBGColor;
    [_collectionView registerClass:[CGXHorizontalCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCollectionCell class])];
    [self addSubview:_collectionView];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 10.0, *)) {
        _collectionView.prefetchingEnabled = NO;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), floor(self.bounds.size.height));
    [self.collectionView reloadData];
}
- (void)registerCellClass:(Class)cell
{
    NSAssert([cell isKindOfClass:[UICollectionViewCell class]] , @"cell类型需要是UICollectionViewCell");
    [self.collectionView registerClass:[cell class] forCellWithReuseIdentifier:NSStringFromClass([cell class])];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSMutableArray<CGXHorizontalCollectionModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets =self.insets;
    NSAssert(self.row > 0, @"每行至少一个");
    NSAssert(self.section > 0, @"至少一行");
    
    CGFloat spaceV = (insets.top+insets.bottom);
    CGFloat spaceH = (insets.left+insets.right);
    
    CGFloat height = ((CGRectGetHeight(collectionView.frame)- spaceV) - (self.section - 1) * self.minimumLineSpacing) / self.section;
    
    CGFloat width = ((CGRectGetWidth(collectionView.frame)-spaceH) -self.space - (self.row -1) *self.minimumInteritemSpacing) / self.row;
    return CGSizeMake(width,height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForItemBlock) {
        return self.cellForItemBlock(self, collectionView, indexPath);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:collectionView:cellForItemAtIndexPath:)]) {
        return [self.delegate collectionHorizontalView:self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    CGXHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCollectionCell class]) forIndexPath:indexPath];
    CGXHorizontalCollectionModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:baseCell:cellShowItemAt:)]) {
        [self.delegate collectionHorizontalView:self baseCell:cell cellShowItemAt:indexPath];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(self, collectionView, indexPath);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:DidSelectItemAtIndexPath:)]) {
        [self.delegate collectionHorizontalView:self DidSelectItemAtIndexPath:indexPath];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollerBlock) {
        self.scrollerBlock(self, scrollView);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:scrollViewDidScroll:)]) {
        [self.delegate collectionHorizontalView:self scrollViewDidScroll:scrollView];
    }
}
- (void)updateWihDataArray:(NSMutableArray <CGXHorizontalCollectionModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    for (CGXHorizontalCollectionModel *model in dataArray) {
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
