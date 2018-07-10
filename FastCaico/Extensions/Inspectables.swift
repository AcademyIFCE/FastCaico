//
//  Inspectables.swift
//  FastCaico
//
//  Created by Yuri on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

protocol Inspectables {
    var radius: CGFloat {get set}
}

extension UIView: Inspectables {
    @IBInspectable var radius: CGFloat {
        get {
            return self.radius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
}
