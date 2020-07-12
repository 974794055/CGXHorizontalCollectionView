//
//  CGXCollectionViewGeneralCell.m
//  CGXHorizontalCollectionView-OC
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

#import "CGXHorizontalCollectionCell.h"
@interface CGXHorizontalCollectionCell ()
@property (nonatomic,strong) CGXHorizontalCollectionModel *model;
@end

@implementation CGXHorizontalCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _urlImageView = [[UIImageView alloc] init];
        _urlImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_urlImageView];
        _urlImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _urlImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    
}
- (void)updateWithModel:(CGXHorizontalCollectionModel *)model
{
    self.contentView.backgroundColor = model.backgroundColor;
    //   画圆的同时画边框
    if (model.isHcornerRadius) {
//        self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
//        
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.urlImageView.bounds byRoundingCorners:UIRectEdgeLeft |
//                              UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//        maskLayer.frame = self.urlImageView.bounds;
//        maskLayer.path = path.CGPath;
//        
//        self.urlImageView.layer.mask = maskLayer;
        
//        maskLayer1.strokeColor = model.borderColor.cgColor
//        maskLayer1.fillColor = UIColor.white.cgColor
//        maskLayer1.lineWidth = 1
//        UIBezierPath *maskPath = [UIBezierPath alloc] initWithCoder:<#(nonnull NSCoder *)#>
//        let maskPath = UIBezierPath.init(roundedRect: self.itemImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: model.cornerRadius, height: model.cornerRadius))
//        let maskLayer1 = CAShapeLayer.init()
//        maskLayer1.frame = self.itemImageView.bounds
//        maskLayer1.path = maskPath.cgPath
//
//        maskLayer1.strokeColor = model.borderColor.cgColor
//        maskLayer1.fillColor = UIColor.white.cgColor
//        maskLayer1.lineWidth = 1
//        self.itemImageView.layer.addSublayer(maskLayer1)
    }
    
}
@end
