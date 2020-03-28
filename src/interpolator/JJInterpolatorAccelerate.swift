//
//  JJInterpolatorAccelerate.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit



public class JJInterpolatorAccelerate : JJTimeInterpolator {
    

    private var mFactor : Float = 1.0
    private var mDoubleFactor : Float = 2.0
    public init() {}
    /**
     - Constructor
     
     - Parameters:
       - factor: Degree to which the animation should be eased. Setting
        factor to 1.0 produces y=x^2 parabola. Increasing factor above
        1.0 exaggerates the ease-in effect (i.e., it starts even
        slower and ends evens faster)
    */
    public init(factor: Float) {
        mFactor = factor
        mDoubleFactor = 2 * mFactor
    }

    public func getInterpolation(input: Float) -> Float {
        return mFactor == 1 ? input * input : pow(input,mDoubleFactor)
    }
    
    
}
