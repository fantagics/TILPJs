//
//  SingletonData.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/09.
//

import Foundation

class shareData{
    static let st: shareData = shareData()
    
    var foodCount = [0, 0, 0, 0]
}
