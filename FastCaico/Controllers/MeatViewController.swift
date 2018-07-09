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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let meatNib = UINib(nibName: "MeatTableViewCell", bundle: Bundle.main)
        self.tableView.register(meatNib, forCellReuseIdentifier: cellIdentifier)
        
        
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
    
}
