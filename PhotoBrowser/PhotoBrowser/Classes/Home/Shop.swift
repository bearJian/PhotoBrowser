//
//  Shop.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/15.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit

class Shop: NSObject {
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
