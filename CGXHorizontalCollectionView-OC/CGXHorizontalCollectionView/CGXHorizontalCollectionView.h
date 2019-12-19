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
#import "CGXHorizontalCollectionViewDelegate.h"
@class CGXHorizontalCollectionView;
/**
 显示cell
 **/
typedef UICollectionViewCell* (^CGXCollectionViewBaseViewCellForItemBlock)(CGXHorizontalCollectionView *baseView,UICollectionView *collectionView,NSIndexPath *indexPath);
/**
 点击cell
 **/
typedef void (^CGXCollectionViewBaseViewDidSelectItemBlock)(CGXHorizontalCollectionView *baseView,UICollectionView *collectionView,NSIndexPath *indexPath);


/**
 滚动cell
 **/
typedef void (^CGXCollectionViewBaseViewScrollerBlock)(CGXHorizontalCollectionView *baseView,UIScrollView *scrollView);


@interface CGXHorizontalCollectionView : UIView
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectionView;


@property (nonatomic , weak) id<CGXHorizontalCollectionViewDelegate>delegate;

@property (nonatomic , strong , readonly) NSMutableArray<CGXHorizontalCollectionModel *> *dataArray;

@property (nonatomic , strong) UIColor *collectionViewBGColor;//collectionview背景颜色

@property (nonatomic , assign) BOOL showsVerticalScrollIndicator;//暂时水平 默认NO
@property (nonatomic , assign) BOOL showsHorizontalScrollIndicator;//暂时垂直 默认NO

@property (nonatomic , assign) BOOL bounces;//边距弹性
@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10,10,10,10

@property (nonatomic , assign) NSInteger space;// 一行溢出的item边距
@property (nonatomic , assign) NSInteger row;//默认每行两个
@property (nonatomic , assign) NSInteger section;//默认一行

// 自定义cell
@property(nonatomic,copy) CGXCollectionViewBaseViewCellForItemBlock cellForItemBlock;
@property(nonatomic,copy) CGXCollectionViewBaseViewDidSelectItemBlock didSelectItemBlock;
@property(nonatomic,copy) CGXCollectionViewBaseViewScrollerBlock scrollerBlock;

//注册cell
- (void)registerCellClass:(Class)cell;

- (void)updateWihDataArray:(NSMutableArray <CGXHorizontalCollectionModel *> *)dataArray;

@end




