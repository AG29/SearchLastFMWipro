//
//  UIView.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import UIKit

extension UIView
{
    private static let kRotationAnimationKey = "rotationanimationkey"

    func startRotating(duration: Double = 1) {
        let timeInterval: CFTimeInterval = duration
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = timeInterval
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func rotate( degree : CGFloat ) {
        self.transform = CGAffineTransform(rotationAngle: degree)
        //self.transform = CGAffineTransformRotate(self.transform, degree)
    }

}

extension UIView
{
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T
    {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    func removeAllSubViews()
    {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
            
    class func loadNib() -> Self
    {
        return loadNib(self)
    }
            
    func copyView() -> UIView {
        
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! UIView
    }

    @objc var viewController : UIViewController?
    {
        var responder : UIResponder? = self
        repeat
        {
            if responder!.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
            else {
                responder = responder?.next
            }
        }
        while responder != nil
        return nil
    }

    @IBInspectable open var dropShadow : Bool  {
        
        set {
            layer.masksToBounds = !newValue
            layer.shadowColor = newValue ? UIColor.black.cgColor : UIColor.clear.cgColor
            layer.shadowOpacity = newValue ? 0.3 : 0.0
            layer.shadowOffset = CGSize(width: 0, height: 3) // right and bottom
            layer.shadowRadius = newValue ? 3 : 0
            layer.shouldRasterize = newValue
            layer.rasterizationScale = newValue ? UIScreen.main.scale : 1
            layer.cornerRadius = frame.size.height * 0.3
        }
        
        get {
            return layer.shouldRasterize
        }
    }
}
