//
//  CGXHorizontalCollectionModel.h
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGXHorizontalCollectionModelType){
    CGXHorizontalCollectionModelTypeAll,//文字 图片 上图下文字
    CGXHorizontalCollectionModelTypeTitle,//只有文字
    CGXHorizontalCollectionModelTypeImage,//只有图片
    CGXHorizontalCollectionModelTypeNode,//自定义
};

@interface CGXHorizontalCollectionModel : NSObject

@property (nonatomic , assign) CGXHorizontalCollectionModelType type;

@property (nonatomic , strong) UIColor *borderColor;
@property (nonatomic , assign) CGFloat borderWidth;
@property (nonatomic , assign) BOOL isHcornerRadius;
@property (nonatomic , assign) CGFloat cornerRadius;

@property (nonatomic , strong) UIColor *backgroundColor;
@property (nonatomic , strong) id dataModel;

@end

NS_ASSUME_NONNULL_END
