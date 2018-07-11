//
//  GarnishViewController.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class GarnishViewController: BaseViewController {

    @IBOutlet weak var garnishTableView: UITableView!
    @IBOutlet weak var orderSummaryView: OrderSummaryView!
    
    
    var mainDish: MainDish!
    @objc dynamic var foodOrder: FoodOrder!
    
    let garnishes = Garnish.all()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainDish = MainDish(withName: "Picanha", andPrice: 19.50)
        self.foodOrder = FoodOrder(with: mainDish)
        self.garnishTableView.delegate = self
        self.garnishTableView.dataSource = self
        self.orderSummaryView.delegate = self
        self.orderSummaryView.foodOrder = foodOrder
        
        self.garnishTableView.register(GarnishTableViewCell.self)
        self.garnishTableView.registerHeader(FastCaicoHeaderView.self)
    }

}


extension GarnishViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garnishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let garnish = garnishes?[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GarnishTableViewCell
        cell.delegate = self
        cell.setup(with: garnish, andFoodOrder: foodOrder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeader() as FastCaicoHeaderView
        headerView.titleLabel.text = "2 Escolha os acompanhamentos:"
        headerView.subtitleLabel.text = "Selecione de 1 a 4 acompanhamentos"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.applyShadowToHeader(garnishTableView)
    }
}

extension GarnishViewController : OrderSummaryViewDelegate {
    func titleForOrderSummaryView() -> String? {
        return "Acompanhamentos"
    }
    
    
    func orderSumaryView(_ orderView: OrderSummaryView, didTouchActionView view: UIView) {
        
    }
    
    func subtitleForActionView() -> String? {
        return String(format: "R$ %.2f", mainDish.price).replacingOccurrences(of: ".", with: ",")
    }
    
    func titleForActionView() -> String? {
        return "Adicionar"
    }
}

extension GarnishViewController : GarnishTableViewCellDelegate {
    
    func garnishTableViewCell(_ cell: GarnishTableViewCell, didChangeSelectionForGarnishNamed name: String, withValue value: Int) {
        
        if foodOrder.garnishes[name] == nil {
            foodOrder.garnishes[name] = value
        } else if let actualValue = foodOrder.garnishes[name], actualValue + value > 0 {
            foodOrder.garnishes[name] = actualValue + value
        } else {
            foodOrder.garnishes[name] = nil
        }
        
    }
    
    
}
