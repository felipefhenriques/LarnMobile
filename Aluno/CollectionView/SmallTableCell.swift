//
//  SmallTableCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 08/11/20.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "SmallTableCell"

    let name = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true

        let stackView = UIStackView(arrangedSubviews: [imageView, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

    func configure(with aula: App) {
        name.text = aula.name
        imageView.image = UIImage(named: aula.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
