//
//  JJInterpolatorProvider.swift
//
//  Created by Juan J LF on 3/23/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit
import Foundation

public class JJInterpolator : JJTimeInterpolator {
    
    private var mEase: Ease!

    public  init(ease: Ease){
      mEase = ease
    }

    public func getInterpolation(input: Float) -> Float {
      return get(ease: mEase, elapsedTimeRate: input)
    }

    public func getEase()-> Ease {
      return mEase
      
    }

   public enum Ease {
        case LINEAR
           , QUAD_IN
           , QUAD_OUT
           , QUAD_IN_OUT
           , CUBIC_IN
           , CUBIC_OUT
           , CUBIC_IN_OUT
           , QUART_IN
           , QUART_OUT
           , QUART_IN_OUT
           , QUINT_IN
           , QUINT_OUT
           , QUINT_IN_OUT
           , SINE_IN
           , SINE_OUT
           , SINE_IN_OUT
           , BACK_IN
           , BACK_OUT
           , BACK_IN_OUT
           , CIRC_IN
           , CIRC_OUT
           , CIRC_IN_OUT
           , BOUNCE_IN
           , BOUNCE_OUT
           , BOUNCE_IN_OUT
           , ELASTIC_IN
           , ELASTIC_OUT
           , ELASTIC_IN_OUT
           , EASE_IN_EXPO
           , EASE_OUT_EXPO
           , EASE_IN_OUT_EXPO
           , SPRING_BOUNCE_OUT
           , DECELERATE
           , ACCELERATE
           , ACCELERATE_DECELERATE
           , ANTICIPATE
           , ANTICIPATEOVERSHOOT
           , BOUNCE
           , FAST_OUT_LINEAR
           , FAST_OUT_SLOW_IN
           , OVERSHOOT
           , CYCLE
           , CYCLE_DOUBLE

    }
       
