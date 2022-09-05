//
//  ViewController.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/08.
//

import UIKit

class ViewController: UIViewController {
    var resetValue = false
    var walletMoney = 0{
        willSet{ walletLabel.text = "\(newValue.toDecimalFormat())원" }
    }
    var payMoney = 0{
        willSet{ payLabel.text = "\(newValue.toDecimalFormat())원" }
    }
    
    lazy var tableView = UITableView()
    lazy var resetBtn = UIButton()
    lazy var walletLabel = UILabel()
    lazy var payLabel = UILabel()
    
//MARK: - LC
    override func viewDidLoad() {
        super.viewDidLoad()
      //image title
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
      //left bar item
        let chargeItem = UIBarButtonItem(title: "충전", style: .plain, target: self, action: #selector(chargeItemClicked))
        navigationItem.leftBarButtonItem = chargeItem
      //right bar item
        let paymentItem = UIBarButtonItem(title: "결제", style: .plain, target: self, action: #selector(paymentItemClicked))
        navigationItem.rightBarButtonItem = paymentItem
        
        let moneyView = UIView()
        let labelOne = UILabel()
        let labelTwo = UILabel()
        let labelStack = UIStackView(arrangedSubviews: [labelOne, labelTwo])
        let moneyStack = UIStackView(arrangedSubviews: [walletLabel, payLabel])
        let payStack = UIStackView(arrangedSubviews: [labelStack, moneyStack])
        
        view.addSubview(tableView)
        view.addSubview(resetBtn)
        view.addSubview(moneyView)
        moneyView.addSubview(payStack)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        moneyView.translatesAutoresizingMaskIntoConstraints = false
        payStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            resetBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moneyView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            moneyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moneyView.bottomAnchor.constraint(equalTo: resetBtn.topAnchor),
            payStack.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor),
            payStack.trailingAnchor.constraint(equalTo: moneyView.trailingAnchor, constant: -20)
        ])
        
        resetBtn.setTitle("초기화", for: .normal)
        resetBtn.setTitleColor(.red, for: .normal)
        resetBtn.titleLabel?.font = .systemFont(ofSize: 16)
        resetBtn.addTarget(self, action: #selector(resetBtnClicked(_:)), for: .touchUpInside)
        labelOne.text = "내 지갑:"
        labelTwo.text = "최종 결제금액"
        walletLabel.text = "\(walletMoney)원"
        payLabel.text = "\(payMoney)원"
        labelStack.axis = .vertical
        labelStack.alignment = .trailing
        labelStack.distribution = .fill
        labelStack.spacing = 15
        moneyStack.axis = .vertical
        moneyStack.alignment = .trailing
        moneyStack.distribution = .fill
        moneyStack.spacing = 15
        payStack.axis = .horizontal
        payStack.alignment = .trailing
        payStack.distribution = .fill
        payStack.spacing = 20
        
        tableView.dataSource = self
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "foodCell")
        tableView.rowHeight = view.frame.width / 5
        tableView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(sumOfPrice), name: Notification.Name("foddCountChanged"), object: nil)
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }

//MARK: - func
    @objc func chargeItemClicked(){
        self.present(rechargeAlertController(), animated: true, completion: nil)
    }
    
    @objc func paymentItemClicked(){
        if shareData.st.foodCount.reduce(0, +) == 0{
            self.present(UIAlertController.nothingToPay(), animated: true)
        }
        else if payMoney > walletMoney{
            self.present(UIAlertController.insuffientMoney(balance: payMoney - walletMoney), animated: true)
        }
        else{
            self.present(paymentAlertController(), animated: true)
        }
    }
    
    @objc func sumOfPrice(_ sender: Notification){
        var totalPrice = 0
        for idx in 0..<Menu.allCases.count {
            totalPrice += Menu.allCases[idx].price*shareData.st.foodCount[idx]
        }
        self.payMoney = totalPrice
    }
    
    @objc func resetBtnClicked(_ sender: UIButton){
        self.walletMoney = 0
        self.payMoney = 0
        for idx in 0..<shareData.st.foodCount.count{
            shareData.st.foodCount[idx] = 0
        }
        resetValue = !resetValue
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.allCases.count  //allCases : Menu의 배열화
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodTableViewCell else{fatalError()}
        
        cell.selectionStyle = .none
        cell.selfIndex = indexPath.row
        cell.foodImageView.image = Menu.allCases[indexPath.row].image
        cell.foodTitle.text = Menu.allCases[indexPath.row].title
        cell.foodSubtitle.text = Menu.allCases[indexPath.row].priceTag
        
        if self.resetValue != cell.resetValue{
            cell.resetValue = self.resetValue
            cell.countStepper.value = 0
            cell.foodCount.text = "0개"
        }
        
        return cell
    }
}

//alertController handler
extension ViewController{
    func paymentAlertController() -> UIAlertController{
        return UIAlertController.payment(totalPrice: payMoney, handler: { //[weak self] in
            self.walletMoney -= self.payMoney
            self.payMoney = 0
            for idx in 0..<shareData.st.foodCount.count{
                shareData.st.foodCount[idx] = 0
            }
            self.resetValue = !self.resetValue
            self.tableView.reloadData()
        })
    }
    
    func rechargeAlertController()-> UIAlertController{
        return UIAlertController.recharge(handler: {
            [weak self] amount in
            self?.walletMoney += amount
//            self.walletLabel.text = "\(self.walletMoney.toDecimalFormat())원"
        })
    }
}
