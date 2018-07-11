//
//  MainDish.swift
//  FastCaico
//
//  Created by Yuri on 05/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

struct MainDish: Codable, ActiveRecord {
    var name: String
    var description: String?
    var image: String
    var price: Float
    
    init(withName name: String, andPrice price: Float) {
        self.name = name
        self.image = ""
        self.price = price
    }
}
