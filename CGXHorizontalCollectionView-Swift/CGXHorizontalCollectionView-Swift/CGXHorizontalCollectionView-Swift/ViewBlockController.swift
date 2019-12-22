//
//  ViewBlockController.swift
//  CGXHorizontalCollectionView-Swift
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

import UIKit

class ViewBlockController: UIViewController {
    
    var lisView1 = CGXHorizontalCollectionView()
    var lisView2 = CGXHorizontalCollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        
        for index in 0..<2 {
            let  lisView = CGXHorizontalCollectionView.init(frame: CGRect.init(x: 20, y: 100 + index*210, width: Int(UIScreen.main.bounds.size.width-40), height: 200))
            lisView.backgroundColor = UIColor.white
            lisView.row = 2
            lisView.section = 1
            self.view.addSubview(lisView)
            
            if index == 0{
                lisView.scrollDirection(isVertical: true)
            } else{
                lisView.scrollDirection(isVertical: false)
            }
            
            lisView.selectCellBlock { (baseView, model, indexPath) in
                print("blcok点击:\(baseView)\n--\(model)\n--\(indexPath)")
            }
            lisView.cellForItemAtBlock { (bseView, collectionView, indexPath) -> UICollectionViewCell in
                let cell:CGXHorizontalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CGXHorizontalCollectionCell", for: indexPath) as! CGXHorizontalCollectionCell
                let model = lisView.dataArray[indexPath.row]
                cell.updateInfoWith(model: model, indexPath: indexPath)
                return cell;
            }
            lisView.scrollViewBlock { (baseView, collectionView) in
                print("blcok滚动--\(baseView)--\(collectionView)")
            }
            
            
            var arr = [CGXHorizontalCollectionModel]()
            for _ in 0..<20 {
                let model:CGXHorizontalCollectionModel = CGXHorizontalCollectionModel.init()
                model.isHcornerRadius = true
                model.borderColor = UIColor.orange
                model.backgroundColor = UIColor.red
                arr.append(model)
            }
            lisView.updateWithArray(dataArray: arr)
        }
    }
}
