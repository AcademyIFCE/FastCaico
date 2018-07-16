//
//  OrderFoodIntentHandler.swift
//  FastCaico
//
//  Created by Yuri on 13/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
import os.log
import Intents

extension IntentHandler: OrderFoodIntentHandling {
    public func confirm(intent: OrderFoodIntent, completion: @escaping (OrderFoodIntentResponse) -> Void) {
        os_log("Food Intent on handle")
        completion(OrderFoodIntentResponse(code: .ready, userActivity: nil))
    }
    
    public func handle(intent: OrderFoodIntent, completion: @escaping (OrderFoodIntentResponse) -> Void) {
        guard let order = FoodOrder(intent: intent) else {
            completion(OrderFoodIntentResponse(code: .failure, userActivity: nil))
            return 
        }
        FoodCart.shared.foodOrders.append(order)
        FoodCart.shared.makeOrder()
        completion(OrderFoodIntentResponse(code: .success, userActivity: nil))
    }
}

