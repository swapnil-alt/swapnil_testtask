//
//  LayerTableVC.swift
//  Measure Buddy
//
//  Created by WebvilleeMAC on 15/02/17.
//  Copyright © 2017 Ishan Gupta. All rights reserved.
//

import UIKit

class LayerTableVC: UITableViewController {
    
    var selectedLocation = ""
    var from = ""

    var listArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LayerTableWithImage") as? LayerTableWithImage
        if cell == nil
        {
            let tempArray = Bundle.main.loadNibNamed("LayerTableWithImage", owner: self, options: nil)!
            cell = tempArray.first as? LayerTableWithImage
        }
        let jsonDict = listArray[indexPath.row] as! NSDictionary

        cell?.lblName.text  = "\(jsonDict.value(forKey: "name") ??  "")"
        cell?.imgItem.image  = jsonDict.value(forKey: "image") as? UIImage
        cell?.selectionStyle = .none
        return cell!
//       let cell = UITableViewCell.init()
//        let jsonDict = listArray[indexPath.row] as! NSDictionary
//        print(jsonDict)
//
//        if from == "country" {
//
//            if selectedLocation == jsonDict.object(forKey: "countryName") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "countryName") as? String
//
//        }else if from == "category" {
//
//            if selectedLocation == jsonDict.object(forKey: "name") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "name") as? String
//
//        }else if from == "category_search" {
//            if selectedLocation == jsonDict.object(forKey: "cat_value") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "cat_value") as? String
//        }
//        else if from == "state" {
//
//            if selectedLocation == jsonDict.object(forKey: "name") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "name") as? String
//
//        }
//        else if from == "city" {
//
//            if selectedLocation == jsonDict.object(forKey: "name") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "name") as? String
//
//        }else if from == "priceFilter" {
//            if selectedLocation == jsonDict.object(forKey: "price_key") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "price_key") as? String
//        }else if from == "sortFilter" {
//            if selectedLocation == jsonDict.object(forKey: "sort_key") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "sort_key") as? String
//        }else if from == "distanceFilter" {
//            if selectedLocation == jsonDict.object(forKey: "distance_key") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "distance_key") as? String
//        }else{
//            if selectedLocation == jsonDict.object(forKey: "name") as! String
//            {
//                cell.accessoryType =  .checkmark
//            }
//            else
//            {
//                cell.accessoryType =  .none
//            }
//            cell.textLabel?.text =  jsonDict.object(forKey: "name") as? String
//        }
//        cell.textLabel?.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
//
//        // Configure the cell...
//      cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//      cell.textLabel?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
//      cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
//      cell.selectionStyle = .none
//        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let jsonDict = listArray[indexPath.row] as! NSDictionary
        
        if from == "" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Singleton.shared.LOCATION_SELECTED), object: jsonDict)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Singleton.shared.LOCATION_SELECTED), object: [jsonDict,from])
        }
        self.dismiss(animated: false, completion: nil)

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
