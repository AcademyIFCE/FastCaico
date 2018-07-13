//
//  FoodCartViewControllerAnimatedTransitioning.swift
//  FastCaico
//
//  Created by Davi Cabral on 13/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class FoodCartViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let initialFrame: CGRect
    private let color: UIColor
    private var transitionContext: UIViewControllerContextTransitioning?
    
    init(with frame: CGRect, andColor color: UIColor) {
        self.initialFrame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.origin.y + 64) , size: frame.size)
        self.color = color
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        
        toView.alpha = 0
        
        let frame = initialFrame
        let whiteAnimatedView = UIView(frame: frame)
        whiteAnimatedView.backgroundColor = color

        container.addSubview(whiteAnimatedView)
        
        container.addSubview(toView)
        
        let scale = CGAffineTransform(scaleX: toView.frame.width, y: toView.frame.height)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 7/10, animations: {
                whiteAnimatedView.transform = scale
                whiteAnimatedView.backgroundColor = UIColor(named: "caicoBlue")
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 6/10, relativeDuration: 1, animations: {
                toView.alpha = 1
            })
            
        }, completion: { (success) in
            whiteAnimatedView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
    }
}

