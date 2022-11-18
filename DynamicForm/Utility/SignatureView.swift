//
//  SignatureView.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

@IBDesignable
open class SignatureView: UIView {

    @IBInspectable open var lineWidth: CGFloat = 3.0 {
        didSet {
            path.lineWidth = lineWidth
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var ctr: Int = 0
    
    var touches = [CGPoint](repeating: CGPoint(), count:5)
    
    var path = UIBezierPath() {
        didSet {
            path.lineJoinStyle = .round
            setNeedsDisplay()
        }
    }
    
    open var isEmpty: Bool {
        get {
            guard !self.path.isEmpty else {
                return true
            }
            return false
        }
    }
    
    /// AASignatureView - Interface View
    open override func prepareForInterfaceBuilder() {
        self.backgroundColor = UIColor(rgb: 0x2891B1)
    }
    
    /// Default draw function, will call on touch
    ///
    /// - Parameter rect: drawing view frame
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        lineColor.setStroke()
        path.stroke()
        setNeedsDisplay()
    }
    
    /// touchesBegan
    ///
    /// - Parameters:
    ///   - touch: Initial Touch
    ///   - event: touch event
    override open func touchesBegan(_ touch: Set<UITouch>, with event: UIEvent?) {
        let point = touch.first!.location(in: self)
        insertTouch(touch: point, at: 0)
        super.touchesBegan(touch, with: event)
        
    }
    
    /// touchesMoved
    ///
    /// - Parameters:
    ///   - touch: Moving touches
    ///   - event: touch event
    override open func touchesMoved(_ touch: Set<UITouch>, with event: UIEvent?)
    {
        let point = touch.first!.location(in: self) // It must come in any case
        
        guard ctr == 4 else {
            insertTouch(touch: point, at: ctr+1)
            return
        }
        
        touches[1] = path.moveWithCurve(a: touches[1], b: touches[2], c: touches[3], d: point)
        
        insertTouch(touch: point, at: 2)
        
        setNeedsDisplay()
        
        super.touchesMoved(touch, with: event)
    }
    
    /// touchesEnded
    ///
    /// - Parameters:
    ///   - touch: Last Touch
    ///   - event: touch event
    override open func touchesEnded(_ touch: Set<UITouch>, with event: UIEvent?) {
        guard ctr == 0 else {
            ctr = 0
            return
        }
        
        path.addDot(origin: touches.first!, size: lineWidth)
        setNeedsDisplay()
        super.touchesEnded(touch, with: event)
        
    }
    
    /// Clear the view
    open func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
    }
    
    /// Get captured view
    open var signature: UIImage? {
        guard !isEmpty else {
            return nil
        }
        return UIImage(view: self)
    }
    
    func insertTouch(touch: CGPoint, at index: Int) {
        ctr = index
        touches.insert(touch, at: ctr)
    }
    
}
