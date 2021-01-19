//
//  Model.swift
//  ProjectTask
//
//  Created by WV-mac3 on 19/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

struct RecommendedProducts {
    
    var product_sale_price_normal_customer:Int?
    var product_image_image_url:String?
    var product_name:String?
    
    init(product_sale_price_normal_customer:Int?, product_image_image_url:String?, product_name:String) {
        self.product_sale_price_normal_customer = product_sale_price_normal_customer
        self.product_image_image_url = product_image_image_url
        self.product_name = product_name
    }
}
