//
//  JJInterpolatorDecelerate.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit


public class JJInterpolatorDecelerate: JJTimeInterpolator {
    
    private var mFactor : Float = 1.0
    public init() {}
   /**
    - Constructor
    
    - Parameters:
      - factor: Degree to which the animation should be eased. Setting
       factor to 1.0 produces y=x^2 parabola. Increasing factor above
       1.0 exaggerates the ease-in effect (i.e., it starts even
       faster and ends evens slower)
   */
    public init(factor: Float) {
       mFactor = factor
    }
       

    public func getInterpolation(input: Float) -> Float {
        return mFactor == 1 ? 1 - (1 - input) * (1 - input)
            : 1 - pow(1 - input, 2 * mFactor)
    }
    
    
}
