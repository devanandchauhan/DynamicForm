//
//  UIBezierPath+.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

extension UIBezierPath {
    
    /// Responsible to move and add curve after calculating mid point between two specified indexes.
    ///
    /// - Parameters:
    ///   - a: point 1
    ///   - b: point 2
    ///   - c: point 3
    ///   - d: point 4
    /// - Returns: Calculated mid point
    func moveWithCurve(a: CGPoint, b: CGPoint, c: CGPoint, d: CGPoint) -> CGPoint {
        
        var midPoint = a
        move(to: midPoint)
        midPoint = getMidPoint(a: c, b: d)
        addCurve(to: midPoint, controlPoint1: b, controlPoint2: c)
        return midPoint
    }
    
    
    /// Add point in current path at specified point
    ///
    /// - Parameters:
    ///   - origin: Point to insert dot
    ///   - size: size of dot for equal width and height
    func addDot(origin: CGPoint, size: CGFloat) {
        let rect = CGRect(origin: origin, size: CGSize(width: size, height: size))
        let dotPath = UIBezierPath(ovalIn: rect)
        append(dotPath)
        
    }
    
    /// Calculation of midpoint between two points
    ///
    /// - Parameters:
    ///   - a: point 1
    ///   - b: point 2
    /// - Returns: resultant midpoint
    fileprivate func getMidPoint(a: CGPoint, b: CGPoint) -> CGPoint {
        return CGPoint(x: (a.x + b.x)/2.0, y: (a.y + b.y)/2.0)
    }
}
