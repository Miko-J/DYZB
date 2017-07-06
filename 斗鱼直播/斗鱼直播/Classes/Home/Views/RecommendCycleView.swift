//
//  RecommendCycleView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/7/3.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

fileprivate let KRecommendCycleView = "KRecommendCycleView"
class RecommendCycleView: UIView {
    
    //mark: -定义定时器
    var cycleTimer : Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleModels : [CycleModel]? {
    didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
        
            //初始滚动位置
            let originIndex = IndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: originIndex as IndexPath, at: .left, animated: false)
        
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    //mark: -系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: KRecommendCycleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//mark: - UICollectionViewDataSource
extension RecommendCycleView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KRecommendCycleView, for: indexPath) as! CollectionCycleCell
        //赋值
        cell.cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
       // cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
}
//mark: -UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //偏移量
        let scrollOffsetX = collectionView.contentOffset.x + collectionView.bounds.width * 0.5;
        pageControl.currentPage = (Int)(scrollOffsetX / collectionView.bounds.width) % (cycleModels?.count ?? 1)
    }
    //开始拖拽的时候移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    //结束拖拽的时候添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//mark: -定时器
extension RecommendCycleView{
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc func scrollToNext(){
        //计算偏移量
        let offsetX = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y: 0), animated: true)
    }
}
