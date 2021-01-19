//
//  Builder.swift
//  ProjectTask
//
//  Created by WV-mac3 on 19/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation
import UIKit

class Builder {
    
    func productDetails(cb:@escaping(_ response: Dictionary<String,Any>)->Void) {

        let url = "https://developer.webvilleedemo.xyz/browcery/api/product_details?prod_id=32&store_id=1"
        let myUrl = URL(string: url)
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"
        Loader.sharedInstance.showLoader(msg: Constants.PLEASE_WAIT )
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error: Error?) in
            if data != nil {
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                cb(json!)
            }
        }
        task.resume()
    }
}
