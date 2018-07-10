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
    
    private let dishes = Chargeable.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.tableView.register(MeatTableViewCell.asNib(), forCellReuseIdentifier: MeatTableViewCell.reuseIdentifier)
        self.tableView.register(FastCaicoHeaderView.asNib(), forHeaderFooterViewReuseIdentifier: FastCaicoHeaderView.reuseIdentifier)
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
        return dishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dish = dishes?[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MeatTableViewCell
        cell.setup(with: dish)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeader() as FastCaicoHeaderView
        headerView.titleLabel.text = "1 Escolha a carne"
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.applyShadowToHeader(tableView)
    }
    
    private func verifyShadowNeed() -> Bool {
        let cellHeight = self.tableView.visibleCells.first?.frame.height
        let contentOffSet = self.tableView.contentOffset
        
        return contentOffSet.y > cellHeight!/CGFloat(6)
    }
    
    private func applyShadowToHeader(_ tableView: UITableView) {
        if let header = self.tableView.headerView(forSection: 0) as? FastCaicoHeaderView {
            header.mustShowShadow = verifyShadowNeed()
        }
    }

}
