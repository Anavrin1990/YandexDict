//
//  YandexSession.swift
//  YandexDict
//
//  Created by Dmitry on 10.01.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

protocol YandexSessionDelegate {
    func VC_getLangs(langsArray: Array<String>)
    func VC_lookUp(json: JSON)
    func VC_error(ac: UIAlertController)
}

class YandexSession {
    
    var delegate: YandexSessionDelegate?
    
    var langsArray: [String] = []
    
    func getLangs() {
        
        let langsUrl = "https://dictionary.yandex.net/api/v1/dicservice.json/getLangs?key=dict.1.1.20170109T091335Z.636366d14215d46e.657a56a291a5a3177836f33289aa6809df7b80fb"
        
        request(langsUrl).responseJSON { (response) in
            if(response.result.error == nil) {
                let langs = JSON(response.result.value!)
                
                for i in langs {
                    self.langsArray.append(i.1.stringValue)
                }
                DispatchQueue.main.async {
                    self.delegate?.VC_getLangs(langsArray: self.langsArray)
                }
            }else {
                print (response.result.error?.localizedDescription as Any)
                self.inetError(reason: "Отсутствует подключение к интернету")
            }
        }
    }
    
    func getURL (text: String, lang: String) {
        
        let body = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key="
        let key = "dict.1.1.20170109T091335Z.636366d14215d46e.657a56a291a5a3177836f33289aa6809df7b80fb"
        let url = body + key + "&lang=" + lang + "&text=" + text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        request(url).responseJSON { (response) in
            if(response.result.error == nil) {
                let resultJSON = JSON(response.result.value!)
                DispatchQueue.main.async {
                    self.delegate?.VC_lookUp(json: resultJSON)
                }
            }else {
                print (response.result.error?.localizedDescription as Any)
                self.inetError(reason: "Отсутствует подключение к интернету")
            }
        }
    }
    
    func inetError(reason: String) {
        
        let ac = UIAlertController(title: "Error", message: reason, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        self.delegate?.VC_error(ac: ac)
        
    }
    
    
}
