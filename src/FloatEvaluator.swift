//
//  FloatEvaluator.swift
//
//  Created by Juan J LF on 3/23/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

/**
   This evaluator can be used to perfom type interpolation between float values.
 */
public class FloatEvaluator {

    /**
      This function returns of linearly interpolating the start and end values, with
      fraction repesenting the proportion between the start and end values. The
      calculation is a simple parametric calculation: result = x0 + t * (v1 - v0)
      where is startValue , x1 is endValue, and t is fraction.
     
      - parameters:
         - fraction: The fraction from the starting to the ending values
         - startValue: The start value
         - endValue: The end value
      - return: A Linear interpolation between the start and end values, given the fraction.
     */
    public func evaluate(fraction:Float,startValue:Float,endValue:Float) -> Float {
        return startValue + fraction * (endValue - startValue)
    }
}
