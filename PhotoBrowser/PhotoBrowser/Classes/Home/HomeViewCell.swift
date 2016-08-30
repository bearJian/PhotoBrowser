//
//  HomeViewCell.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/16.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit
import SDWebImage
class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    var shop : Shop? {
        // 重写set
        didSet {
            // 校验模型是否有值
            guard let shop = shop else {
                return
            }
            // 取出图片的URL
            guard let url = NSURL(string: shop.q_pic_url) else {
                return
            }
            
            // 设置图片
            // 设置站位图片url
            let placeholderImage = UIImage(named: "empty_picture")
            imageV.sd_setImageWithURL(url, placeholderImage: placeholderImage)
        }
    }
}
