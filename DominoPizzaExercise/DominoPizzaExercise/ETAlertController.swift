//
//  ETAlertController.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import Foundation
import UIKit

extension UIAlertController{
    static func goToWishList(_ menu: String, _ count: Int) -> UIAlertController {
        let alertController = UIAlertController(title: "장바구니에 담았습니다.", message: "\(menu) - \(count)개", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
    static func orderProducts(_ price: Int, _ okAction: UIAlertAction) -> UIAlertController {
        var message: String = ""
        singleton.share.cart.forEach{
            message += "\($0.name) - \($0.count)개\n"
        }
        message += "결제금액: \(price.toDecimalFormat())"
        let alertController = UIAlertController(title: "결제내역", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "돌아가기", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
    }
}
