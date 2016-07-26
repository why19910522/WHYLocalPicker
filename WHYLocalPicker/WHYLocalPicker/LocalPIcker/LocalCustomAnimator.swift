//
//  LocalCustomAnimator.swift
//  WHYLocalPicker
//
//  Created by 王洪运 on 16/7/13.
//  Copyright © 2016年 王洪运. All rights reserved.
//

import UIKit

class LocalCustomAnimator: NSObject {

    private var isPresented = false

}

extension LocalCustomAnimator : UIViewControllerTransitioningDelegate {

    func presentationController(forPresentedViewController presented: UIViewController, presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
        return LocalPresentationController(presentedViewController: presented, presentingViewController: presenting!)
    }

    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }

}

extension LocalCustomAnimator : UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }

    /// 转场动画实现方法
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

    }

    /// 展现转场动画
    private func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {

    }

    /// 解除转场动画
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {

    }

}
