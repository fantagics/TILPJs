//
//  CategoryTableViewCell.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    let categoryImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoryImage.contentMode = .scaleToFill
        contentView.addSubview(categoryImage)
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImage.heightAnchor.constraint(equalToConstant: 100),
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

