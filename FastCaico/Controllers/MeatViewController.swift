//
//  MeatViewController.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class MeatViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        self.view.addSubview(table)
        return table
    }()
    
    private let cellIdentifier = "MEAT_CELL"
    private let headerIdentifier = "MEAT_HEADER"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let meatNib = UINib(nibName: "MeatTableViewCell", bundle: Bundle.main)
        self.tableView.register(meatNib, forCellReuseIdentifier: cellIdentifier)
        
        let meatHeaderNib = UINib(nibName: "FastCaicoHeaderView", bundle: Bundle.main)
        self.tableView.register(meatHeaderNib, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate( [
                NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }

}

extension MeatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MeatTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? FastCaicoHeaderView else {
            return nil
        }
        headerView.titleLabel.text = "1 Escolha a carne"
        return headerView
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let header = self.tableView.headerView(forSection: 0) as? FastCaicoHeaderView {
            header.mustShowShadow = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let header = self.tableView.headerView(forSection: 0) as? FastCaicoHeaderView {
            header.mustShowShadow = false
        }
    }
    
}
