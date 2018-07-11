//
//  BaseViewController.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNavigationItem()
    }
    
    private func loadNavigationItem() {
        self.title = "Lauch Box"
        
        let image = UIImage(named: "car")
        let rightBarButtonItem = UIBarButtonItem(image: image!, style: .plain, target: self, action: #selector(loadShoppingCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func loadShoppingCart() {
        
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
