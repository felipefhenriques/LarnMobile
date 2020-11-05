//
//  StarRating.swift
//  Larn
//
//  Created by Rogerio Lucon on 29/10/20.
//

import UIKit

class StarRating: UIView {
    
    private let starsImageView = UIImageView(image: UIImage(named: "estrela.png"))
    private(set) var value: NSNumber = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        
        backgroundColor = .clear
        starsImageView.frame = bounds
        mask = starsImageView

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [value, value, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]

        layer.insertSublayer(gradient, at: 0)
    }
    
    func setValue(value: CGFloat) {
        let value: CGFloat = min(value, 5.0)
        let percentValue: CGFloat = value / 5.0
        self.value = NSNumber(nonretainedObject: percentValue)
    }
}
