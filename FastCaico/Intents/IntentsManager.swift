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
    
    func removeAllIntents() {
        INInteraction.deleteAll { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func donateFoodOrder(order: FoodOrder) {
        let intent = order.intent
        donateIntent(intent: intent)
    }
    
    func donateMainDish(dish: MainDish) {
        let intent = SelectGarnishesIntent()
        intent.dish = INObject(identifier: dish.name, display: dish.name)
        intent.suggestedInvocationPhrase = "Pedir quentinha de \(dish.name)"
        if let image = UIImage(named: dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "dish")
        }
        donateIntent(intent: intent)
    }
    
    private func donateIntent(intent: INIntent) {
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.groupIdentifier = intent.isKind(of: OrderFoodIntent.self) ? "foodOrder" : "selectGarnishes"
        interaction.donate { error in
            if error != nil {
                print("There was a problem with your intent")
            } else {
                print("Intent \(interaction.groupIdentifier ?? "") donated")
            }
        }
    }
}
