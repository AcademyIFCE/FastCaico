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
    
    func makeOrder() {
        foodOrders.forEach { IntentsManager.shared.donateMainDish(dish: $0.dish) }
        //Comunicate with server
        let category = "\(Int.random(in: 1..<10000))"
        // 30 segundos
        NotificationHandler.shared.createLocalNotificationWith(body: "Pedido recebido",
                                                               title: "Quase lá",
                                                               subtitle: "",
                                                               identifier: category, trigger: 30)
        // 1 minuto
        NotificationHandler.shared.createLocalNotificationWith(body: "Pedido sendo preparado",
                                                               title: "Aguenta que tá perto",
                                                               subtitle: "",
                                                               identifier: category, trigger: 60)
        //1 minuto e meio
        NotificationHandler.shared.createLocalNotificationWith(body: "O seu pedido está pronto pra buscar",
                                                               title: "Hora de matar a fome",
                                                               subtitle: "",
                                                               identifier: category, trigger: 90)
    }
}
