//
//  SelectGarnishesIntentHandler.swift
//  FastCaico
//
//  Created by Yuri on 13/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
import Intents

class SelectGarnishesIntentHandler: NSObject, SelectGarnishesIntentHandling {
    func handle(intent: SelectGarnishesIntent, completion: @escaping (SelectGarnishesIntentResponse) -> Void) {
        let dish = MainDish.all()?.filter { $0.name == intent.dish?.identifier }.first
        guard let chooseDish = dish else { return }
        let nav = UINavigationController(rootViewController: MeatViewController())
        let garnishesController = GarnishViewController(dish: chooseDish)
        guard let window = UIApplication.shared.keyWindow else { return }
        nav.pushViewController(garnishesController, animated: false)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        completion(SelectGarnishesIntentResponse(code: .success, userActivity: nil))
    }
}
