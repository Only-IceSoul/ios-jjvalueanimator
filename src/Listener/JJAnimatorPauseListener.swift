//
//  JJAnimatorPauseListener.swift
//
//  Created by Juan J LF on 3/26/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import Foundation

/**
* A pause listener receives notifications from an animation when the
* animation is pause() paused or resume() resumed.
*
*/
 public protocol JJAnimatorPauseListener  {
    /**
    * Notifies that the animation was paused.
    *
    */
    func onAnimationPause(_ animation : JJAnimator )

    /**
    * Notifies that the animation was resumed, after being
    * previously paused.
    */
    func onAnimationResume(_ animation: JJAnimator)

}
