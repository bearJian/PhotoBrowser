//
//  PhotoBrowserViewCell.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/16.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewCell: UICollectionViewCell {
    var shop : Shop? {
        didSet {
            // 1.校验是否有值
            guard let shop = shop else {
                return
            }
            // 2.取出image
            var image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(shop.q_pic_url)
            if image == nil {
                image = UIImage(named: "empty_picture")
            }
            // 3.根据图片计算image的frame
            imageView.frame = calculateImageViewFrame(image)
            
            // 4.设置imageView的图片
            guard let url = NSURL(string: shop.z_pic_url) else {
                imageView.image = image
                return
            }
            
            imageView.sd_setImageWithURL(url, placeholderImage: image) { (image, _, _, _) -> Void in
                self.imageView.frame = self.calculateImageViewFrame(image)
            }
        }
    }
    // MARK:- 懒加载属性
   lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }

    // required : 如果有实现父类的某一个构造函数,那么必须同时实现使用required修饰的构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.addSubview(imageView)
    }
}


// MARK:- 根据图片计算imageView的frame
extension PhotoBrowserViewCell {
    func calculateImageViewFrame(image : UIImage) -> CGRect {
        let imageViewW  = UIScreen.mainScreen().bounds.width
        let imageViewH = imageViewW / image.size.width * image.size.height
        let x : CGFloat = 0
        let y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
        
        return CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
    }
}
