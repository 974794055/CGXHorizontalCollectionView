//
//  CGXCollectionViewGeneralView.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "CGXHorizontalCollectionView.h"
#import "CGXHorizontalCollectionLayout.h"
@interface CGXHorizontalCollectionView()

@property (nonatomic , strong , readwrite) NSMutableArray<CGXHorizontalCollectionModel *> *dataArray;
@property (nonatomic , strong , readwrite) UICollectionView *collectionView;

@property (nonatomic , strong )CGXHorizontalCollectionLayout *flowLayout;
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
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            ((UIViewController *)next).automaticallyAdjustsScrollViewInsets = NO;
            break;
        }
        next = next.nextResponder;
    }
}
- (void)initializeViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.row = 3;
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.showsHorizontalScrollIndicator = NO;
    self.space = 0;
    self.row = 3;
    self.section= 1;
    self.bounces = YES;
    self.stop = NO;
    CGXHorizontalCollectionLayout*flowLayout= [[CGXHorizontalCollectionLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.stop = self.stop;
    self.flowLayout = flowLayout;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator;
    self.collectionView.bounces = self.bounces;
    self.collectionView.backgroundColor = self.backgroundColor;
    [self.collectionView registerClass:[CGXHorizontalCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCollectionCell class])];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    //给collectionView注册头分区的Id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    //给collection注册脚分区的id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self addSubview:_collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self.collectionView reloadData];
}
- (void)registerCellClass:(Class)classCell IsXib:(BOOL)isXib
{
    NSAssert(![classCell isKindOfClass:[UICollectionViewCell class]] , @"cell类型需要是UICollectionViewCell");
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", classCell] bundle:nil] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
        
    } else{
        [self.collectionView registerClass:classCell forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
    }
}
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib
{
    if (![footer isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![footer isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", footer] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    } else{
        [self.collectionView registerClass:footer forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    }
}
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib
{
    if (![header isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![header isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", header] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    } else{
        [self.collectionView registerClass:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    }
}

- (void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionView.bounces = bounces;
}
- (void)setShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator
{
    _showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    self.collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
}
- (void)setStop:(BOOL)stop
{
    _stop = stop;
    self.flowLayout.stop =stop;
    self.collectionView.collectionViewLayout = self.flowLayout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
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
    return CGSizeMake(width,floor(height));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
        return CGSizeMake(50, CGRectGetWidth(collectionView.frame));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(30, CGRectGetWidth(collectionView.frame));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        headview.backgroundColor = collectionView.backgroundColor;
        headview.backgroundColor = [UIColor orangeColor];
        return headview;
    } else {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        footview.backgroundColor = collectionView.backgroundColor;;
        footview.backgroundColor = [UIColor yellowColor];
        return footview;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForItemBlock) {
        return self.cellForItemBlock(self, indexPath);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:cellForItemAtIndexPath:)]) {
        return [self.delegate collectionHorizontalView:self cellForItemAtIndexPath:indexPath];
    }
    CGXHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCollectionCell class]) forIndexPath:indexPath];
    CGXHorizontalCollectionModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(self, indexPath);
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
- (void)updateWithModel:(CGXHorizontalCollectionModel *)model AtIndex:(NSInteger)index
{
    if (self.dataArray.count == 0) {
        return;
    }
    if (index>=self.dataArray.count) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0 animations:^{
      [weakSelf.collectionView performBatchUpdates:^{
          [weakSelf.dataArray replaceObjectAtIndex:index withObject:model];
          [weakSelf.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
      } completion:nil];
    }];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
