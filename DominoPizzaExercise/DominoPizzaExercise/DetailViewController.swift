//
//  DetailViewController.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class DetailViewController: UIViewController {
    var productTitile: String!
    
    let detailImage = UIImageView()
    let countView = UIView()
    let plusButton = UIButton()
    let minusButton = UIButton()
    let countLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        countLabel.text = String(singleton.share.productNum[productTitile]!) + " 개"
    }
    
}

extension DetailViewController{
    @objc func didTapPlusBtn(_ sender: UIButton){
        singleton.share.productNum[productTitile]! += 1
        countLabel.text = String(singleton.share.productNum[productTitile]!) + " 개"
    }
    @objc func didTapMinusBtn(_ sender: UIButton){
        if singleton.share.productNum[productTitile]! > 0{
            singleton.share.productNum[productTitile]! -= 1
            countLabel.text = String(singleton.share.productNum[productTitile]!) + " 개"
        }
    }
}

extension DetailViewController{
    private func setUI(){
        title = productTitile
        
        detailImage.image = UIImage(named: productTitile)
        countView.backgroundColor = .darkGray
        plusButton.setTitle("+", for: .normal)
        minusButton.setTitle("-", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        plusButton.backgroundColor = .white
        minusButton.backgroundColor = .white
        plusButton.contentHorizontalAlignment = .center
        minusButton.contentHorizontalAlignment = .center
        countLabel.font = UIFont.systemFont(ofSize: 16)
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        plusButton.addTarget(self, action: #selector(didTapPlusBtn), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(didTapMinusBtn), for: .touchUpInside)
        
        view.addSubview(detailImage)
        view.addSubview(countView)
        countView.addSubview(minusButton)
        countView.addSubview(countLabel)
        countView.addSubview(plusButton)
        
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        countView.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            detailImage.heightAnchor.constraint(equalToConstant: view.frame.width),
            countView.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 50),
            countView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            countView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            countView.heightAnchor.constraint(equalToConstant: 60),
            minusButton.topAnchor.constraint(equalTo: countView.topAnchor, constant: 5),
            minusButton.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -5),
            minusButton.leadingAnchor.constraint(equalTo: countView.leadingAnchor, constant: 5),
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.topAnchor.constraint(equalTo: countView.topAnchor, constant: 5),
            plusButton.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -5),
            plusButton.trailingAnchor.constraint(equalTo: countView.trailingAnchor, constant: -5),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 5),
            countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5)
        ])
    }
}
