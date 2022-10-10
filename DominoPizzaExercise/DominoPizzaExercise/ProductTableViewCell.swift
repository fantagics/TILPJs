//
//  ProductTableViewCell.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    let productImage = UIImageView()
    let productTitle = UILabel()
    let productSubtitle = UILabel()
    let labelStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productImage)
        labelStack.addArrangedSubview(productTitle)
        labelStack.addArrangedSubview(productSubtitle)
        contentView.addSubview(labelStack)
        
        productTitle.font = UIFont.systemFont(ofSize: 16)
        productSubtitle.font = UIFont.systemFont(ofSize: 14)
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.distribution = .equalSpacing
        labelStack.spacing = 5
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImage.widthAnchor.constraint(equalToConstant: 120),
            productImage.heightAnchor.constraint(equalToConstant: 120),
            labelStack.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 20),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            labelStack.centerYAnchor.constraint(equalTo: productImage.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
