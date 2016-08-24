//
//  BaseViewControllerAnimationTransiton.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/23/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit

open class BaseViewControllerAnimationTransiton : NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    let duration: TimeInterval

    private var _context: UIViewControllerContextTransitioning?

    public var fromViewController: UIViewController? {
        return _context?.viewController(forKey: .from)
    }

    public var toViewController: UIViewController? {
        return _context?.viewController(forKey: .to)
    }

    public init(presenting: Bool, withDuration duration: TimeInterval = 0.2) {
        self.isPresenting = presenting
        self.duration = duration
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let inView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        let completion: (Bool) -> (Void) = { finished in
            transitionContext.completeTransition(finished)
            self._context = nil
        }

        _context = transitionContext
        if self.isPresenting {
            self.present(view: toView, fromView: fromView, inView: inView, withDuration: duration, inContext: transitionContext, completion: completion)
        } else {
            self.dismiss(view: fromView, toView: toView, inView: inView, withDuration: duration, inContext: transitionContext, completion: completion)
        }
    }

    open func present(view: UIView?, fromView: UIView?, inView: UIView, withDuration duration: TimeInterval, inContext context: UIViewControllerContextTransitioning, completion: @escaping (Bool) -> (Void)) {
        print("Override \(#function) in subclass")
        completion(true)
    }

    open func dismiss(view: UIView?, toView: UIView?, inView: UIView, withDuration duration: TimeInterval, inContext context: UIViewControllerContextTransitioning, completion: @escaping (Bool) -> (Void)) {
        print("Override \(#function) in subclass")
        completion(true)
    }
}
