//
//  GridDotsAnimation.swift
//  WAActivityIndicatorViewExample
//
//  Created by Wendy Abrantes on 03/10/2015.
//  Copyright © 2015 ABRANTES DIGITAL LTD. All rights reserved.
//

import UIKit

struct GridDotsAnimation: WAActivityIndicatorProtocol {
    
    func setupAnimationInLayer(layer: CALayer, size: CGFloat, tintColor: UIColor) {
        
        let nbColumn = 3
        let marginBetweenDot : CGFloat = 5.0
        let dotSize = (size - (marginBetweenDot * (CGFloat(nbColumn)  - 1))) / CGFloat(nbColumn)
      
        let dot = CAShapeLayer()
        dot.frame = CGRect(
            x: 0,
            y: 0,
            width:dotSize,
            height: dotSize)
        
        dot.path = UIBezierPath(ovalInRect: CGRect(x: 0, y:0, width: dotSize, height: dotSize)).CGPath
        dot.fillColor = tintColor.CGColor
        
        let replicatorLayerX = CAReplicatorLayer()
        replicatorLayerX.frame = CGRect(x: 0,y: 0,width: size,height: size)
        
        replicatorLayerX.instanceDelay = 0.3
        replicatorLayerX.instanceCount = nbColumn
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, dotSize+marginBetweenDot, 0, 0.0)
        replicatorLayerX.instanceTransform = transform
        
        let replicatorLayerY = CAReplicatorLayer()
        replicatorLayerY.frame = CGRect(x: 0, y: 0, width: size, height: size)
        replicatorLayerY.instanceDelay = 0.3
        replicatorLayerY.instanceCount = nbColumn
        
        var transformY = CATransform3DIdentity
        transformY = CATransform3DTranslate(transformY, 0, dotSize+marginBetweenDot, 0.0)
        replicatorLayerY.instanceTransform = transformY
        
        replicatorLayerX.addSublayer(dot)
        replicatorLayerY.addSublayer(replicatorLayerX)
        layer.addSublayer(replicatorLayerY)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [alphaAnimation(), scaleAnimation()]
        groupAnimation.duration = 1.0
        groupAnimation.autoreverses = true
        groupAnimation.repeatCount = HUGE
        
        dot.addAnimation(groupAnimation, forKey: "groupAnimation")
    }
    
    func alphaAnimation() -> CABasicAnimation{
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.fromValue = NSNumber(float: 1.0)
        alphaAnim.toValue = NSNumber(float: 0.3)
        return alphaAnim
    }
    func scaleAnimation() -> CABasicAnimation{
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        
        let t = CATransform3DIdentity
        let t2 = CATransform3DScale(t, 1.0, 1.0, 0.0)
        scaleAnim.fromValue = NSValue.init(CATransform3D: t2)
        let t3 = CATransform3DScale(t, 0.2, 0.2, 0.0)
        scaleAnim.toValue = NSValue.init(CATransform3D: t3)
        
        return scaleAnim
    }
}