      private  func get(ease: Ease, elapsedTimeRate: Float)-> Float {
            let localElapsedTimeRate = elapsedTimeRate
            switch (ease) {
            case .LINEAR : return localElapsedTimeRate
            case .QUAD_IN : return getPowIn(localElapsedTimeRate, 2.0)
            case .QUAD_OUT : return getPowOut(localElapsedTimeRate, 2.0)
            case .QUAD_IN_OUT : return getPowInOut(localElapsedTimeRate, 2.0)
            case .CUBIC_IN : return getPowIn(localElapsedTimeRate, 3.0)
            case .CUBIC_OUT : return getPowOut(localElapsedTimeRate, 3.0)
            case .CUBIC_IN_OUT : return getPowInOut(localElapsedTimeRate, 3.0)
            case .QUART_IN : return getPowIn(localElapsedTimeRate, 4.0)
            case .QUART_OUT : return getPowOut(localElapsedTimeRate, 4.0)
            case .QUART_IN_OUT : return getPowInOut(localElapsedTimeRate, 4.0)
            case .QUINT_IN : return getPowIn(localElapsedTimeRate, 5.0)
            case .QUINT_OUT : return getPowOut(localElapsedTimeRate, 5.0)
            case .QUINT_IN_OUT : return getPowInOut(localElapsedTimeRate, 5.0)
            case .SINE_IN : return 1 - cos(localElapsedTimeRate * Float.pi / 2)
            case .SINE_OUT : return sin(localElapsedTimeRate * Float.pi / 2)
            case .SINE_IN_OUT : return (-0.5 * (cos(Float.pi * localElapsedTimeRate) - 1))
            case .BACK_IN : return
                   (localElapsedTimeRate * localElapsedTimeRate * ((1.7 + 1) * localElapsedTimeRate - 1.7))
            case .BACK_OUT :
                let it = localElapsedTimeRate - 1
                return (it * it * ((1.7 + 1) * it + 1.7) + 1)
            case .BACK_IN_OUT : return
                   getBackInOut(localElapsedTimeRate, 1.7)
            case .CIRC_IN : return
                   -(sqrt(1 - localElapsedTimeRate * localElapsedTimeRate) - 1)
            case .CIRC_OUT:
                let it = localElapsedTimeRate - 1
                return
                   sqrt(1 - it * it)
            case .CIRC_IN_OUT :
                let it = localElapsedTimeRate * 2
                let it2 = it - 2
                return it < 1 ? (-0.5 * (sqrt(1 - it * it) - 1))
                : (0.5 * (sqrt(1 - it2 * it2) + 1))
               
            case .BOUNCE_IN : return getBounceIn(localElapsedTimeRate)
            case .BOUNCE_OUT : return getBounceOut(localElapsedTimeRate)
            case .BOUNCE_IN_OUT :
                return  localElapsedTimeRate < 0.5 ? getBounceIn(localElapsedTimeRate * 2) * 0.5
                : getBounceOut(localElapsedTimeRate * 2 - 1) * 0.5 + 0.5
            case .ELASTIC_IN : return getElasticIn(localElapsedTimeRate, 1.0, 0.3)
            case .ELASTIC_OUT : return getElasticOut(localElapsedTimeRate, 1.0, 0.3)
            case .ELASTIC_IN_OUT : return getElasticInOut(localElapsedTimeRate, 1.0, 0.45)
            case .EASE_IN_EXPO :
                return pow(2 ,10 * (localElapsedTimeRate - 1))
            case .EASE_OUT_EXPO :
                return  -(pow(2, -10 * localElapsedTimeRate)) + 1
               
            case .EASE_IN_OUT_EXPO :
                let it = localElapsedTimeRate * 2
                let it2 = it - 1
                return (it < 1) ? pow( 2, 10 * (it - 1) ) * 0.5
                        : ( -( pow( 2,-10 * it2) ) + 2 ) * 0.5
            case .SPRING_BOUNCE_OUT :
                return
                    pow(2,-10 * localElapsedTimeRate) * sin( ( (2 * Float.pi) * ( localElapsedTimeRate - (0.3 / 4) ) ) / 0.3 ) + 1
            case .DECELERATE :
                return   1 - (1 - localElapsedTimeRate) * (1 - localElapsedTimeRate)
            case .ACCELERATE:
                return localElapsedTimeRate * localElapsedTimeRate
            case .ACCELERATE_DECELERATE :
                return  (cos( (localElapsedTimeRate + 1) * Float.pi ) / 2) + 0.5
            case .ANTICIPATE :
                return  localElapsedTimeRate * localElapsedTimeRate * ( (2 + 1) * localElapsedTimeRate - 2 )
            case .ANTICIPATEOVERSHOOT :
                return localElapsedTimeRate < 0.5 ? 0.5 * a(localElapsedTimeRate * 2.0,(2 * 1.5))
                    : 0.5 * ( o(localElapsedTimeRate * 2 - 2, (2 * 1.5)) + 2 )
            case .BOUNCE :
                let t = localElapsedTimeRate * 1.1226
                if t < 0.3535 { return getBounce(t) }
                else if t < 0.7408 {return  getBounce(t - 0.54719) + 0.7 }
                else if t < 0.9644 { return getBounce(t - 0.8526) + 0.9 }
                else { return getBounce( t - 1.0435 ) + 0.95 }
                
            case .FAST_OUT_LINEAR :
                return getLookUpTableInterpolator(input: localElapsedTimeRate, values: JJInterpolatorFastOutLinearIn.VALUES)
            case .FAST_OUT_SLOW_IN :
                 return getLookUpTableInterpolator(input: localElapsedTimeRate, values: JJInterpolatorFastOutSlowIn.VALUES)
            case .OVERSHOOT :
                let t :Float = localElapsedTimeRate - 1
                return t * t * ( (2 + 1) * t + 2 ) + 1
            case .CYCLE:
                if localElapsedTimeRate >= 1 { return 0 }
                return sin(2 * 1 * Float.pi * localElapsedTimeRate)
            case .CYCLE_DOUBLE:
                 if localElapsedTimeRate >= 1 { return 0 }
                return sin(2 * 2 * Float.pi * localElapsedTimeRate)
           }
        }
    

      
       private  func getPowIn(_ elapsedTimeRate: Float,_ p: Float) -> Float {
           return pow(elapsedTimeRate, p)
       }
       
