//
//  JJValueAnimator.swift
//
//  Created by Juan J LF on 3/27/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//
import UIKit


public class JJValueAnimator : JJAnimator{
    
    
    static public func ofFloat(_ value:Float,to:Float) -> JJValueAnimator{
        let va = JJValueAnimator()
        va.mStartValue = value
        va.mEndValue = to
        va.mReverseEndValue = value
        va.mReverseStartValue = to
        return va
    }
    
    private var mDisplayLink : CADisplayLink?
    private var mTimeFraction:Double = 0
    private var mUpdateListener : ((Float)->Void)?
    private var mEvaluator = FloatEvaluator()
    private var mInterpolator : JJTimeInterpolator =  JJInterpolator(ease: .LINEAR)
    private var mStartValue:Float = 0
    private var mEndValue : Float = 0
    private var mReverseStartValue:Float = 0
    private var mReverseEndValue : Float = 0
    private var mReversedValues = false
    private var mRepeatCountHolder = 0
    @discardableResult
    public func setDuration(_ millis: Int) -> JJValueAnimator {
        if( millis < 0){ fatalError("Animators cannot have negative duration: \(millis)") }
        mDuration =  millis
        return self
    }
    @discardableResult
    public func setDelay(_ millis : Int)-> JJValueAnimator{
        if( millis < 0){ fatalError("Animators cannot have negative startDelay: \(millis)") }
        self.mDelay =  millis
        return self
    }
    @discardableResult
    public func setStartValue(_ float: Float) -> JJValueAnimator {
        mStartValue = float
        mReverseEndValue = float
        return self
    }
    @discardableResult
    public func setRepeatMode(_ mode: JJAnimator.RepeatMode) -> JJValueAnimator {
        mRepeatMode = mode
        return self
    }
    @discardableResult
    public func setRepeatCount(_ count: Int) -> JJValueAnimator {
        mRepeatCount = count < -1 ? 0 : count
        mRepeatCountHolder = mRepeatCount
        return self
    }
    @discardableResult
    public func setEndValue(_ float: Float) -> JJValueAnimator {
        mEndValue = float
        mReverseStartValue = float
        return self
    }
    @discardableResult
    public func addUpdateListener(_ listener: (@autoclosure @escaping (Float)->Void)) -> JJValueAnimator{
        mUpdateListener = listener
        return self
    }
  
    @discardableResult
    public func setInterpolator(_ interpolator: JJTimeInterpolator) -> JJValueAnimator{
        mInterpolator = interpolator
        return self
    }
    override public func end() {
        if mStarted {
            endAnimation()
            notifyEndUpdateListener()
            super.end()
        }
    }
    override public func cancel() {
        if mStarted {
            endAnimation()
            super.cancel()
        }
    }
    override public func resume() {
        if !mIsRunning  && mPaused {
            mResumed = true
            mPaused = false
            startAnimation()
            super.resume()
            
        }
    }
    override public func pause() {
        if mIsRunning && mStarted {
            clearDisplayLink()
            super.pause()
        }
        
    }
    override public func start(){
        if !mStarted{
            startAnimation()
            super.start()
        }
    }
    private func startAnimation(){
        clearDisplayLink()
        //resume infinte and repeat count
        if isInfinite() || checkRepeatCount() {
            makeAnimation()
        }
        else if checkDuration()  && checkTimeFraction() {
            makeAnimation()
        } //resume in final close fraction, one repeat
        else {
           end()
       }
    }
    
    
    
    private func makeAnimation(){
        let delay : Double = mResumed ? 0 : Double(mDelay) / 1000.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.mDisplayLink = CADisplayLink(target: self, selector: #selector(self.displayAnimation(_:)))
            self.mDisplayLink?.add(to: .main, forMode: .default)
        }
       
    }
    
    private var mTimeFractionInterval:Double = 0
    private var mFrameRate = 0
    @objc func displayAnimation(_ link:CADisplayLink){
        
        if mFrameRate == 0 {
             mFrameRate = Int(round(1.0 / Double(link.duration)))
            let frt = Int(round(Double(mFrameRate * mDuration) / 1000.0))
             mTimeFractionInterval = 1.0 / Double(frt)
        }

  
        self.mIsRunning = true
        let fr = Double(self.mInterpolator.getInterpolation(input: Float(self.mTimeFraction)))
        let value = self.mEvaluator.evaluate(fraction: Float(fr), startValue: self.mStartValue, endValue: self.mEndValue)
        self.mUpdateListener?(value)
        self.shouldEndAnimation(mTimeFractionInterval)
    }
    

    override func endAnimation(){
        clearDisplayLink()
        resetTimeFraction()
        super.endAnimation()
    }
    
    private func clearDisplayLink(){
        mDisplayLink?.invalidate()
        mDisplayLink = nil
    }
    
    private func isInfinite() -> Bool {
        return mRepeatCount == JJAnimator.REPEAT_INFINITE
    }


    
   
    private func updateTimeFraction(_ fi: Double){
        self.mTimeFraction += fi
    }
    
    private func checkDuration() -> Bool {
        return self.mDuration > 0
    }
    
    private func checkTimeFraction() -> Bool {
        return self.mTimeFraction < 0.999
    }
    
    private func reverseValues(){
        if mReversedValues {
            identityValues()
            mReversedValues = false
        }else {
            self.mStartValue = self.mReverseStartValue
            self.mEndValue = self.mReverseEndValue
            mReversedValues = true
        }
      
    }
    
    private func identityValues(){
        self.mStartValue = self.mReverseEndValue
        self.mEndValue = self.mReverseStartValue
    }
    
    private func isRepeatReverse()-> Bool{
        return mRepeatMode == JJAnimator.RepeatMode.reverse
    }
    
    private func resetTimeFraction(){
        self.mTimeFraction = 0
    }
    private func decrementRepeatCount(){
        self.mRepeatCount < 0 ? (self.mRepeatCount = 0) : (self.mRepeatCount -= 1)
    }

    private func makeRepeat(){
        if self.isRepeatReverse() {
            self.reverseValues()
            self.resetTimeFraction()
        }else{
            self.identityValues()
            self.resetTimeFraction()
        }
    }
    
    private func shouldEndAnimation(_ timeFraction: Double){
        //este 0.99 me preocupa revisar en futuros
        if self.mTimeFraction >= 0.999 {
           if self.isInfinite() {
               self.makeRepeat()
               self.mListener?.onAnimationRepeat(self)
           }else if self.mRepeatCount > 0{
               self.decrementRepeatCount()
               self.makeRepeat()
               self.mListener?.onAnimationRepeat(self)
           }else {
               self.end()
           }
        }else{
           self.updateTimeFraction(timeFraction)
        }
    }
    
    private func checkRepeatCount() -> Bool {
        return mRepeatCountHolder != 0
    }
    
    private func notifyEndUpdateListener(){
        let fr = Double(self.mInterpolator.getInterpolation(input: 1))
        let value = self.mEvaluator.evaluate(fraction: Float(fr), startValue: self.mStartValue, endValue: self.mEndValue)
        self.mUpdateListener?(value)
    }
}

