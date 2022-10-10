//
//  CategoryTableHeader.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class CategoryTableHeader: UITableViewHeaderFooterView {
    
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    
    override func draw(_ rect: CGRect) {
        logoImage.contentMode = .scaleAspectFit
        contentView.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}
