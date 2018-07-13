//
//  OrderFoodIntentHandler.swift
//  FastCaico
//
//  Created by Yuri on 13/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
import Intents

class OrderFoodIntentHandler: NSObject, OrderFoodIntentHandling {
    func handle(intent: OrderFoodIntent, completion: @escaping (OrderFoodIntentResponse) -> Void) {
        let dish = MainDish.all()?.filter { $0.name == intent.identifier }.first
        guard let chooseDish = dish else { return }
        let garnishesController = GarnishViewController(dish: chooseDish)
        guard let root = UIApplication.shared.keyWindow?.rootViewController else { return }
        root.navigationController?.pushViewController(garnishesController, animated: false)
        completion(OrderFoodIntentResponse(code: .success, userActivity: nil))
    }
}
