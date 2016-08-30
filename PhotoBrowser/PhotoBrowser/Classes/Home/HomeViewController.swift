//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/15.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {

    // MARK:- 定义属性
    lazy var shops : [Shop] = [Shop]()
    
    var isPresented : Bool = false
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(0)
    }
}


extension HomeViewController {
    func loadData(offset : Int) {
        // 发送网络请求
        NetworkTools.shareIntance.loadHomeData(offset) { (resultArray, error) -> () in
            // 1.错误校验
            if error != nil {
                return
            }
            // 2.取出可选类型中的数据
            guard let resultArray = resultArray else{
                return
            }
            
            // 3.遍历数组,将数据中的字典转成模型对象
            for dict in resultArray {
                let shop = Shop(dict: dict)
                self.shops.append(shop)
            }
            // 4.刷新表格
            self.collectionView?.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.shops.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HomeViewCell
        
        // 2.设置数据
        cell.shop = shops[indexPath.row]
        
        // 3.加载更多数据
        if indexPath.row == shops.count - 1 {
            loadData(shops.count)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // 1.创建图片浏览控制器
        let  photoBrowser = PhotoBrowserViewController()
        
        // 2.设置控制器的属性
        photoBrowser.indexPath = indexPath
        photoBrowser.shops = shops
        
        // 3.设置photoBrowser的弹出动画
        photoBrowser.modalPresentationStyle = .Custom
        photoBrowser.transitioningDelegate = self
        
        // 4.弹出控制器
        presentViewController(photoBrowser, animated: true, completion: nil)
    }
}

// MARK:- 实现photoBrowser的转场代理方法
extension HomeViewController : UIViewControllerTransitioningDelegate {
    // 告诉弹出的动画交给谁去处理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        return self
    }
    
    // 告诉消失的动画交给谁去处理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        
        return self
    }
}

// MARK:- 实现photoBrowser的转场动画
extension HomeViewController : UIViewControllerAnimatedTransitioning {
    // 决定动画执行的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    // 决定动画如何实现
    // transitionContext : 可以通过转场上下文去获取弹出的View和即将消失的View
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            // 1.获取弹出的View
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            // 2.将弹出的view添加到containerView中
            transitionContext.containerView()?.addSubview(presentView)
            
            // 3.执行动画
            presentView.alpha = 0.0
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: { () -> Void in
                presentView.alpha = 1.0
                }) {(_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }else {
            // 1.取出消失的view
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            // 2.执行动画
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: { () -> Void in
                dismissView?.alpha = 0.0
                }, completion: { (_) -> Void in
                    dismissView?.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
    }
}
