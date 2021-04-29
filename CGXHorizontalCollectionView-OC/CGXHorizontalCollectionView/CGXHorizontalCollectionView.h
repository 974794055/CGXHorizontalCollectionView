//
//  CGXCollectionViewGeneralView.h
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXHorizontalCollectionCell.h"
#import "CGXHorizontalCollectionModel.h"
@class CGXHorizontalCollectionView;

@protocol CGXHorizontalCollectionViewDelegate <NSObject>

@required

@optional

/*展示cell 处理数据*/
- (UICollectionViewCell *)collectionHorizontalView:(CGXHorizontalCollectionView *)horizontalView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
/*点击cell*/
- (void)collectionHorizontalView:(CGXHorizontalCollectionView *)horizontalView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
/*滚动*/
- (void)collectionHorizontalView:(CGXHorizontalCollectionView *)horizontalView scrollViewDidScroll:(UIScrollView *)scrollView;

@end

/**
 显示cell
 **/
typedef UICollectionViewCell* (^CGXHorizontalCollectionViewCellForItemBlock)(CGXHorizontalCollectionView *hBaseView,NSIndexPath *indexPath);
/**
 点击cell
 **/
typedef void (^CGXHorizontalCollectionViewDidSelectItemBlock)(CGXHorizontalCollectionView *hBaseView,NSIndexPath *indexPath);
/**
 滚动cell
 **/
typedef void (^CGXHorizontalCollectionViewScrollerBlock)(CGXHorizontalCollectionView *hBaseView,UIScrollView *scrollView);


@interface CGXHorizontalCollectionView : UIView
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , weak) id<CGXHorizontalCollectionViewDelegate>delegate;

@property (nonatomic , strong , readonly) UICollectionView *collectionView;

@property (nonatomic , strong , readonly) NSMutableArray<CGXHorizontalCollectionModel *> *dataArray;

@property (nonatomic , assign) BOOL showsHorizontalScrollIndicator;//暂时垂直 默认NO
@property (nonatomic , assign) BOOL bounces;//边距弹性
@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10,10,10,10
@property (nonatomic , assign) NSInteger space;// 一行溢出的item边距
@property (nonatomic , assign) NSInteger row;//默认每行两个
@property (nonatomic , assign) NSInteger section;//默认一行
/*是否停止在特定滚动位置*/
@property (nonatomic, assign) BOOL stop;
// 自定义cell
@property(nonatomic,copy) CGXHorizontalCollectionViewCellForItemBlock cellForItemBlock;
@property(nonatomic,copy) CGXHorizontalCollectionViewDidSelectItemBlock didSelectItemBlock;
@property(nonatomic,copy) CGXHorizontalCollectionViewScrollerBlock scrollerBlock;

//注册cell
- (void)registerCellClass:(Class)classCell IsXib:(BOOL)isXib;
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib;
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib;

- (void)updateWihDataArray:(NSMutableArray <CGXHorizontalCollectionModel *> *)dataArray;

- (void)updateWithModel:(CGXHorizontalCollectionModel *)model AtIndex:(NSInteger)index;

@end




