//
//  FastCaicoNavigationController.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class FastCaicoNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backgroundColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        let caicoColor = UIColor(named: "caicoBlue")
        self.navigationBar.tintColor = caicoColor
        let textAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: caicoColor ?? .black]
        self.navigationBar.titleTextAttributes = textAttributes

    }
}
