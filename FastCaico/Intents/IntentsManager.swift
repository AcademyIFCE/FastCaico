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
        intent.dish = INObject(identifier: order.dish.name, display: order.dish.name)
        intent.garnishes = order.garnishesResume
        if let image = UIImage(named: order.dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "foodOrder")
        }
        donateIntent(intent: intent)
    }
    
    func donateMainDish(dish: MainDish) {
        let intent = SelectGarnishesIntent()
        intent.dish = INObject(identifier: dish.name, display: dish.name)
        if let image = UIImage(named: dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "dish")
        }
        donateIntent(intent: intent)
    }
    
    
    func routeToGarnishes(dish: INObject) -> UIViewController? {
        let controller = MeatViewController()
        let dish = MainDish.all()?.filter { $0.name == dish.identifier }.first
        guard let chooseDish = dish else { return nil}
        let garnishesController = GarnishViewController(dish: chooseDish)
        let navigation = FastCaicoNavigationController(rootViewController: controller)
        navigation.pushViewController(garnishesController, animated: false)
        return navigation
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
