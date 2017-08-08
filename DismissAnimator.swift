//
//  DismissAnimator.swift
//  InteractiveModal
//
//  Created by ScofieldNguyen on 8/4/17.
//  Copyright © 2017 Thorn Technologies. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject {
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        else {
            return
        }
        // insert toVC below fromVC
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        toVC.view.alpha = 0
        
        // animation
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCornor = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCornor, size: screenBounds.size)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = finalFrame
            toVC.view.alpha = 1
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
