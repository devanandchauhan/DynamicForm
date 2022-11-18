//
//  StarRatingView.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

@IBDesignable
class StarRatingView: UIView {
    
    @IBInspectable var rating: Float = 0.0 {
        didSet {
            setStarsFor(rating: rating)
            value?(rating)
        }
    }
    
    @IBInspectable var starColor: UIColor = UIColor.systemOrange {
        didSet {
            for starImageView in [hstack?.star1ImageView, hstack?.star2ImageView, hstack?.star3ImageView, hstack?.star4ImageView, hstack?.star5ImageView] {
                starImageView?.tintColor = starColor
            }
        }
    }
    
    var value: ((Float) -> Void)?

    fileprivate var hstack: StarRatingStackView?

    fileprivate let fullStarImage: UIImage = UIImage(systemName: "star.fill")!
    fileprivate let halfStarImage: UIImage = UIImage(systemName: "star.lefthalf.fill")!
    fileprivate let emptyStarImage: UIImage = UIImage(systemName: "star")!

    
    convenience init(frame: CGRect, rating: Float, color: UIColor) {
        self.init(frame: frame)
        self.setupView(rating: rating, color: color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(rating: self.rating, color: self.starColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView(rating: 0.0, color: UIColor.systemOrange)
    }
    
    fileprivate func setupView(rating: Float, color: UIColor) {
        let bundle = Bundle(for: StarRatingStackView.self)
        let nib = UINib(nibName: "StarRatingStackView", bundle: bundle)
        let viewFromNib = nib.instantiate(withOwner: self, options: nil)[0] as! StarRatingStackView
        self.addSubview(viewFromNib)
        
        viewFromNib.translatesAutoresizingMaskIntoConstraints = false
        viewFromNib.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewFromNib.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewFromNib.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewFromNib.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.hstack = viewFromNib
        self.rating = rating
        self.starColor = color
        
        self.isMultipleTouchEnabled = false
        self.hstack?.isUserInteractionEnabled = false
    }
    
    fileprivate func setStarsFor(rating: Float) {
        let starImageViews = [hstack?.star1ImageView, hstack?.star2ImageView, hstack?.star3ImageView, hstack?.star4ImageView, hstack?.star5ImageView]
        for i in 1...5 {
            let iFloat = Float(i)
            starImageViews[i-1]!.image = rating >= iFloat-0.5 ? fullStarImage : emptyStarImage
        }
    }
    
    /// touchesBegan
    ///
    /// - Parameters:
    ///   - touch: Initial Touch
    ///   - event: touch event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: false)
    }
    
    /// touchesMoved
    ///
    /// - Parameters:
    ///   - touch: Moving touches
    ///   - event: touch event
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: true)
    }
    
    /// touchesEnded
    ///
    /// - Parameters:
    ///   - touch: Last Touch
    ///   - event: touch event
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touched(touch: touch, moveTouch: false)
    }
    
    var lastTouch: Date?
    fileprivate func touched(touch: UITouch, moveTouch: Bool) {
        guard !moveTouch || lastTouch == nil || lastTouch!.timeIntervalSince(Date()) < -0.1 else { return }
        guard let hs = self.hstack else { return }
        let touchX = touch.location(in: hs).x
        let ratingFromTouch = 5*touchX/hs.frame.width
        self.rating = Float(round(ratingFromTouch))
        lastTouch = Date()
    }
}
