//
//  JJInterpolatorAnticipateOvershoot.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import Foundation


public class JJInterpolatorAnticipateOvershoot : JJTimeInterpolator {
    
    private var mTension : Float = 2.0 * 1.5
       
    public init() {}
    /**
    - Constructor

    - Parameters:
     - tension: Amount of anticipation/overshoot. When tension equals 0.0,
       there is no anticipation/overshoot and the interpolator becomes a simple
       acceleration/deceleration interpolator.
    */
    public init(tension: Float) {
        mTension = tension * 1.5
    }
      
    /**
     - Constructor

     - Parameters:
      - tension: Amount of anticipation/overshoot. When tension equals 0.0,
        there is no anticipation/overshoot and the interpolator becomes a simple
        acceleration/deceleration interpolator.
      - extraTension: Amount by which to multiply the tension. For instance,
        to get the same overshoot as a OvershootInterpolator with a tension of 2.0,
        you would use an extraTension of 1.5 .
     */
    public init(tension: Float, extraTension: Float) {
        mTension = tension * extraTension
    }
    
    private  func a(_ t: Float,_ s:Float) -> Float{
        return t * t * ( (s + 1) * t - s )
    }
    
    private  func o(_ t: Float,_ s:Float) -> Float{
           return t * t * ( (s + 1) * t + s )
    }
    
    public func getInterpolation(input: Float) -> Float {
        return input < 0.5 ? 0.5 * a(input * 2.0,mTension)
            : 0.5 * ( o(input * 2 - 2, mTension) + 2 )
    }
}
