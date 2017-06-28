//
//  PageTitleView.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/26.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {//协议只能被类遵守
    func pageTitleView (titleView: PageTitleView, selecIndex index: Int)
}

fileprivate let KscrollLineH : CGFloat = 2
class PageTitleView: UIView {
    
    fileprivate var currentIndex : Int = 0
    
    //mark： -设置代理
    weak var delegate : PageTitleViewDelegate?
    //mark: -懒加载数组
    fileprivate lazy var titleLableArr : [UILabel] = [UILabel]()
    //mark: -懒加载scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    //mark: -懒加载scrollLine
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //mark: -定义属性
    fileprivate var titles: [String]
    //mark：-自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置ui
        setUpUI()
    }
    //mark: -自定义构造函数必须实现方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageTitleView{
    //mark: -设置ui
    fileprivate func setUpUI() {
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加lable
        setUpTitleLables()
        //添加下划线和滚动条
        setUpBottomLineAndScrollLine()
    }
    
    //添加4个lable
    fileprivate func setUpTitleLables() {
        
        let lableW  = frame.width / CGFloat (titles.count)
        let lableY : CGFloat = 0
        let lableH = frame.height - KscrollLineH
        
        for (index, title) in titles.enumerated() {
            let lable = UILabel()
            lable.text = title
            lable.font = UIFont.systemFont(ofSize: 16)
            lable.tag = index
            lable.textAlignment = .center
            lable.textColor = UIColor.black
            
            let lableX = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            titleLableArr.append(lable)
            scrollView.addSubview(lable)
            
            //添加手势
            lable.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(_:)))
            lable.addGestureRecognizer(tapGesture)
        }
    }
    
    
    fileprivate func setUpBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        
        let bottomLineH : CGFloat = 0.5
        let bottomLineY = frame.height - bottomLineH
        bottomLine.frame = CGRect(x: 0, y: bottomLineY, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)
        
        //获取第一个lable
        guard let firstLable = titleLableArr.first else {return}
        firstLable.textColor = UIColor.orange
        
        scrollLine.frame = CGRect(x: 0, y: frame.height - KscrollLineH, width: firstLable.frame.size.width, height: KscrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

extension PageTitleView{
    @objc fileprivate func titleLableClick(_ tapGes: UITapGestureRecognizer){
        
        guard let currentLable = tapGes.view as? UILabel else {return}
        
        let oldLable  = titleLableArr[currentIndex]
        
        //改变文字颜色
        oldLable.textColor = UIColor.darkGray
        currentLable.textColor = UIColor.orange
        
        currentIndex = currentLable.tag;
        
        //改变滚动条的位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selecIndex: currentIndex)
    }
}