       private  func getPowOut(_ elapsedTimeRate: Float,_ p: Float)-> Float {
           return  1 - pow(1 - elapsedTimeRate, p)
       }

       
       private  func getPowInOut(_ elapsedTimeRate: Float,_ p: Float)-> Float {
           let localElapsedTimeRate = elapsedTimeRate * 2
           return  localElapsedTimeRate < 1  ?
               ( 0.5 * pow(localElapsedTimeRate, p) )
            : (  1 - 0.5 * abs( pow(2 - elapsedTimeRate, p) ) )
       }

    
       private  func getBackInOut(_ elapsedTimeRate: Float,_ amount: Float)-> Float {
           let localAmount = amount * 1.525
            let it = elapsedTimeRate * 2
            let it2 = it - 2
           return  it < 1 ?
               ( 0.5 * (it * it * ( (localAmount + 1) * it - localAmount ) ) )
        : ( 0.5 * (it2 * it2 * ( (localAmount + 1) * it2 + localAmount ) + 2 ) )
       }

  
    
       private  func getBounceIn(_ elapsedTimeRate: Float)-> Float {
           return 1 - getBounceOut(1 - elapsedTimeRate)
       }

    
       private  func getBounceOut(_ elapsedTimeRate: Float)-> Float {
           if elapsedTimeRate < (1 / 2.75) {
                return (7.5625 * elapsedTimeRate * elapsedTimeRate)
           } else if elapsedTimeRate < (2 / 2.75)  {
                let it = elapsedTimeRate - (1.5 / 2.75)
                return 7.5625 * it * it + 0.75
           }else if elapsedTimeRate < (2.5 / 2.75)  {
                let it =  elapsedTimeRate - (2.25 / 2.75)
                return 7.5625 * it * it + 0.9375
           }else {
                let it = elapsedTimeRate - (2.625 / 2.75)
                return   7.5625 * it  * it + 0.984375
           }
       }

      
       private  func getElasticIn(_ elapsedTimeRate: Float,_ amplitude: Float,_ period: Float)-> Float {
            if (elapsedTimeRate == 0 || elapsedTimeRate == 1) {return elapsedTimeRate}
            let pi2 = Float.pi * 2
            let s = period / pi2 * asin(1 / amplitude)
            let it = elapsedTimeRate - 1
            return -( amplitude * pow( 2,10 * it ) * sin( (it - s) * pi2 / period ) )
       }

     
       private  func getElasticOut(_ elapsedTimeRate: Float,_ amplitude: Float,_ period: Float)-> Float {
            if (elapsedTimeRate == 0 || elapsedTimeRate == 1) {return elapsedTimeRate}
            let pi2 = Float.pi * 2
            let s = period / pi2 * asin(1 / amplitude)
            return ( amplitude * pow(2, -10 * elapsedTimeRate) * sin( (elapsedTimeRate - s) * pi2 / period ) + 1 )
       }

    
    
       private  func getElasticInOut(_ elapsedTimeRate: Float, _ amplitude: Float,_ period: Float) -> Float {
           let pi2 = Float.pi * 2
           let s = period / pi2 * asin(1 / amplitude)
           let it = elapsedTimeRate * 2
           let it2 = it - 1
           return  it < 1 ? ( -0.5 * ( amplitude * pow(2, 10 * it2) * sin( (it2 - s) * pi2 / period ) ) )
        : ( amplitude * pow(2,-10 * it2) * sin( (it2 - s) * pi2 / period ) * 0.5 + 1 )
       }

    
    private func getBounce(_ t:Float) -> Float {
        return t * t * 8.0
    }
    
    //anticipateOvershoot
    private func a(_ t: Float,_ s:Float) -> Float{
          return t * t * ( (s + 1) * t - s )
      }
      
    private func o(_ t: Float,_ s:Float) -> Float{
         return t * t * ( (s + 1) * t + s )
    }
      
    private func getLookUpTableInterpolator(input: Float, values:[Float]) -> Float{
        if input >= 1 { return 1 }
        if input <= 0 { return 0 }
        let stepSize =  1 / Float(values.count - 1)
        let position = min( Int(input) * (values.count - 1) , values.count - 2)
        let quantized = Float(position) * stepSize
        let diff = input - quantized
        let weight = diff / stepSize
        return values[position] + weight * ( values[position + 1] - values[position] )
    }
}

