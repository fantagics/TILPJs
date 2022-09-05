//
//  FoodTableViewCell.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/09.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    var resetValue = false
    var selfIndex: Int!
    let foodTitle = UILabel()
    let foodSubtitle = UILabel()
    let foodCount = UILabel()
    let countStepper = UIStepper()
    
    lazy var foodImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let titleStackView = UIStackView(arrangedSubviews: [foodTitle, foodSubtitle])
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(foodCount)
        contentView.addSubview(countStepper)
        
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        foodCount.translatesAutoresizingMaskIntoConstraints = false
        countStepper.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            foodImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            foodImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5),
            foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 5),
            titleStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.trailingAnchor.constraint(greaterThanOrEqualTo: foodCount.leadingAnchor, constant: 5),
            countStepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            countStepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodCount.trailingAnchor.constraint(equalTo: countStepper.leadingAnchor, constant: -5),
            foodCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        foodImageView.layer.cornerRadius = foodImageView.frame.width / 2
        foodTitle.font = .systemFont(ofSize: 18)
        foodSubtitle.font = .systemFont(ofSize: 14)
        foodCount.font = .systemFont(ofSize: 16)
        foodCount.text = "0개"
        titleStackView.axis = .vertical
        titleStackView.alignment = .leading
        titleStackView.distribution = .fill
        titleStackView.spacing = 2
        
        countStepper.autorepeat = true
        countStepper.minimumValue = 0
        countStepper.maximumValue = 100
        countStepper.addTarget(self, action: #selector(steperClicked), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func steperClicked(_ sender: UIStepper){
        foodCount.text = "\(Int(sender.value))개"
        shareData.st.foodCount[selfIndex] = Int(sender.value)
        NotificationCenter.default.post(name: Notification.Name("foddCountChanged"), object: nil)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
