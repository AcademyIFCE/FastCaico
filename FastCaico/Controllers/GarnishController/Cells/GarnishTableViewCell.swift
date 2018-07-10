//
//  GarnishTableViewCell.swift
//  FastCaico
//
//  Created by Davi Cabral on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

protocol GarnishTableViewCellDelegate: class {
    
}
class GarnishTableViewCell: UITableViewCell {

    
    private enum AnimationMode {
        case inside
        case out
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    weak var delegate: GarnishTableViewCellDelegate?
    
    private var auxLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    @IBAction func didTapPlusButton(_ sender: UIButton) {
        
        if let valueString = self.quantityLabel.text, let actualValue = Int(valueString) {
            auxLabel.text = "\(actualValue + 1 )"
            self.fade(.inside)
        }
        
    }
    
    @IBAction func didTapLessButton(_ sender: UIButton) {
        
        if let valueString = self.quantityLabel.text, let actualValue = Int(valueString), actualValue - 1 >= 0 {
            self.auxLabel.text = self.quantityLabel.text
            self.quantityLabel.text = "\(actualValue - 1 )"
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
        UIView.animate(withDuration: 0.5, animations: {
            switch mode {
            case .inside:
                self.auxLabel.frame = self.quantityLabel.frame
            case .out:
                self.auxLabel.frame.origin = CGPoint(x: self.quantityLabel.frame.origin.x, y: self.quantityLabel.frame.origin.y + CGFloat(30))
            }
            self.auxLabel.layer.opacity = finalOpacity
        }) { _ in
            if mode == .inside {
                self.quantityLabel.text = self.auxLabel.text
            }
        }

    }
    
}
