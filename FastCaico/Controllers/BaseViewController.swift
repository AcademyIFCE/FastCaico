//
//  BaseViewController.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNavigationItem()
    }
    
    private func loadNavigationItem() {
        self.title = "Launch Box"
        
        let image = UIImage(named: "car")
        let rightBarButtonItem = UIBarButtonItem(image: image!, style: .plain, target: self, action: #selector(loadShoppingCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        
        let image = FoodCart.shared.foodOrders.isEmpty ? nil : UIImage(named: "car")
        self.navigationItem.rightBarButtonItem?.isEnabled = !FoodCart.shared.foodOrders.isEmpty
        self.navigationItem.rightBarButtonItem?.image = image
    }
    
    @objc private func loadShoppingCart() {
        let navigation = UINavigationController(rootViewController: FoodCartViewController())
        self.present(navigation, animated: true, completion: nil)
    }
    
    private func verifyShadowNeed(_ tableView: UITableView) -> Bool {
        let cellHeight = tableView.visibleCells.first?.frame.height
        let contentOffSet = tableView.contentOffset
        
        return contentOffSet.y > cellHeight!/CGFloat(6)
    }
    
    public func applyShadowToHeader(_ tableView: UITableView) {
        if let header = tableView.headerView(forSection: 0) as? FastCaicoHeaderView {
            header.mustShowShadow = verifyShadowNeed(tableView)
        }
    }


}
