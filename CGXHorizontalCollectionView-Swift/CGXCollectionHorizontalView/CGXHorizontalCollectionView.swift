//
//  CGXHorizontalCollectionView.swift
//  CGXHorizontalCollectionView-Swift
//
//  Created by CGX on 2019/10/01.
//  Copyright © 2019年 CGX. All rights reserved.
//

import UIKit

typealias ShowCellBlock = (_ baseView: CGXHorizontalCollectionView ,_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell

typealias SelectCellBlock = (_ baseView: CGXHorizontalCollectionView,_ model:CGXHorizontalCollectionModel , _ indexPath: IndexPath) -> Void

typealias ScrollViewDidScrollBlock = (_ baseView: CGXHorizontalCollectionView,_ scrollView: UIScrollView) -> Void

typealias ShowHeaderBlock = (_ baseView: CGXHorizontalCollectionView ,_ headerViewAt:CGXHorizontalCollectionHeaderView,_ indexPath: IndexPath) -> UIView

typealias ShowFooterBlock = (_ baseView: CGXHorizontalCollectionView ,_ footerViewAt:CGXHorizontalCollectionFooterView,_ indexPath: IndexPath) -> UIView

class CGXHorizontalCollectionView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var showsVerticalScrollIndicator:Bool = false/*暂时水平 默认NO */
    var showsHorizontalScrollIndicator:Bool = false/*暂时垂直 默认NO */
    var bounces:Bool = false/*边距弹性 */
    var minimumLineSpacing: CGFloat = 10/*默认是10 */
    var minimumInteritemSpacing: CGFloat = 10/*默认是10 */
    var insets: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)/*默认是10,10,10,10 */
    var overFlowSpace: CGFloat = 20/* 一行溢出的item边距 */
    var row: Int = 3/*默认每行三个 */
    var section: Int = 1//默认一行
    
    var headerHeight: CGFloat = 0/*默认是0 */
    var footerHeight: CGFloat = 0/*默认是0 */
    lazy var headerColor:UIColor = { // 头分区颜色
        let color = UIColor.init(white: 0.93, alpha: 1)
        return color
    }()
    lazy var footerColor:UIColor = {// 脚分区颜色
        let color = UIColor.init(white: 0.93, alpha: 1)
        return color
    }()
    
    //实现代理
    open weak var delegate:CGXHorizontalCollectionViewDelegate?
    //点击的block
    fileprivate var selectCellBlock: SelectCellBlock?
    //展示的block
    fileprivate var cellForItemAtBlock: ShowCellBlock?
    //滚动block
    fileprivate var scrollViewBlock: ScrollViewDidScrollBlock?
    // 滚动方向
    fileprivate var scrollDirection:Bool = false
    //数据源。格式 @[xx,xx,xx,xx,xx,xx,xx]
    //数据源。 外界可读性 不可写入
    private(set)  lazy var dataArray: [CGXHorizontalCollectionModel] = [CGXHorizontalCollectionModel]()
    
    fileprivate func preferredFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        if (scrollDirection) {
            flowLayout.scrollDirection = .vertical;
        }else{
            flowLayout.scrollDirection = .horizontal;
        }
        return flowLayout
    }
    lazy var collectionView: UICollectionView = {
        let flowLayout = preferredFlowLayout();
        let  view = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: flowLayout)
        view.backgroundColor = self.backgroundColor;
        view.delegate = self;
        view.dataSource = self;
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell")
        view.register(CGXHorizontalCollectionCell.classForCoder(), forCellWithReuseIdentifier: "CGXHorizontalCollectionCell")
        view.register(CGXHorizontalCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CGXHorizontalCollectionHeaderView");
        view.register(CGXHorizontalCollectionFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CGXHorizontalCollectionFooterView");
        
        self.addSubview(view);
        return view
    }()
    open  func registerCell(_ classCell: AnyClass, isXib: Bool) {
        if !(classCell.self is UICollectionViewCell.Type) {
            assert(!(classCell.self is UICollectionViewCell.Type), "注册cell的必须是UICollectionViewCell类型")
        }
        if isXib {
            collectionView.register(UINib(nibName: "\(String(describing: classCell))", bundle: nil), forCellWithReuseIdentifier: "\(String(describing: classCell))")
        } else {
            collectionView.register(classCell, forCellWithReuseIdentifier: "\(String(describing: classCell))")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataArray = [CGXHorizontalCollectionModel]()
        self.delegate = self as CGXHorizontalCollectionViewDelegate
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.collectionView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - 数据源更新 数据初始化
extension CGXHorizontalCollectionView {
    //展示cell
    func cellForItemAtBlock(cellBlock:@escaping ShowCellBlock){
        cellForItemAtBlock = cellBlock
    }
    //点击cell
    func selectCellBlock(selectBlock:@escaping SelectCellBlock){
        selectCellBlock = selectBlock
    }
    //滚动
    func scrollViewBlock(scrollBlock:@escaping ScrollViewDidScrollBlock){
        scrollViewBlock = scrollBlock
    }
    // 横竖排列
    func scrollDirection(isVertical:Bool) -> Void {
        scrollDirection = isVertical
        self.collectionView.collectionViewLayout = preferredFlowLayout()
        self.collectionView.reloadData()
    }
    //更新数据
    func updateWithArray(dataArray:Array<CGXHorizontalCollectionModel>) -> Void {
        self.dataArray.removeAll()
        for model in dataArray {
            self.dataArray.append(model)
        }
        self.collectionView.reloadData()
    }
    
}
extension CGXHorizontalCollectionView {
    //分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumInteritemSpacing);
    }
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumLineSpacing);
    }
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wSpace:CGFloat = insets.left + insets.right
        let hSpace:CGFloat = insets.top + insets.bottom
        let KWinW:CGFloat = collectionView.bounds.size.width
        let KWinH:CGFloat = collectionView.bounds.size.height
        
        if scrollDirection {
            //cell width
            let item_W:CGFloat    =  (KWinW - wSpace - CGFloat(row-1) * minimumInteritemSpacing) / CGFloat(row)
            //cell height
            let item_H:CGFloat    =   (KWinH - hSpace - CGFloat(section-1) * minimumLineSpacing-overFlowSpace)/CGFloat(section)
            return CGSize.init(width: floor(item_W), height: floor(item_H))
        } else {
            //cell width
            let item_W:CGFloat    =  (KWinW - wSpace - CGFloat(row-1) * minimumInteritemSpacing-overFlowSpace) / CGFloat(row)
            //cell height
            let item_H:CGFloat    =   (KWinH - hSpace - CGFloat(section-1) * minimumLineSpacing)/CGFloat(section)
            return CGSize.init(width: floor(item_W), height: floor(item_H))
        }
    }
    //每个分区区头尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if scrollDirection {
            return  CGSize.init(width: 0, height: headerHeight)
        }
        return  CGSize.init(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if scrollDirection {
            return  CGSize.init(width: 0, height: footerHeight)
        }
        return  CGSize.init(width: 0, height: 0)
    }
    //返回区头、区尾实例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view:CGXHorizontalCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CGXHorizontalCollectionHeaderView", for: indexPath as IndexPath) as! CGXHorizontalCollectionHeaderView
            view.backgroundColor = footerColor
            for v in view.subviews {
                v.removeFromSuperview()
            }
            let headerView = (self.delegate?.collectionHorizontalView(baseView: self, HeaderView: view, At: indexPath))!
            headerView.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            headerView.backgroundColor = headerColor
            view.addSubview(headerView)
            return view;
        } else {
            let view:CGXHorizontalCollectionFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CGXHorizontalCollectionFooterView", for: indexPath as IndexPath) as! CGXHorizontalCollectionFooterView
            view.backgroundColor = footerColor
            for v in view.subviews {
                v.removeFromSuperview()
            }
            let footerView = (self.delegate?.collectionHorizontalView(baseView: self, footerView: view, At: indexPath))!
            footerView.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            footerView.backgroundColor = footerColor
            view.addSubview(footerView)
            return view;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellForItemAtBlock.self != nil {
            return cellForItemAtBlock!(self,collectionView,indexPath)
        }
        return (self.delegate?.collectionHorizontalView(baseView: self, collectionView, cellForItemAt: indexPath))!

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model:CGXHorizontalCollectionModel = self.dataArray[indexPath.row]
        if self.selectCellBlock != nil {
            self.selectCellBlock!(self,model,indexPath)
        }
        self.delegate?.collectionHorizontalView(baseView: self, model: model, didSelectRowAt: indexPath)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollViewBlock != nil {
            self.scrollViewBlock!(self,scrollView)
        }
        self.delegate?.collectionHorizontalView(baseView: self, scrollView: scrollView)
    }
}

