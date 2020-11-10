//
//  FeaturedCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 08/11/20.
//
import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "FeaturedCell"
    
    let tagline = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        name.font =  UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font =  UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [tagline, name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with aula: App) {
        tagline.text = aula.tagline.uppercased()
        name.text = aula.name
        subtitle.text = aula.subheading
        imageView.image = UIImage(named: aula.image)
    }
}
