//
//  FoodOrder.swift
//  FastCaico
//
//  Created by Yuri on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

struct FoodOrder {
    var dish: MainDish
    var garnishes: [Garnish]
    var restaurant: String
    var waitTime: Int
    
    init(dish: MainDish, garnishes: [Garnish]) {
        self.dish = dish
        self.garnishes = garnishes
        self.restaurant = "Caicó Benfica"
        self.waitTime = 10
    }
}
