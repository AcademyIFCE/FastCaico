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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.garnishTableView.delegate = self
        self.garnishTableView.dataSource = self
        
        self.garnishTableView.register(GarnishTableViewCell.self)
        self.garnishTableView.registerHeader(FastCaicoHeaderView.self)
        
    }

}


extension GarnishViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GarnishTableViewCell
        cell.nameLabel.text = "Baião"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeader() as FastCaicoHeaderView
        headerView.titleLabel.text = "2 Escolha os acompanhamentos:"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
