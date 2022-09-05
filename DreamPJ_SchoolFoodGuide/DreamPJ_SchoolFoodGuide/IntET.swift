//
//  IntET.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/22.
//

import UIKit

extension Int{
    func toDecimalFormat()-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let price = formatter.string(for: self)else{
            return "Formatter Error"
        }
        return price
    }
}
