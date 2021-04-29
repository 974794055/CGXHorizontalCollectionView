//
//  CGXHorizontalCustomCell.m
//  CGXHorizontalCollectionView-OC
//
//  Created by MacMini-1 on 2021/4/16.
//  Copyright © 2021 曹贵鑫. All rights reserved.
//

#import "CGXHorizontalCustomCell.h"
@interface CGXHorizontalCustomCell ()
@property (nonatomic,strong) CGXHorizontalCollectionModel *model;
@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

@end
@implementation CGXHorizontalCustomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.urlImageView = [[UIImageView alloc] init];
        self.urlImageView.clipsToBounds = YES;
        self.urlImageView.layer.masksToBounds = YES;
        self.urlImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.urlImageView];
        self.urlImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self.contentView addConstraint:self.hotImageTop];
        [self.contentView addConstraint:self.hotImageLeft];
        [self.contentView addConstraint:self.hotImageRight];
        [self.contentView addConstraint:self.hotImageBottom];
        [self.urlImageView.superview layoutIfNeeded];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant =0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
}
- (void)updateWithModel:(CGXHorizontalCollectionModel *)model
{
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant =0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
    self.contentView.backgroundColor = model.isHcornerRadius ? [[UIColor whiteColor] colorWithAlphaComponent:0]:model.backgroundColor;

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.urlImageView.bounds;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.urlImageView.bounds;
    borderLayer.lineWidth = model.isHcornerBorder ? model.borderWidth:0;
    borderLayer.strokeColor = [model.borderColor CGColor];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath =  [UIBezierPath bezierPathWithRoundedRect:self.urlImageView.bounds cornerRadius:model.isHcornerRadius ? model.cornerRadius:0];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [self.urlImageView.layer insertSublayer:borderLayer atIndex:0];
    [self.urlImageView.layer setMask:maskLayer];
    
    __weak typeof(self) weakSelf = self;
    if (model.horizontal_loadImageBlock) {
        model.horizontal_loadImageBlock(weakSelf.urlImageView);
    }
}
@end
