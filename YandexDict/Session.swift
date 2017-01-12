//
//  Session.swift
//  YandexDict
//
//  Created by Dmitry on 10.01.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//protocol YandexSessionDelegate {
//    func lookup(langsArray: Array<String>)
//}
//
//
//class YandexSession {
//    
//    var delegate: YandexSessionDelegate?
//    
//    let mainVC = ViewController()
//    
//    var langsArray: [String] = []
//    
//    func getLangs() {
//        
//        let langsUrl = "https://dictionary.yandex.net/api/v1/dicservice.json/getLangs?key=dict.1.1.20170109T091335Z.636366d14215d46e.657a56a291a5a3177836f33289aa6809df7b80fb"
//        
//        request(langsUrl).responseJSON { (response) in
//            
//            let langs = JSON(response.result.value!)
//            
//            for i in langs {
//                self.langsArray.append(i.1.stringValue)
//            }
//            DispatchQueue.main.async {
//                self.delegate?.lookup(langsArray: self.langsArray)
//                self.mainVC.mainTableView.reloadData()                
//            }
//        }
//    }
//
//}
