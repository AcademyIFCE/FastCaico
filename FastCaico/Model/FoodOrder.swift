//
//  FoodOrder.swift
//  FastCaico
//
//  Created by Yuri on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation
import UIKit
import Intents

@objcMembers class FoodOrder: NSObject {
    var dish: MainDish
    dynamic var garnishes: [String:Int] = [:]
    var garnishesResume: String {
        get {
            return garnishes.map {"\($0.value) \($0.key)" }
                .reversed()
                .joined(separator: ", ")
        }
    }
    var restaurant: String
    var waitTime: Int
    
    lazy var intent: INIntent = {
        let intent = OrderFoodIntent()
        intent.dish = INObject(identifier: self.dish.name, display: self.dish.name)
        intent.garnishes = self.garnishesResume
        intent.price = NSNumber(value: self.dish.price)
        intent.image = self.dish.image
        intent.suggestedInvocationPhrase = "Pedir quentinha de \(self.dish.name)"
        if let image = UIImage(named: self.dish.image), let data = image.pngData() {
            intent.setImage(INImage(imageData: data), forParameterNamed: "dish")
        }
        return intent
    }()
    
    init(dish: MainDish) {
        self.dish = dish
        self.restaurant = "Caicó Benfica"
        self.waitTime = 10
    }
    
    public init?(intent: OrderFoodIntent) {
        let dish = MainDish.all()?.filter { $0.name == intent.dish?.identifier }.first
        guard let choosedDish = dish, let garnishes = intent.garnishes else { return nil }
        let garnishesParcialStrings = garnishes.split(separator: ",")
        var garnishesObject = [String: Int]()
        garnishesParcialStrings.forEach {
            var subStrings = $0.split(separator: " ")
            guard let quantitySub = subStrings.first else { return }
            var garnishSub = subStrings[1...].reduce("", { $0 + " " + $1 })
            garnishSub.remove(at: garnishSub.startIndex)
            guard let quantity = Int(String(quantitySub)) else { return }
            garnishesObject[garnishSub] = quantity
        }
        self.dish = choosedDish
        self.restaurant = "Caicó Benfica"
        self.waitTime = 10
        self.garnishes = garnishesObject
    }
}

extension FoodOrder {
    public static func ==(lhs: FoodOrder, rhs: FoodOrder) -> Bool {
        return lhs.dish.name == rhs.dish.name &&
                lhs.garnishes == rhs.garnishes
    }
}
