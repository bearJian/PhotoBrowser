//
//  HomeCollectionViewLayout.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/15.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit

class HomeCollectionViewLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        
        // 1.计算一些常量和变量
        let margin : CGFloat = 10
        let itemWH = (UIScreen .mainScreen().bounds.width - 4 * margin) / 3
        
        // 2.设置布局
        itemSize = CGSizeMake(itemWH, itemWH)
        minimumInteritemSpacing = margin
        minimumLineSpacing = margin
        
        // 3.设置内边距
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64, left: margin, bottom: margin, right: margin)
    }
}
