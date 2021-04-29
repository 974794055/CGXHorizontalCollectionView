//
//  ViewController.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "ViewController.h"

#import "CGXHorizontalCollectionView.h"
#import "CGXHorizontalCustomCell.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    CGXHorizontalCollectionView *horizontalView = [[CGXHorizontalCollectionView alloc] init];
    horizontalView.backgroundColor = [UIColor whiteColor];
    horizontalView.frame = CGRectMake(0, 150, self.view.frame.size.width, 200);
    [self.view addSubview:horizontalView];
    horizontalView.section = 2;
    horizontalView.row = 3;
    horizontalView.bounces = YES;
//    horizontalView.space = 30;
    horizontalView.stop = NO;

    NSMutableArray *dataArray = [NSMutableArray array];
    int  n =  24;
    for (int i = 0; i<n; i++) {
        CGXHorizontalCollectionModel *model= [[CGXHorizontalCollectionModel alloc] init];
        model.backgroundColor = [UIColor orangeColor];
        model.isHcornerBorder = YES;
        model.isHcornerRadius = YES;
        model.cornerRadius = 10;
        model.horizontal_loadImageBlock = ^(UIImageView * _Nonnull hotImageView) {
            hotImageView.contentMode = UIViewContentModeScaleAspectFill;
            hotImageView.image = [UIImage imageNamed:@"bg"];
        };
        [dataArray addObject:model];
    }
    [horizontalView updateWihDataArray:dataArray];
    horizontalView.didSelectItemBlock = ^(CGXHorizontalCollectionView *hBaseView, NSIndexPath *indexPath) {
        NSLog(@"%ld",indexPath.row);
    };
    
    CGXHorizontalCollectionView *horizontalView2 = [[CGXHorizontalCollectionView alloc] init];
    horizontalView2.backgroundColor = [UIColor whiteColor];
    horizontalView2.frame = CGRectMake(0, CGRectGetMaxY(horizontalView.frame)+10, self.view.frame.size.width, 200);
    [self.view addSubview:horizontalView2];
    horizontalView2.section = 2;
    horizontalView2.row = 3;
    horizontalView2.bounces = YES;
//    horizontalView.space = 30;
    horizontalView2.stop = YES;
    [horizontalView2 registerCellClass:[CGXHorizontalCustomCell class] IsXib:NO];
    horizontalView2.cellForItemBlock = ^UICollectionViewCell *(CGXHorizontalCollectionView *hBaseView, NSIndexPath *indexPath) {
        CGXHorizontalCustomCell *cell = [hBaseView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCustomCell class]) forIndexPath:indexPath];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        cell.contentView.backgroundColor = color;
        CGXHorizontalCollectionModel *model = hBaseView.dataArray[indexPath.row];
        [cell updateWithModel:model];
        return cell;
    };
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (int i = 0; i<n; i++) {
        CGXHorizontalCollectionModel *model= [[CGXHorizontalCollectionModel alloc] init];
        model.backgroundColor = [UIColor orangeColor];
        model.isHcornerBorder = YES;
        model.isHcornerRadius = YES;
        model.cornerRadius = 10;
        model.horizontal_loadImageBlock = ^(UIImageView * _Nonnull hotImageView) {
            hotImageView.contentMode = UIViewContentModeScaleAspectFill;
            hotImageView.image = [UIImage imageNamed:@"bg"];
        };
        [dataArray2 addObject:model];
    }
    [horizontalView2 updateWihDataArray:dataArray2];
    horizontalView2.didSelectItemBlock = ^(CGXHorizontalCollectionView *hBaseView, NSIndexPath *indexPath) {
        NSLog(@"%ld",indexPath.row);
    };
}


@end
