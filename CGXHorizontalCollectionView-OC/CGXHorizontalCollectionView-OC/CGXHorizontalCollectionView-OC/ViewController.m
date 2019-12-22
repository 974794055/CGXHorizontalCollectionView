//
//  ViewController.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "ViewController.h"

#import "CGXHorizontalCollectionView.h"

@interface ViewController ()
@property (nonatomic , strong) CGXHorizontalCollectionView *generalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    CGXHorizontalCollectionView *horizontalView = [[CGXHorizontalCollectionView alloc] init];
    horizontalView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    [self.view addSubview:horizontalView];
    horizontalView.section = 2;
    horizontalView.row = 4;
    //    horizontalView.bounces = NO;
    
    horizontalView.cellForItemBlock = ^UICollectionViewCell *(CGXHorizontalCollectionView *baseView, UICollectionView *collectionView, NSIndexPath *indexPath) {
        CGXHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXHorizontalCollectionCell class]) forIndexPath:indexPath];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        cell.contentView.backgroundColor = color;
        CGXHorizontalCollectionModel *model = baseView.dataArray[indexPath.row];
        [cell updateWithModel:model];
        return cell;
    };
    self.generalView = horizontalView;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    int  n =  12;
    for (int i = 0; i<n; i++) {
        CGXHorizontalCollectionModel *model= [[CGXHorizontalCollectionModel alloc] init];
        [dataArray addObject:model];
    }
    [self.generalView updateWihDataArray:dataArray];
}


@end
