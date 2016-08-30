//
//  PhotoBrowserLayout.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/16.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit

class PhotoBrowserLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        // 1.设置layout相关属性
        itemSize = (collectionView?.bounds.size)!
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        // 2.collectionView相关属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
    }
}
