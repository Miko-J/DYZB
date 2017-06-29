//
//  NetworkTools.swift
//  斗鱼直播
//
//  Created by niujinfeng on 2017/6/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

import UIKit
import Alamofire
//枚举
enum MethodType {
    case get
    case post
}

class NetworkTools{
    
    //封装网络请求框架Alamofire
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        //1.获取枚举类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //2.获取网络请求结果
            guard let resutlt = response.result.value else {
                print(response.result.error ?? "网络请求失败")
                return
            }
            //3.将结果回调出去
            finishedCallback(resutlt)
        }
    }
    
}
