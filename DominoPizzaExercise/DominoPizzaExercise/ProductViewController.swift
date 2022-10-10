//
//  ProductViewController.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class ProductViewController: UIViewController {
    var categoryString: String!
    var selectedCategory = [String]()
    
    let productTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        currentCategory(categoryString)
        setUI()
    }
    
}

extension ProductViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTable.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell else{fatalError()}
        
        let string = selectedCategory[indexPath.row]
        cell.productImage.image = UIImage(named: string)
        cell.productTitle.text = string
        switch categoryString{
        case "슈퍼시드", "프리미엄", "클래식":
            cell.productSubtitle.text = 10000.toDecimalFormat()
        case "사이드디시":
            cell.productSubtitle.text = 7000.toDecimalFormat()
        case "음료":
            cell.productSubtitle.text = 3000.toDecimalFormat()
        case "피클소스":
            cell.productSubtitle.text = 500.toDecimalFormat()
        default:
            print("No Menu")
        }
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.productTitile = selectedCategory[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProductViewController{
    func currentCategory(_ string: String){
        switch string{
        case "슈퍼시드":
            selectedCategory = singleton.share.superseed
        case "프리미엄":
            selectedCategory = singleton.share.premium
        case "클래식":
            selectedCategory = singleton.share.classic
        case "사이드디시":
            selectedCategory = singleton.share.sidedish
        case "음료":
            selectedCategory = singleton.share.beverage
        case "피클소스":
            selectedCategory = singleton.share.pickleSauce
        default:
            fatalError()
        }
    }
}

extension ProductViewController{
    private func setUI(){
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backButtonTitle = categoryString
        
        view.addSubview(productTable)
        productTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        productTable.dataSource = self
        productTable.delegate = self
        
        productTable.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
    }
}
