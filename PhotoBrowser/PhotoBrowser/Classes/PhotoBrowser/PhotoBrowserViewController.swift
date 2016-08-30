//
//  PhotoBrowserViewController.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/16.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit

class PhotoBrowserViewController: UIViewController {

    // MARK:- 定义属性
    var indexPath : NSIndexPath?
    var shops : [Shop]?
    let PhotoCellID = "PhotoCellID"
    
    // MARK:- 懒加载属性
    lazy var collection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserLayout())
    lazy var closeBtn : UIButton = UIButton()
    lazy var saveBtn : UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 3.设置图片与图片间的距离
        // 要先设置
        view.frame.size.width += 15
        
        // 1.添加子控件
        setupUI()
        
        // 2.滚动到对应的位置
        collection.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
        
        
    }
}

// MARK:- 设置UI界面的内容
extension PhotoBrowserViewController {
    func setupUI() {
        // 1.添加子控件
        view.addSubview(collection)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 2.设置子控件的frame
        collection.frame = view.bounds
        let margin : CGFloat = 20
        let btnW : CGFloat = 90
        let btnH : CGFloat = 32
        let y : CGFloat = UIScreen.mainScreen().bounds.height - btnH - margin
        closeBtn.frame = CGRectMake(margin, y, btnW, btnH)
        let x : CGFloat = UIScreen.mainScreen().bounds.width - btnW - margin
        saveBtn.frame = CGRectMake(x, y, btnW, btnH)
        
        // 3.设置btn相关属性
        prepareBtn()
        
        // 4.设置collectionView相关属性
        prepareCollectionView()
    }
    
    func prepareBtn() {
        setupBtn(closeBtn, title: "关闭", action: "closeBtnClick")
        setupBtn(saveBtn, title: "保存", action: "saveBtnClick")
    }
    
    func setupBtn(btn : UIButton, title : String, action : String) {
        btn.setTitle(title, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.backgroundColor = UIColor.darkGrayColor()
        // 监听事件
        btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
    }
    
    func prepareCollectionView() {
        // 设置数据源和代理
        collection.dataSource = self
        collection.delegate = self
        // 注册cell
        collection.registerClass(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoCellID)
        
    }
}

// MARK:- 监听事件
extension PhotoBrowserViewController {
    /*
    1.事件监听的本质:发送消息
    发送消息的过程: 1.将方法包装成SEL 2.去类中的方法列表中找到对应的方法 3.找到IMP的函数指针 4.执行函数
    2.在swift中,如果将一个函数修饰成private.那么该函数不会被放入到消息列表
    3.只有在private前加上@objc,那么该方法还是会被添加到消息列表
    */
    // private 只能在同一个源文件中访问
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   @objc private func saveBtnClick() {
    // 取出当前显示的图片
    let cell = collection.visibleCells().first as! PhotoBrowserViewCell
    guard let image = cell.imageView.image else {
        return
    }
    // 保存图片
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    
    // 提示保存成功
    let alerView = UIAlertView(title: "提示", message: "已保存到相册", delegate: nil, cancelButtonTitle: "确定")
    alerView .show()
    
    }
}

// MARK:- collectionView的数据源和代理方法
extension PhotoBrowserViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collection .dequeueReusableCellWithReuseIdentifier(PhotoCellID, forIndexPath: indexPath) as! PhotoBrowserViewCell
        // 设置cell内容
        cell.shop = shops![indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        closeBtnClick()
    }
}
