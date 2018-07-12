//
//  FoodCartViewController.swift
//  FastCaico
//
//  Created by Yuri on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class FoodCartViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FoodCartTableViewCell.self)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        self.view.addSubview(table)
        return table
    }()
    
    lazy var orderConfirmationView: OrderSummaryView = {
        let view = OrderSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.view.addSubview(view)
        return view
    }()
    
    lazy var closeBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "closeButton"), style: .plain, target: self, action: #selector(dismissView))
        button.tintColor = .white
        return button
    }()
    
    private var totalAmount: String {
        get {
            let totalPrice = FoodCart.shared.foodOrders.reduce(0, { $0 + $1.dish.price})
            return String(format: "R$ %.2f", totalPrice).replacingOccurrences(of: ".", with: ",")
        }
    }
    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            //Table Constraints
            NSLayoutConstraint(item: table, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: table, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: table, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: table, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
            //OrderConfirmationView Constraints
            NSLayoutConstraint(item: orderConfirmationView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100),
            NSLayoutConstraint(item: orderConfirmationView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: orderConfirmationView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: orderConfirmationView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Style
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(named: "caicoBlue")
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItem = closeBarButton
        title = "Carrinho"
        
        self.view.sendSubviewToBack(table)
        orderConfirmationView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderConfirmationView.refresh()
        table.reloadData()
    }
    
    @objc func dismissView() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}


extension FoodCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoodCart.shared.foodOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FoodCartTableViewCell
        cell.setup(with: FoodCart.shared.foodOrders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .normal, title: nil) { (_ , _ , _) in
            DispatchQueue.main.async { [unowned self] in
                tableView.performBatchUpdates({
                    FoodCart.shared.foodOrders.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                    self.orderConfirmationView.refresh()
                }, completion: nil)
            }
        }
        
        deleteButton.backgroundColor = UIColor(named: "caicoWine")
        deleteButton.image = UIImage(named: "garbage")
        
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
}

extension FoodCartViewController: OrderSummaryViewDelegate {
    func orderSumaryView(_ orderView: OrderSummaryView, didTouchActionView view: UIView) {
        guard let order = FoodCart.shared.foodOrders.first else { return }
        self.navigationController?.pushViewController(OrderConfirmationViewController(order: order), animated: true)
        FoodCart.shared.makeOrder()
    }
    
    func subtitleForActionView() -> String? {
        return nil
    }
    
    func titleForActionView() -> String? {
        return "Pedir"
    }
    
    func titleForOrderSummaryView() -> String? {
        return "Total do pedido"
    }
    
    func titleForDescriptionLabel() -> String? {
        return totalAmount
    }
}
