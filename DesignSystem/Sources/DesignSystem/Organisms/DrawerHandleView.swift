//
//  DrawerHandleView.swift
//  Mercari
//
//  Created by ooba on 07/03/2018.
//  Copyright © 2018 Mercari, Inc. All rights reserved.
//

import Foundation
import UIKit

class DrawerHandleView: UIView {
    
    static let defaultHandleColor: UIColor = .lightGray
    
    enum State {
        case up
        case neutral
        case down
    }
    
    var arrowSize: CGSize = CGSize(width: 30.0, height: 5.0) {
        didSet {
            setNeedsLayout()
            invalidateIntrinsicContentSize()
        }
    }
    
    var strokeWidth: CGFloat = 6.0 {
        didSet {
            shapeLayer.lineWidth = strokeWidth
            invalidateIntrinsicContentSize()
        }
    }
    
    var strokeColor: UIColor = DrawerHandleView.defaultHandleColor {
        didSet {
            shapeLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    private(set) var state: State = .neutral
    
    private var boundsUsedForCurrentPath: CGRect = .zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = strokeWidth
        shapeLayer.strokeColor = strokeColor.cgColor
    }
    
    func set(state: State, animated: Bool) {
        guard self.state != state else { return }
        
        self.state = state
        
        let newPath = path(for: bounds, state: state)
        
        let keyPath = "path"
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = shapeLayer.path
        shapeLayer.path = newPath.cgPath
        animation.toValue = shapeLayer.path
        animation.duration = animated ? 0.2 : 0.0
        shapeLayer.add(animation, forKey: keyPath)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width:arrowSize.width + strokeWidth,height:arrowSize.height + strokeWidth)
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    private var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if boundsUsedForCurrentPath != bounds {
            boundsUsedForCurrentPath = bounds
            shapeLayer.path = path(for: bounds, state: state).cgPath
        }
    }
    
    private func path(for bounds: CGRect, state: State) -> UIBezierPath {
        let arrowHeight = arrowSize.height
        let arrowSpan = CGSize(width: arrowSize.width / 2.0, height: arrowHeight / 2.0)
        
        let offsetMultiplier: CGFloat
        switch state {
        case .up:
            offsetMultiplier = -1
        case .neutral:
            offsetMultiplier = 0
        case .down:
            offsetMultiplier = 1
        }
        
        let centerY = bounds.midY + offsetMultiplier * arrowHeight / 2.0
        let centerX = bounds.midX
        let wingsY = centerY - offsetMultiplier * arrowHeight
        
        let center = CGPoint(x: centerX, y: centerY)
        let centerRight = CGPoint(x: centerX + arrowSpan.width, y: wingsY)
        let centerLeft = CGPoint(x: centerX - arrowSpan.width, y: wingsY)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: centerLeft)
        bezierPath.addLine(to: center)
        bezierPath.addLine(to: centerRight)
        return bezierPath
    }
}
