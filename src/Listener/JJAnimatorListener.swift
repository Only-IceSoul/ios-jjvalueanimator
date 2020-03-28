//
//  AnimatorListener.swift
//
//  Created by Juan J LF on 3/26/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit



public protocol JJAnimatorListener{

  
    /**
     * Notifies the start of the animation.
     *
     */
    func onAnimationStart(_ animation : JJAnimator)

    /**
     * Notifies the end of the animation. This callback is not invoked
     * for animations with repeat count set to INFINITE.
     *
     */
    func onAnimationEnd(_ animation : JJAnimator)

    /**
     * Notifies the cancellation of the animation. 
     *
     */
    func onAnimationCancel(_ animation : JJAnimator)

    /**
     * Notifies the repetition of the animation.
     *
     */
    func onAnimationRepeat(_ animation : JJAnimator)


}
