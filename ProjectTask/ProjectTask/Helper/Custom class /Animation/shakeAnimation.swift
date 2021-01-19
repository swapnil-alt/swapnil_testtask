//
//  shakeAnimation.swift
//  JobApp
//
//  Created by WVMAC3 on 25/01/18.
//  Copyright © 2018 WVMAC3. All rights reserved.
//

import UIKit

extension CALayer {
    
    func shake(duration: TimeInterval = TimeInterval(0.5)) {
        
        let animationKey = "shake"
        removeAnimation(forKey: animationKey)
        
        let kAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        kAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        kAnimation.duration = duration
        
        var needOffset = frame.width * 0.15,
        values = [CGFloat]()
        
        let minOffset = needOffset * 0.1
        
        repeat {
            
            values.append(-needOffset)
            values.append(needOffset)
            needOffset *= 0.5
        } while needOffset > minOffset
        
        values.append(0)
        kAnimation.values = values
        add(kAnimation, forKey: animationKey)
    }
}

/*
 calling like this :
 [UIView, UILabel, UITextField, UIButton & etc].layer.shake(NSTimeInterval(0.7))
 */


