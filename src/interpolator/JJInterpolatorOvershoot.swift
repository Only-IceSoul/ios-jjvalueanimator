//
//  JJInterpolatorOvershoot.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

public class JJInterpolatorOvershoot : JJTimeInterpolator {
    
    private let mTension : Float
    
    public init() { mTension = 2 }
    /**
      - Constructor
      - Parameters:
        - tension: Amount of overshoot. When tension equals 0, there is
          no overshoot and the interpolator becomes a simple deceleration interpolator
     */
    public init(tension: Float) { mTension = tension }
    
    
    public func getInterpolation(input: Float) -> Float {
        let t :Float = input - 1
        return t * t * ( (mTension + 1) * t + mTension ) + 1
    }
    
}
