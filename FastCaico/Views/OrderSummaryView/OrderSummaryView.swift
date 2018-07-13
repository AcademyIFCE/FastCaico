//
//  OrderSummaryView.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

protocol OrderSummaryViewDelegate: class {
    func orderSumaryView(_ orderView: OrderSummaryView, didTouchActionView view : UIView)
    func subtitleForActionView() -> String?
    func titleForActionView() -> String?
    func titleForOrderSummaryView() -> String?
    func titleForDescriptionLabel() -> String?
}

extension OrderSummaryViewDelegate {
    func titleForDescriptionLabel() -> String? {
        return nil
    }
}

class OrderSummaryView: UIView, NibLoadableView {
    var contentView: UIView!
    
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak private var titleAddViewLabel: UILabel!
    
    private var observer: NSKeyValueObservation?
    
    weak var delegate: OrderSummaryViewDelegate? {
        didSet {
            self.titleAddViewLabel.text = delegate?.titleForActionView()
            self.priceLabel.text = delegate?.subtitleForActionView()
            self.titleLabel.text = self.delegate?.titleForOrderSummaryView()
        }
    }
    
    weak var foodOrder: FoodOrder? {
        didSet {
            observer = foodOrder?.observe(\.garnishes, options: .new, changeHandler: { [weak self] (foodOrder, value) in
                self?.descriptionLabel.text = self?.formatGarnishDescription(for: value.newValue)
            })
        }
    }
    
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
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addToOrder)))
        self.addSubview(contentView)
    }

    @objc private func addToOrder() {
        delegate?.orderSumaryView(self, didTouchActionView: addView)
    }
    
    private func formatGarnishDescription(for garnishes: [String:Int]?) -> String? {
        guard let garnishes = garnishes else {
            return nil
        }
        
        let garnishesArray = garnishes.map { (garnish) in
            return "\(garnish.value) \(garnish.key)"
        }
        
        return garnishesArray.reversed().joined(separator: ", ")
    }
    
    func refresh() {
        self.titleAddViewLabel.text = delegate?.titleForActionView()
        self.priceLabel.text = delegate?.subtitleForActionView()
        self.titleLabel.text = self.delegate?.titleForOrderSummaryView()
        self.descriptionLabel.text = self.delegate?.titleForDescriptionLabel()
    }
}
