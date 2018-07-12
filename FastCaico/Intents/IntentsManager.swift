//
//  IntentsManager.swift
//  FastCaico
//
//  Created by Yuri on 12/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
import Intents

class IntentsManager {
    static let shared = IntentsManager()
    private init() {}
    
    
    func donateFoodOrder(order: FoodOrder) {
        let intent = OrderFoodIntent()
        intent.foodOrder = INObject(identifier: order.dish.name, display: order.dish.name)
        if let image = UIImage(named: order.dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "foodOrder")
        }
        donateIntent(intent: intent)
    }
    
    func donateMainDish(dish: MainDish) {
        let intent = OrderFoodIntent()
        intent.dish = INObject(identifier: dish.name, display: dish.name)
        if let image = UIImage(named: dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "foodOrder")
        }
        donateIntent(intent: intent)
    }
    
    
    private func donateIntent(intent: INIntent) {
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { error in
            if error != nil {
                print("There was a problem with your intent")
            } else {
                print("Intent donated")
            }
        }
    }
}
