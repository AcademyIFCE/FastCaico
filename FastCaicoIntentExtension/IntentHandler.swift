//
//  IntentHandler.swift
//  FastCaicoIntentExtension
//
//  Created by Yuri on 12/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}

extension IntentHandler: OrderFoodIntentHandling {
    func handle(intent: OrderFoodIntent, completion: @escaping (OrderFoodIntentResponse) -> Void) {
        let response = OrderFoodIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
}
