//
//  Ingredient.swift
//  FastCaico
//
//  Created by Yuri on 05/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

class Ingredient: Codable, ActiveRecord {
    typealias Item = Ingredient
    var name: String
    
    init(withName name: String) {
        self.name = name
    }
}
