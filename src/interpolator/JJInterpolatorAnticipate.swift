//
//  JJInterpolatorAnticipate.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit


public class JJInterpolatorAnticipate : JJTimeInterpolator {
    
    private var mTension : Float = 2.0
       
    public init() {}
    /**
    - Constructor

    - Parameters:
     - tension: Amount of anticipation. When tension equals 0.0,
       there is no anticipation and the interpolator becomes a simple
       acceleration interpolator
    */
    public init(tension: Float) {
        mTension = tension
    }
      
    
    public func getInterpolation(input: Float) -> Float {
        return input * input * ( (mTension + 1) * input - mTension )
    }
    
    
}
