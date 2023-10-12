//
//  UIVIew+Extension.swift
//  Swipe_to_action_button
//
//  Created by Viktor Golovach on 12.10.2023.
//

import UIKit

extension UIView {
    
    @discardableResult
    func rounded(_ radius: CGFloat, corners: CACornerMask) -> Self {
        corderRadius(radius, corners: corners)
        return self
    }
    
    func corderRadius(_ radius: CGFloat, corners: CACornerMask) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

extension CACornerMask {
    static let all: CACornerMask = [
        .layerMaxXMaxYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMinYCorner
    ]
    
    static let top: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner
    ]
    
    static let bottom: CACornerMask = [
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
    ]
    
    static let left: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
    ]
    
    static let right: CACornerMask = [
        .layerMaxXMinYCorner,
        .layerMaxXMaxYCorner
    ]
}
