//
//  MeatViewControllerAnimatedTransitioning.swift
//  FastCaico
//
//  Created by Davi Cabral on 11/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import UIKit

class MeatViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let auxiliaryFrame: CGRect
    let isPresenting: Bool
    
    init(withFrame frame:CGRect, isPresenting: Bool) {
        self.auxiliaryFrame = frame
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        container.backgroundColor = isPresenting ? UIColor(named: "caicocBlue") : .white
        
        let width = fromView.frame.width
        let height = fromView.frame.height
        
        let defaultRect = CGRect(origin: toView.frame.origin, size: CGSize(width: width, height: height))
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
    
        let toInitialFrame = isPresenting ?  CGRect(x: 0, y: fromView.frame.origin.y + fromView.frame.height, width: width, height: height) : CGRect(x: 0, y: fromView.frame.origin.y - fromView.frame.height, width: width, height: height)
        
        let fromFinalFrame = isPresenting ? CGRect(x: 0, y: fromView.frame.origin.y - fromView.frame.height, width: width, height: height) : CGRect(x: 0, y: fromView.frame.origin.y + fromView.frame.height, width: width, height: height)
        
        toView.frame = toInitialFrame
        toView.layoutIfNeeded()
        fromView.layoutIfNeeded()

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                toView.frame = defaultRect
                fromView.frame = fromFinalFrame
            })

        }, completion: { (sucess) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    

}