protocol CGXHorizontalCollectionViewDelegate: AnyObject {
    /**代理函数 cell的显示 */
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView, HeaderView:CGXHorizontalCollectionHeaderView,At indexPath: IndexPath) -> UIView
    
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView, footerView:CGXHorizontalCollectionFooterView,At indexPath: IndexPath) -> UIView
    /*点击事件*/
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,model:CGXHorizontalCollectionModel, didSelectRowAt indexPath: IndexPath) -> Void
    
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,scrollView: UIScrollView) -> Void
}
/// 提供JXSegmentedViewDelegate的默认实现，这样对于遵从JXSegmentedViewDelegate的类来说，所有代理方法都是可选实现的。
extension CGXHorizontalCollectionView:CGXHorizontalCollectionViewDelegate {
    
   // *代理函数 cell的显示
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:CGXHorizontalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CGXHorizontalCollectionCell", for: indexPath) as! CGXHorizontalCollectionCell
        cell.contentView.backgroundColor = UIColor.white
        return cell;
    }
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView, HeaderView:CGXHorizontalCollectionHeaderView,At indexPath: IndexPath) -> UIView
    {
        return UIView.init()
    }
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView, footerView:CGXHorizontalCollectionFooterView,At indexPath: IndexPath) -> UIView
    {
        return UIView.init()
    }
    /*点击事件*/
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,model:CGXHorizontalCollectionModel, didSelectRowAt indexPath: IndexPath) -> Void
    {
        
    }
    func collectionHorizontalView(baseView:CGXHorizontalCollectionView,scrollView: UIScrollView) -> Void
    {
        
    }
}
