//
//  ViewController.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

class CategoryViewController: UIViewController {
    let category = ["슈퍼시드", "프리미엄", "클래식", "사이드디시", "음료", "피클소스"]

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTable()
        setUI()
    }

}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell else{fatalError()}
        
        cell.categoryImage.image = UIImage(named: category[indexPath.row])
        
        return cell
    }
}
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ProductViewController()
        nextVC.categoryString = category[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CategoryViewController{
    private func setTable(){
        //TableView-tableHeader
        let tableHeader = CategoryTableHeader() as UIView
        tableView.tableHeaderView = tableHeader
        tableView.tableHeaderView?.frame.size.height = CGFloat(200)
        //tableView
        tableView.dataSource = self
        tableView.delegate = self
        //tableView-cell
        tableView.rowHeight = CGFloat(100)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    private func setNavigation(){
        title = "Domino's Pizza"
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Domino's")
        navigationItem.backButtonTitle = "Domino's"
    }
    
    private func setUI(){
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
