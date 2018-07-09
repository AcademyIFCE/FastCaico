//
//  FastCaicoHeaderView.swift
//  FastCaico
//
//  Created by Davi Cabral on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class FastCaicoHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    var mustShowShadow: Bool = false {
        didSet {
            self.toggleShadow(mustShowShadow)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.shadowRadius = 1
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.contentView.layer.masksToBounds = false
    }
    
    private func toggleShadow(_ mustShow: Bool) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.contentView.layer.shadowOffset = CGSize(width: 0, height: mustShow ? 2 : 0)
            self?.contentView.layer.shadowRadius = mustShow ? 1 : 0
        }
    }
    

}
