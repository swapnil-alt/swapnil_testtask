//
//  ListVC.swift
//  ProjectTask
//
//  Created by apple on 19/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import SDWebImage

class ListVC: UIViewController
{
    //MARK:Outlets
    @IBOutlet weak var tblView: UITableView!
    
    var builder = Builder()
   var products:RecommendedProducts!
    
    //MARK:Variables
   // var arrData = Array<Any>()
    var arrData:[RecommendedProducts] = []
    
    //MARK:View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Remove extra lines from table view
        tblView.tableFooterView = UIView()
        
        
        builder.productDetails { (response) in
            print(response)
            self.xyz(json: response)
        }
    }
    //MARK:Action mehtod
    @IBAction func actionVirtualCV(_ sender: ButtonClass)
    {
        sender.animateTouchUpInside
        {
            //code
            let vc = self.storyboard?.instantiateViewController(identifier: "VirtualCV") as! VirtualCV
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func xyz(json:Dictionary<String,Any>){
        let data = json["data"] as! [String:Any]
        let recommendedProduct = data["recommended_products"] as! [[String:Any]]
        recommendedProduct.forEach { (res) in
            products = RecommendedProducts.init(product_sale_price_normal_customer: res["product_sale_price_normal_customer"] as? Int, product_image_image_url: (res["product_image_image_url"] as! String), product_name: res["product_name"] as! String)
            arrData.append(products as RecommendedProducts)
        }
        
        print(arrData)
        DispatchQueue.main.async
            {
                Loader.sharedInstance.stopLoader()

            self.tblView.reloadData()
        }
       
    }
}

//MARK:-  TableViewDataSource And Delegate Methods :-

extension  ListVC : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as?  ListCell
        if cell == nil
        {
            let arr = Bundle.main.loadNibNamed("ListCell", owner: self, options: nil)
            cell = (arr?.first as! ListCell)
        }
        
        let obj = arrData[indexPath.row ?? 0]
        cell?.imgView?.sd_setImage(with: URL.init(string:"https://developer.webvilleedemo.xyz/browcery/" + "\(obj.product_image_image_url ?? "")"), placeholderImage:  #imageLiteral(resourceName: "1"))
        cell?.lblName.text! = obj.product_name ?? ""
        cell?.lblPrice.text! = "\(obj.product_sale_price_normal_customer ?? 0)"
        
        return cell!
    }
}


