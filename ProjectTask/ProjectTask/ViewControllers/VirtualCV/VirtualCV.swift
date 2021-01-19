//
//  VirtualCV.swift
//  ProjectTask
//
//  Created by apple on 19/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class VirtualCV: UIViewController
{
    //MARK:Outlets
    @IBOutlet weak var collViewSkills: UICollectionView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var collViewGallery: UICollectionView!
    
    //MARK:Variables
    var arrSkills = [["title":"HTML"],["title":"CSS"] , ["title":"JavaScript"],["title":"Git"] ,["title":"Photoshop"]]
    
    //MARK:View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collViewSkills.register(UINib.init(nibName: "CustomCCellSkills", bundle: nil), forCellWithReuseIdentifier: "CustomCCellSkills")
        
        
        collViewGallery.register(UINib.init(nibName: "CustomCCellGallery", bundle: nil), forCellWithReuseIdentifier: "CustomCCellGallery")


        // Do any additional setup after loading the view.
    }
    //MARK:Action method
    @IBAction func actionBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
extension VirtualCV : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func estimatedFrame(text: String, font: UIFont) -> CGRect
    {
        let size = CGSize(width: 200, height: 21) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
    //MARK: CollectinView methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let totalCell:CGFloat = 3.0
        let spaceBetweenCells:CGFloat = 2.0
        _ = (collectionView.bounds.size.width - max(0, totalCell - 1)*spaceBetweenCells)/totalCell
        //let dim = (collectionView.bounds.size.width - (totalCell - 1) * spaceBetweenCells) / totalCell;
        
        if collectionView == collViewGallery
        {
            return CGSize.init(width: 105 , height: 105)
        }
        
        let dictCell = arrSkills[indexPath.row] as NSDictionary
        
        let myString = "\(dictCell.value(forKey: "title") ?? "")"
        //let size: CGSize = myString.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
        
        let cell: CustomCCellSkills = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCCellSkills", for: indexPath) as! CustomCCellSkills
        
        // let width = self.estimatedFrame(text: myString, font: UIFont(name: "Nunito-Regular", size: 15)!).width //+ 75.0
        cell.lblTitle.text = myString
        
        let wid = cell.lblTitle.intrinsicContentSize.width
        
        //cell.viewBG.frame = CGRect.init(x: 0, y: 5, width: wid + 45, height: 34)
        
        return CGSize.init(width: wid + 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == collViewGallery
        {
            return 4
        }
        return arrSkills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == collViewSkills
        {
            let cell: CustomCCellSkills = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCCellSkills", for: indexPath) as! CustomCCellSkills
            
            let dictCell = arrSkills[indexPath.row] as NSDictionary
            
            cell.lblTitle.text = "\(dictCell.value(forKey: "title") ?? "")"
            
            return cell
            
        }
        let cell: CustomCCellGallery = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCCellGallery", for: indexPath) as! CustomCCellGallery

        cell.imgViewGallery.image = UIImage.init(named: "\(indexPath.row)")
        
        return cell
    }
}
