//
//  Chargeable.swift
//  FastCaico
//
//  Created by Yuri on 05/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation

final class Chargeable: Ingredient {
    typealias Item = Chargeable
    
    var price: Float
    var description: String?
    var image: String
    
    init(withName name: String, imageName: String, price: Float ) {
        self.price = price
        self.image = name
        super.init(withName: name)
    }
    
}
