//
//  Loader.swift
//  Singleton Class
//
//  Created by Aman Pathak on 8/2/17.
//  Copyright © 2017 Neuron Solutions Inc. All rights reserved.
//

import UIKit
import WebKit

class Loader: UIView {
    
    /**
     View declerations
     */
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loaderImg: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
    static let sharedInstance = Loader.initLoader()
    
    class func initLoader() -> Loader {
        
        return UINib(nibName: "Loader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Loader
    }
    
    
    override func awakeFromNib() {
        self.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
        //webView.setValue(true, forKey: "drawsTransparentBackground")
        
    }
    
    //MARK: show loader
    func showLoader(msg : String) {
        
//        let jeremyGif = UIImage.gifImageWithName("loaderImg")
//        loaderImg.image = jeremyGif
        
        let url = Bundle.main.url(forResource: "loader", withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: NSURL() as URL)
        
        //   print(UIApplication.sharedApplication.keyWindow?.rootViewController ?? "")
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.frame = UIScreen.main.bounds
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            //self.activityIndicatorView.startAnimating()
        }) { (finished) -> Void in
        }
    }
    
    //MARK: Stop loader
    func stopLoader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            // self.activityIndicatorView.stopAnimating()
            self.removeFromSuperview()
            
        }) { (finished) -> Void in
        }
    }
}

/*
 calling like :
 Loader.sharedInstance.showLoader(msg: "loading main view ")    //-->> Start Loader
 
 Loader.sharedInstance.stopLoader()          //-->> Stop loader
 
 */

