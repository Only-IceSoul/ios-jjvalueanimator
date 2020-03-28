//
//  TimeInterpolator.swift
//
//  Created by Juan J LF on 3/23/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import Foundation

public protocol JJTimeInterpolator {
    
    /**
     - Maps a value representing the elapsed fraction of an animation to a value that
       represents the interpolated fraction. this interpolated value is then multiplied
       by the change in value of an animation to derive the animated value at the current
       animation time.

     - Parameters:
      - input: A value between 0 and 1.0 indicating our current point
        in the animation where 0 represent the start and 1.0 represents
        the end.
    
     - return: The interpolation value. this value can be more than 1.0 for interpolators
       which overshoot their targets, or less that 0 for interpolators that undershoot
       their targets.
     */
    func getInterpolation(input: Float) -> Float
    
}
