//
//  CGXHorizontalCollectionModel.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "CGXHorizontalCollectionModel.h"

@implementation CGXHorizontalCollectionModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = CGXHorizontalCollectionModelTypeAll;
        self.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.borderWidth = 1;
        self.cornerRadius = 4;
        self.backgroundColor = [UIColor orangeColor];
        self.isHcornerRadius = YES;
    }
    return self;
}
@end
