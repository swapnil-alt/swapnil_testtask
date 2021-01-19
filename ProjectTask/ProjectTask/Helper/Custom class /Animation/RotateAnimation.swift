//
//  RotateAnimation.swift
//  JobApp
//
//  Created by Sumit shaw on 4/1/18.
//  Copyright © 2018 WVMAC3. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class RotateAnimation: NSObject {

    func start(sender : Any){
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 2;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        (sender as AnyObject).layer.add(rotationAnimation, forKey: "rotationAnimation")
}

    func stop(sender : Any,status : Bool ,onCompletion: @escaping (Bool)-> Void){
        
        if status{// done
           (sender as AnyObject).setImage(#imageLiteral(resourceName: "tickIcon"), for: .normal)
            (sender as AnyObject).layer.removeAnimation(forKey: "rotationAnimation")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                // Your code with delay
                  onCompletion(status)
            }
            
        }else{ // error
                (sender as AnyObject).setImage(#imageLiteral(resourceName: "errorIcon"), for: .normal)
                (sender as AnyObject).layer.removeAnimation(forKey: "rotationAnimation")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                // Your code with delay
                onCompletion(status)
            }
        }
    }
}
