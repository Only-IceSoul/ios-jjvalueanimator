//
//  JJInterpolatorCycle.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

/**
   Repeats the animation for a specified number of cycles. the
   rate of change follows a sinusoidal pattern.
 */
public class JJInterpolatorCycle : JJTimeInterpolator {
    
    private var mCycles : Float = 1
    
    public init(){}
    
    public init(cycles: Float) {
        mCycles = cycles
    }
    
    public func getInterpolation(input: Float) -> Float {
        if input >= 1 { return 0 }
        return sin(2 * mCycles * Float.pi * input)
    }
    
}
