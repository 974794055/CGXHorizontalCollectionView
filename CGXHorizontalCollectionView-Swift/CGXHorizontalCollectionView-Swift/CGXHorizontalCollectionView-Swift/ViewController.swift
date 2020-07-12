//
//  ViewController.swift
//  CGXHorizontalCollectionView-Swift
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CGXHorizontalCollectionViewDelegate {

    
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
            lisView.delegate = self
            var arr = [CGXHorizontalCollectionModel]()
            for _ in 0..<20 {
                let model:CGXHorizontalCollectionModel = CGXHorizontalCollectionModel.init()
                model.isHcornerRadius = true
                model.borderColor = UIColor.orange
                model.backgroundColor = UIColor.orange
                arr.append(model)
            }
            lisView.updateWithArray(dataArray: arr)
        }
    }
}
extension ViewController {
    func collectionHorizontalView(baseView: CGXHorizontalCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CGXHorizontalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CGXHorizontalCollectionCell", for: indexPath) as! CGXHorizontalCollectionCell
        let model = baseView.dataArray[indexPath.row]
        cell.updateInfoWith(model: model, indexPath: indexPath)
        return cell;
    }
    func collectionHorizontalView(baseView: CGXHorizontalCollectionView, model: CGXHorizontalCollectionModel, didSelectRowAt indexPath: IndexPath) {
        print("代理点击:-\(baseView)\n--\(model)\n--\(indexPath)")
    }
    func collectionHorizontalView(baseView: CGXHorizontalCollectionView, scrollView: UIScrollView) {
        print("代理滚动--\(baseView)--\(scrollView)")
    }
    func collectionHorizontalView(baseView: CGXHorizontalCollectionView, HeaderView: CGXHorizontalCollectionHeaderView, At indexPath: IndexPath) -> UIView {
        let view = UIView.init()
        return view
    }
    func collectionHorizontalView(baseView: CGXHorizontalCollectionView, footerView: CGXHorizontalCollectionFooterView, At indexPath: IndexPath) -> UIView {
        let view = UIView.init()
        return view
    }
}


