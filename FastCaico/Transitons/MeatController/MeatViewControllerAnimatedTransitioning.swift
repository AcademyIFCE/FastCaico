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
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        container.backgroundColor = .white
        
        let width = fromView.frame.width
        let height = fromView.frame.height
        
        let defaultRect = CGRect(origin: toView.frame.origin, size: CGSize(width: width, height: height))
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
    
        let toInitialFrame = isPresenting ?  CGRect(x: 0, y: fromView.frame.origin.y + fromView.frame.height, width: width, height: height) : CGRect(x: 0, y: fromView.frame.origin.y - fromView.frame.height, width: width, height: height)
        
        let fromFinalFrame = isPresenting ? CGRect(x: 0, y: fromView.frame.origin.y - fromView.frame.height, width: width, height: height) : CGRect(x: 0, y: fromView.frame.origin.y + fromView.frame.height, width: width, height: height)
        
        toView.frame = toInitialFrame
        toView.layoutIfNeeded()
        fromView.layoutIfNeeded()

        
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//        
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, usingSpringWithDamping: <#T##CGFloat#>, initialSpringVelocity: <#T##CGFloat#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                toView.frame = defaultRect
                fromView.frame = fromFinalFrame
            })
            

            
            
            
        }, completion: { (sucess) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
//        UIView.animate(withDuration: duration, animations: {
//
//
////            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: 0, y: fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
////            detailView.alpha = self.isPresenting ? 1 : 0
//        }, completion: { (finished) in
//
//        })
        
//        guard let fromVC = transitionContext.viewController(forKey: .from) as? MeatViewController else  {
//            transitionContext.completeTransition(false)
//            return
//        }
//        guard let toVC = transitionContext.viewController(forKey: .to) as? GarnishViewController else {
//            transitionContext.completeTransition(false)
//            return
//        }
//        let duration = transitionDuration(using: transitionContext)
//        toVC.view.layer.opacity = 0
//        let container = transitionContext.containerView
//
//        var cells: Set<UIView?> = []
//
//        let selectedIndexPath = fromVC.tableView.indexPathForSelectedRow
//        let cellView = fromVC.tableView.cellForRow(at: selectedIndexPath!)?.snapshotView(afterScreenUpdates: true)
//
//        let fromViewSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
////        let fromTableViewCorrectedFrame = toVC.view.convert(fromVC.tableView.frame, to: toVC.view)
////        fromTableView?.frame = fromTableViewCorrectedFrame
////        fromVC.tableView.cellForRow(at: selectedIndexPath!)?.snapshotView(afterScreenUpdates: true)?.isHidden = true
//
//        container.addSubview(fromViewSnapshot!)
//        container.addSubview(cellView!)
//        container.addSubview(toVC.view)
//        cellView?.frame = auxiliaryFrame
//
//        if let navigationController = fromVC.navigationController {
//            cellView?.frame.origin = CGPoint(x: cellView!.frame.origin.x, y: cellView!.frame.origin.y + navigationController.navigationBar.frame.size.height)
//            fromViewSnapshot?.frame.origin = CGPoint(x: 0, y: fromViewSnapshot!.frame.origin.y + navigationController.navigationBar.frame.size.height + 20)
//        }
//
//
//        cellView?.layer.masksToBounds = true
//        cellView?.layer.shadowColor = UIColor.black.cgColor
//        cellView?.layer.shadowOpacity = 0.4
//        cellView?.layer.shadowRadius = 5
//        cellView?.clipsToBounds = false
//
//
//
//        fromVC.tableView.visibleCells.forEach { cells.insert($0.snapshotView(afterScreenUpdates: true)) }
//
//        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions.calculationModeCubic, animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 4/10, animations: {
//                cellView?.frame.origin = CGPoint(x: 0, y: 20)
//
//            })
//
//            UIView.addKeyframe(withRelativeStartTime: 4/10, relativeDuration: 1, animations: {
//                fromViewSnapshot?.layer.opacity = 0
//                toVC.view.layer.opacity = 1
//            })
//
//        }, completion: { (success) in
//            cellView?.removeFromSuperview()
//            fromViewSnapshot?.removeFromSuperview()
//            transitionContext.completeTransition(success)
//        })
        
        
        
    }
    

}
