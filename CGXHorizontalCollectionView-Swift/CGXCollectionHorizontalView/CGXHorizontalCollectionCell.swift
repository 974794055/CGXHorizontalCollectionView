
//
//  CGXHorizontalCollectionCell.swift
//  CGXHorizontalCollectionView-Swift
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

import UIKit

class CGXHorizontalCollectionCell: UICollectionViewCell {

    lazy var itemImageView:UIImageView = {
        let imageView = UIImageView.init()
        self.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemImageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        itemImageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - 数据处理
extension CGXHorizontalCollectionCell {
    func updateInfoWith(model: CGXHorizontalCollectionModel,indexPath: IndexPath) -> Void {
       self.contentView.backgroundColor = model.backgroundColor
    }
    func updateBorderWith(model: CGXHorizontalCollectionModel,indexPath: IndexPath) -> Void {
        //   画圆的同时画边框
        if model.isHcornerRadius {
            let maskPath = UIBezierPath.init(roundedRect: self.itemImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: model.cornerRadius, height: model.cornerRadius))
            let maskLayer1 = CAShapeLayer.init()
            maskLayer1.frame = self.itemImageView.bounds
            maskLayer1.path = maskPath.cgPath
            maskLayer1.strokeColor = model.borderColor.cgColor
            maskLayer1.fillColor = UIColor.white.cgColor
            maskLayer1.lineWidth = model.borderWidth
            self.itemImageView.layer.addSublayer(maskLayer1)
        }
    }
    
}
