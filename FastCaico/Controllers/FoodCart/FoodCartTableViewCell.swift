//
//  FoodCartTableViewCell.swift
//  FastCaico
//
//  Created by Yuri on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class FoodCartTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var mainDishNameLabel: UILabel!
    @IBOutlet weak var garnishesLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setup(with order: FoodOrder) {
        foodImageView.image = UIImage(named: order.dish.image)
        mainDishNameLabel.text = order.dish.name
        garnishesLabel.text = "\(order.dish.description ?? "") \n 1 Pirão de queijo, 1 baião, 1 farofa, 1 salada crua"
        foodPriceLabel.text = String(format: "R$ %.2f", order.dish.price).replacingOccurrences(of: ".", with: ",")
    }
}
