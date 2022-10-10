//
//  WishListViewController.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class WishListViewController: UIViewController {
    var totalPrice = 0
    
    let cartTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavi()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculation()
        cartTable.reloadData()
    }

}

extension WishListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleton.share.cart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTable.dequeueReusableCell(withIdentifier: "cartProductCell", for: indexPath) as? ProductTableViewCell else{fatalError()}
        
        cell.productImage.image = UIImage(named: singleton.share.cart[indexPath.row].name)
        cell.productTitle.text = singleton.share.cart[indexPath.row].name
        cell.productSubtitle.text = "주문수량: \(singleton.share.cart[indexPath.row].count)"
        cell.selectionStyle = .none
        
        return cell
    }
}
extension WishListViewController{
    func calculation(){
        totalPrice = 0
        singleton.share.cart.removeAll()
        singleton.share.superseed.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 10000 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
        singleton.share.premium.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 10000 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
        singleton.share.classic.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 10000 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
        singleton.share.sidedish.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 7000 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
        singleton.share.beverage.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 3000 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
        singleton.share.pickleSauce.forEach{
            guard let count = singleton.share.productNum[$0] else{return}
            if count > 0{
                totalPrice += 500 * count
                singleton.share.cart.append(Product(name: $0, count: count))
            }
        }
    }
    @objc func didTapDelList(_ sender: UIBarButtonItem){
        singleton.share.cart.removeAll()
        for (key, _) in singleton.share.productNum{
            singleton.share.productNum[key] = 0
        }
        cartTable.reloadData()
    }
    @objc func didTapOrder(_ sender: UIBarButtonItem){
        let okAction = UIAlertAction(title: "결제하기", style: .default, handler: {_ in
            singleton.share.cart.removeAll()
            for (key, _) in singleton.share.productNum{
                singleton.share.productNum[key] = 0
            }
            self.cartTable.reloadData()
        })
        present(UIAlertController.orderProducts(totalPrice, okAction), animated: true)
    }
}
extension WishListViewController{
    private func setNavi(){
        title = "Wish List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "목록 지우기", style: .plain, target: self, action: #selector(didTapDelList(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "주문", style: .plain, target: self, action: #selector(didTapOrder(_:)))
        
    }
    private func setUI(){
        cartTable.rowHeight = 100
        view.addSubview(cartTable)
        cartTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cartTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        cartTable.dataSource = self
        
        cartTable.register(ProductTableViewCell.self, forCellReuseIdentifier: "cartProductCell")
    }
}


