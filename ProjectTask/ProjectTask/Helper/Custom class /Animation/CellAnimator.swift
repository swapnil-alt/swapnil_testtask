//
//  CellAnimator.swift
//  JobApp
//
//  Created by WVMAC3 on 31/01/18.
//  Copyright © 2018 WVMAC3. All rights reserved.
//

import UIKit
import QuartzCore

open class CellAnimator {
    
    public static let TransformTipIn = { (layer: CALayer) -> CATransform3D in
        let rotationDegrees: CGFloat = -15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
        let offset = CGPoint(x: -20, y: -20)
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, rotationRadians, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, offset.x, offset.y, 0.0)
        
        return transform
    }
    
    public static let TransformCurl = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi)/2.0, 0.0, 1.0, 0.0)
        transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
        
        return transform
    }
    
    public static let TransformFan = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, -CGFloat(Double.pi)/2.0, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0, 0.0, 0.0)
        return transform
    }
    
    public static let TransformFlip = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi)/2.0, 1.0, 0.0, 0.0)
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        return transform
    }
    
    public static let TransformHelix = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0.0, layer.bounds.size.height/2.0, 0.0)
        transform = CATransform3DRotate(transform, CGFloat(Double.pi), 0.0, 1.0, 0.0)
        transform = CATransform3DTranslate(transform, 0.0, -layer.bounds.size.height/2.0, 0.0)
        return transform
    }
    
    public static let TransformTilt = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DScale(transform, 1.2, 1.2, 1.2)
        return transform
    }
    
    public static let TransformWave = { (layer: CALayer) -> CATransform3D in
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0, 0.0, 0.0)
        return transform
    }
    
    open class func animateCell(_ cell: UITableViewCell, withTransform transform: (CALayer) -> CATransform3D, andDuration duration: TimeInterval) {
        
        let view = cell.contentView
        view.layer.transform = transform(cell.layer)
        view.layer.opacity = 0.8
        
        UIView.animate(withDuration: duration, animations: {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        })
    }
    
    open class func animateCellCollectionView(_ cell: UICollectionViewCell, withTransform transform: (CALayer) -> CATransform3D, andDuration duration: TimeInterval) {
        
        let view = cell.contentView
        view.layer.transform = transform(cell.layer)
        view.layer.opacity = 0.8
        
        UIView.animate(withDuration: duration, animations: {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        })
    }
    
}

