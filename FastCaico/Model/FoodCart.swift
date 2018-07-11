//
//  FoodCart.swift
//  FastCaico
//
//  Created by Yuri on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

class FoodCart {
    static var shared = FoodCart()
    private init() {}
    
    var foodOrders = [FoodOrder]()
}
