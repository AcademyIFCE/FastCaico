//
//  MeatTableViewCell.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class MeatTableViewCell: UITableViewCell {

    @IBOutlet weak var meatImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(with dish: Chargeable) {
        self.meatImageView.image = UIImage(named: dish.image)
        self.titleLabel.text = dish.name
        self.descriptionLabel.text = dish.description
        self.priceLabel.text = "R$ \(dish.price)"
    }
    
}
