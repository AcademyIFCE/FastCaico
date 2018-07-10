//
//  OrderSummaryView.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

protocol OrderSummaryViewDelegate: class {
    func doSomething()
}

class OrderSummaryView: UIView, NibLoadableView {
    var contentView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    
    weak var delegate: OrderSummaryViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        contentView = Bundle.main.loadNibNamed(OrderSummaryView.nibName, owner: self, options: nil)?.first as? UIView
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    override func awakeFromNib() {
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addToOrder)))
    }
    
    @objc func addToOrder() {
        print("deu bom vetim")
        delegate?.doSomething()
    }
}
