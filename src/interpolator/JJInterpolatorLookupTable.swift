//
//  JJInterpolatorLookupTable.swift
//
//  Created by Juan J LF on 3/24/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import Foundation
/**
   - An JJTimeInterpolator that use a Lookup table to compute an interpolation based on
        a given input.
 
*/
open class JJInterpolatorLookupTable : JJTimeInterpolator {
    
    private var mValues: [Float]
    private var mStepSize : Float
    
    public init(values: [Float]) {
        mValues = values
        mStepSize =  1 / Float(mValues.count - 1)
    }
    
    
    
    public func getInterpolation(input: Float) -> Float {
        if input >= 1 { return 1 }
        if input <= 0 { return 0 }
        
        //Calculate index - We use min with count - 2 to avoid IndexOutOfBound Exception
        // when we lerp (linearly interpolate) in the return statement
        let position = min( Int(input) * (mValues.count - 1) , mValues.count - 2)
        
        // Calculate values to account for small offsets as the lookup table has discrete values
        let quantized = Float(position) * mStepSize
        let diff = input - quantized
        let weight = diff / mStepSize
        
        
        //Linearly interpolate between the table values
        return mValues[position] + weight * ( mValues[position + 1] - mValues[position] )
        
    }
    
    
}
