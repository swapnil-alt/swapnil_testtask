//
//  UITableViewClass.swift
//  Ticket_App
//
//  Created by WVMAC1 on 30/03/19.
//  Copyright © 2019 webvillee. All rights reserved.
//

import UIKit


extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
        self.reloadData()
    }
    
    func restore() {
        let vc =  UIView()
        vc.backgroundColor = UIColor.clear
        self.backgroundView = vc
        self.separatorStyle = .none
        self.tableFooterView = vc;
    }
    
    func setEmptyMessageInFooter(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 100))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        //messageLabel.sizeToFit()
        
        self.tableFooterView = messageLabel;
        self.separatorStyle = .none;
    }
}
extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        //self.separatorStyle = .none;
        self.reloadData()
    }
    
    func restore() {
        let vc =  UIView()
        vc.backgroundColor = UIColor.clear
        self.backgroundView = vc
        //self.separatorStyle = .none
    }
    
}

