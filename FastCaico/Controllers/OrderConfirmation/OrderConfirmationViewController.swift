//
//  OrderConfirmationViewController.swift
//  FastCaico
//
//  Created by Yuri on 10/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit
//import Lottie

class OrderConfirmationViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let animatedView = UIView()
//    lazy var animatedView: LOTAnimationView = {
//        let anView = LOTAnimationView(name: "dishAnimation")
//        anView.translatesAutoresizingMaskIntoConstraints = false
//        anView.loopAnimation = true
//        return anView
//    }()
    
    lazy var confirmationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmOrder), for: .touchUpInside)
        button.setTitle("Beleza! :D", for: .normal)
        button.setTitleColor(UIColor(named: "caicoBlue"), for: .normal)
        button.backgroundColor = .white
        button.radius = 24
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pedido realizado com sucesso!"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Em até XY minutos o seu pedido estará pronto para a retirada no Caicó XYZ"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, detailsLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()
    
    lazy var wrapperStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [animatedView, textStackView, confirmationButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 32
        self.view.addSubview(stack)
        return stack
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            //Animated View
            NSLayoutConstraint(item: animatedView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: animatedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 150),
            //Title Label
            NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 170),
            NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 66),
            //Details Label
            NSLayoutConstraint(item: detailsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 266),
            NSLayoutConstraint(item: detailsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 66),
            //Confirmation Button
            NSLayoutConstraint(item: confirmationButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: confirmationButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 48),
            //Stack
            NSLayoutConstraint(item: wrapperStackView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: wrapperStackView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "caicoBlue")
//        animatedView.play()
    }
    
    
    @objc func confirmOrder() {
        
    }
}
