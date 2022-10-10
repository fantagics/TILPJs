//
//  ETInt.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import Foundation
import UIKit

extension Int{
    func toDecimalFormat()-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let price = formatter.string(for: self)else{
            return "Formatter Error"
        }
        return price + " 원"
    }
}
