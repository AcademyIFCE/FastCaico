//
//  FoodOrder.swift
//  FastCaico
//
//  Created by Yuri on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

@objcMembers class FoodOrder: NSObject {
    var dish: MainDish
    dynamic var garnishes: [String:Int] = [:]
    var garnishesResume: String {
        get {
            return garnishes.map {"\($0.value) \($0.key)" }
                .reversed()
                .joined(separator: ", ")
        }
    }
    var restaurant: String
    var waitTime: Int
    
    init(dish: MainDish) {
        self.dish = dish
        self.restaurant = "Caicó Benfica"
        self.waitTime = 10
    }
}
