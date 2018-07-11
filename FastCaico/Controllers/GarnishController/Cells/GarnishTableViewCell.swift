//
//  GarnishTableViewCell.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

protocol GarnishTableViewCellDelegate: class {
    func garnishTableViewCell(_ cell: GarnishTableViewCell, didChangeSelectionForGarnishNamed name: String, withValue value: Int)
}
class GarnishTableViewCell: UITableViewCell {

    
    private enum AnimationMode {
        case inside
        case out
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak private var minusButton: UIButton!
    @IBOutlet weak private var plusButton: UIButton!
    
    weak var delegate: GarnishTableViewCellDelegate?
    
    private var auxLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private var numberOfGarnishes: Int = 0 {
        didSet {
            self.minusButton.alpha = numberOfGarnishes == 0 ? 0 : 1
            self.plusButton.alpha = numberOfGarnishes == 4 ? 0 : 1
        }
    }
    
    private var observer: NSKeyValueObservation?

    func setup(with garnish: Garnish?, andFoodOrder foodOrder: FoodOrder?) {
        self.nameLabel.text = garnish?.name
        
        observer = foodOrder?.observe(\.garnishes, options: .new, changeHandler: { [weak self](food, result) in
            self?.numberOfGarnishes =  result.newValue?.reduce(0) { $1.value + $0 } ?? 0
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.minusButton.alpha = 0
        self.addShadowTo(minusButton)
        self.addShadowTo(plusButton)
        
        
        
    }
    @IBAction func didTapPlusButton(_ sender: UIButton) {
        
        sender.isUserInteractionEnabled = false
        let actualValue = Int(self.quantityLabel.text ?? "0")!
        auxLabel.text = "\(actualValue + 1 )"
        self.delegate?.garnishTableViewCell(self, didChangeSelectionForGarnishNamed: self.nameLabel.text!, withValue: 1)
        self.fade(.inside)
        
        
    }
    
    @IBAction func didTapLessButton(_ sender: UIButton) {
        if let valueString = self.quantityLabel.text, let actualValue = Int(valueString), actualValue - 1 >= 0 {
            self.auxLabel.text = self.quantityLabel.text
            self.quantityLabel.text = "\(actualValue - 1 )"
            delegate?.garnishTableViewCell(self, didChangeSelectionForGarnishNamed: self.nameLabel.text!, withValue: -1)
            self.fade(.out)
        }
    }
    
    private func fade(_ mode: AnimationMode) {
        auxLabel.frame = self.quantityLabel.frame
        
        let initalOpacity: Float = mode == .inside ? 0 : 1
        let finalOpacity: Float = mode == .inside ? 1 : 0
        self.auxLabel.layer.opacity = initalOpacity
        if mode == .inside {
            auxLabel.frame.origin = CGPoint(x: quantityLabel.frame.origin.x, y: quantityLabel.frame.origin.y - CGFloat(30))
        }
        self.quantityLabel.superview?.addSubview(auxLabel)
        UIView.animate(withDuration: 0.25, animations: {
            switch mode {
            case .inside:
                self.auxLabel.frame = self.quantityLabel.frame
            case .out:
                self.auxLabel.frame.origin = CGPoint(x: self.quantityLabel.frame.origin.x, y: self.quantityLabel.frame.origin.y + CGFloat(30))
            }
            self.auxLabel.layer.opacity = finalOpacity
        }) { [weak self]_ in
            if mode == .inside {
                self?.plusButton.isUserInteractionEnabled = true
                self?.quantityLabel.text = self?.auxLabel.text
            }
        }
    }
    
    private func addShadowTo(_ button: UIButton) {
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.masksToBounds = false
    }
    
}
