//
//  UIView+BrandingManager.swift
//  DesignSample
//
//  Created by Anthony Smith on 13/09/2018.
//  Copyright © 2018 mercari. All rights reserved.
//

import Foundation
import UIKit

public protocol Highlightable {
    func set(for highlighted: Bool, selected: Bool)
}

public enum ShadowDirection {
    case up, down
}

extension CGColor {
    fileprivate static let shadowColor = UIColor.atom(.shadow).cgColor
}

extension CALayer {
    
    public func addShortShadow(_ direction: ShadowDirection = .down) {
        shadowColor = CGColor.shadowColor
        shadowOffset = CGSize(width: 0.0, height: direction == .up ? -1.0 : 1.0)
        shadowRadius = 2.0
        shadowOpacity = 0.1
    }

    public func addMediumShadow(_ direction: ShadowDirection = .down) {
        shadowColor = CGColor.shadowColor
        shadowOffset = CGSize(width: 0.0, height: direction == .up ? -4.0 : 4.0)
        shadowRadius = 3.0
        shadowOpacity = 0.06
    }
    
    public func addLongShadow(_ direction: ShadowDirection = .down) {
        shadowColor = CGColor.shadowColor
        shadowOffset = CGSize(width: 0.0, height: direction == .up ? -8.0 : 8.0)
        shadowRadius = 6.0
        shadowOpacity = 0.16
    }
    
    public func addInnerShadow(to sublayer: CALayer?) {
        guard let layer = sublayer else {
            let new = CALayer()
            addSublayer(new)
            addInnerShadow(to: new)
            return
        }
        
        layer.frame = CGRect(x: -2.0, y: 0.0, width: bounds.size.width + 4.0, height: bounds.size.height + 4.0)
        layer.cornerRadius = cornerRadius
        
        let roundedPath = UIBezierPath(roundedRect: layer.bounds.insetBy(dx: -1, dy: -1), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let reversePath = UIBezierPath(roundedRect: layer.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).reversing()
        roundedPath.append(reversePath)
        
        layer.shadowPath = roundedPath.cgPath
        layer.masksToBounds = true
        layer.shadowColor = CGColor.shadowColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
    }
    
    public func removeShadow() {
        shadowColor = nil
        shadowOffset = .zero
        shadowRadius = 0.0
        shadowOpacity = 0.0
    }
}

extension UIView {
    
    public func addShortShadow(_ direction: ShadowDirection = .down) { layer.addShortShadow(direction) }
    
    public func addMediumShadow(_ direction: ShadowDirection = .down) { layer.addMediumShadow(direction) }
    
    public func addLongShadow(_ direction: ShadowDirection = .down) { layer.addLongShadow(direction) }
   
    public func removeShadow() { layer.removeShadow() }
}
