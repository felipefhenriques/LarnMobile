//
//  MediumTableCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 08/11/20.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "MediumTableCell"
    
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    let buyButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 10
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(with aula: App) {
        name.text = aula.name
        subtitle.text = aula.subheading
        imageView.image = UIImage(named: aula.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
