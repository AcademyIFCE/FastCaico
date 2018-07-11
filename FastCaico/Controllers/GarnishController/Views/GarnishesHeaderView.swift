//
//  GarnishesHeaderView.swift
//  FastCaico
//
//  Created by Davi Cabral on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class GarnishesHeaderView: UIView, NibLoadableView {

    @IBOutlet weak var mainDishImageView: UIImageView!
    @IBOutlet weak var mainDishNameLabel: UILabel!
    @IBOutlet weak var mainDishPriceLabel: UILabel!
    @IBOutlet weak var mainDishDescriptionLabel: UILabel!
    @IBOutlet weak var bottomArrowImageView: UIImageView!
    
    var contentView: UIView!
    
    private var mainDish: MainDish? {
        didSet {
            self.mainDishImageView.image = UIImage(named: mainDish!.image)
            self.mainDishNameLabel.text = mainDish?.name
            self.mainDishDescriptionLabel.text = mainDish?.description
            self.mainDishPriceLabel.text = String(format: "R$ %.2f", mainDish?.price ?? 0).replacingOccurrences(of: ".", with: ",")
        }
    }
    
    var isCollapsed: Bool = false {
        didSet {
            if oldValue != isCollapsed {
                self.animateHeader(isCollapsed)
            }
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
        contentView = Bundle.main.loadNibNamed(GarnishesHeaderView.nibName, owner: self, options: nil)?.first as? UIView
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.shadowRadius = 1
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.contentView.layer.masksToBounds = false
    }
    
    func setup(with dish: MainDish?) {
        self.mainDish = dish
    }
    
    
    private func animateHeader(_ collapse:Bool) {
        
        let fontSize: CGFloat = collapse ? 18 : 24
        UIView.animate(withDuration: 0.30) {
            self.mainDishDescriptionLabel.isHidden = collapse
            self.mainDishNameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            self.bottomArrowImageView.isHidden = collapse
        }

    }
    
    
    
}
