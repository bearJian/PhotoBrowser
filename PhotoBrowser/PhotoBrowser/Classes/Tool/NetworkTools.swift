//
//  NetworkTools.swift
//  PhotoBrowser
//
//  Created by Dear on 16/5/15.
//  Copyright © 2016年 Dear. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {

    // 将类设计成单例对象
    static let shareIntance : NetworkTools = {
        let tool = NetworkTools()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()
    
    func loadHomeData(offset : Int,finishedCallback : (resultArray : [[String : NSObject]]?,error : NSError?) -> ()) {
        // 1.获取请求的URLString
    let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=\(offset)&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
    
        // 2.发送网络请求
        GET(urlString, parameters: nil, progress: nil, success: { (_, result) -> Void in
            
            // 1.将AnyObject?转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                print("没有拿到正确的数据")
                return
            }
            // 2.从字典中将数组取出
            let dictArry = resultDict["data"] as? [[String : NSObject]]
            
            // 将数据回调回去
            finishedCallback(resultArray: dictArry, error: nil)
            }) { (_, error) -> Void in
                finishedCallback(resultArray: nil, error: nil)
        }
    }
}
