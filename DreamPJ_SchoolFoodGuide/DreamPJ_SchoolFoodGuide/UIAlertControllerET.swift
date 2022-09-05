//
//  UIAlertControllerET.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/22.
//

import UIKit

extension UIAlertController{
    static func nothingToPay() -> UIAlertController {
        let alertController = UIAlertController(title: "상품 없음", message: "먼저 상품을 추가하세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
    
    static func insuffientMoney(balance: Int) -> UIAlertController{
        let alertController = UIAlertController(title: "잔액 부족", message: "\(balance.toDecimalFormat())원이 모자랍니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
    
    static func payment(totalPrice: Int, handler: @escaping ()-> Void)-> UIAlertController{
        let alertController = UIAlertController(title: "결제", message: "총\(totalPrice.toDecimalFormat())원을 결제 하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: {_ in handler() })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
    }
    
    static func recharge(handler: @escaping (Int)-> Void) -> UIAlertController{
        let alertController = UIAlertController(title: "지갑", message: "얼마를 충전할까요?", preferredStyle: .alert)
        alertController.addTextField{(textField) in
            textField.placeholder = "금액을 입력하세요."
            textField.keyboardType = .numberPad
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: {_ in
            guard let text = alertController.textFields?.first?.text, let amount = Int(text) else{return}
            handler(amount)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
        
    }
}
