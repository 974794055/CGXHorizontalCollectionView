//
//  CGXHorizontalCollectionModel.swift
//  CGXHorizontalCollectionView-Swift
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

import UIKit

enum CGXHorizontalCollectionModelType : Int {
    case all //文字 图片 上图下文字
    case title //只有文字
    case image //只有图片
    case node //自定义
}
class CGXHorizontalCollectionModel: NSObject {

    var type:CGXHorizontalCollectionModelType = .all
    var borderColor: UIColor = UIColor.init(white: 0.93, alpha: 1)
    var borderWidth: CGFloat = 0.5
    var isHcornerRadius:Bool = false
    var cornerRadius: CGFloat = 10
    var backgroundColor: UIColor = UIColor.white
    var dataModel: Any?
    
    override init() {
        super.init()
    }
}
