//
//  JJJJValueAnimator.swift
//
//  Created by Juan J LF on 3/27/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import UIKit

public class JJValueAnimator : JJAnimator {
public static func ofFloat(_ value:Float,to:Float) -> JJValueAnimator{
let va = JJValueAnimator()
va.mSv = value
va.mEv = to
va.mRvEv = value
va.mRvSv = to
return va
}
private var mT : Timer?
private var mTF:Double = 0
private var mFr : Int = 60
private var mUL : ((Float)->Void)?
private var mE = FloatEvaluator()
private var mIn : JJTimeInterpolator =  JJInterpolator(ease: .LINEAR)
private var mSv:Float = 0
private var mEv : Float = 0
private var mRvSv:Float = 0
private var mRvEv : Float = 0
private var mRdV = false
private var mRptCH = 0
@discardableResult
public func setDuration(_ millis: Int) -> JJValueAnimator {
if( millis < 0){ fatalError("Animators cannot have negative duration: \(millis)") }
mDuration =  millis
return self
}
@discardableResult
public func setStartDelay(_ millis : Int)-> JJValueAnimator{
if( millis < 0){ fatalError("Animators cannot have negative startDelay: \(millis)") }
self.mDelay =  millis
return self
}
@discardableResult
public func setFramerate(_ value : Int)-> JJValueAnimator{
if( value < 0){ fatalError("Animators cannot have negative framerate: \(value)") }
self.mFr = value < 10 ? 10 : value
return self
}
@discardableResult
public func setStartValue(_ float: Float) -> JJValueAnimator {
mSv = float
mRvEv = float
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
mRptCH = mRepeatCount
return self
}
@discardableResult
public func setEndValue(_ float: Float) -> JJValueAnimator {
mEv = float
mRvSv = float
return self
}
@discardableResult
public func addUpdateListener(_ listener: (@autoclosure @escaping (Float)->Void)) -> JJValueAnimator{
mUL = listener
return self
}

@discardableResult
public func setInterpolator(_ interpolator: JJTimeInterpolator) -> JJValueAnimator{
mIn = interpolator
return self
}
override public func end() {
if mStarted {
endAnimation()
ntfyEUL()
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
sAnim()
super.resume()

}
}
override public func pause() {
if mIsRunning && mStarted {
clrT()
super.pause()
}

}
override public func start(){
if !mStarted{
sAnim()
super.start()
}
}
private func sAnim(){
clrT()
if iIfe() || cRC() {
mkAnim()
}
else if cD()  && cTF() {
mkAnim()
}
else {
end()
}
}
private func mkAnim(){
let i =  gIts()
let ti  = gTI(i)
let tfi = gTFI(i)
let d = mResumed ? 0 : (mDelay/1000)
self.mT = Timer.init(fire: Date(timeIntervalSinceNow: TimeInterval(d)), interval: TimeInterval(ti), repeats: true) { (timer) in

self.mIsRunning = true
let fr = Double(self.mIn.getInterpolation(input: Float(self.mTF)))
let value = self.mE.evaluate(fraction: Float(fr), startValue: self.mSv, endValue: self.mEv)
self.mUL?(value)
self.sEAnim(tfi)

}
    RunLoop.current.add(self.mT!, forMode: .common)
}
override func endAnimation(){
clrT()
rstTF()
super.endAnimation()
}
private func clrT(){
mT?.invalidate()
mT = nil
}
private func iIfe() -> Bool {
return mRepeatCount == JJAnimator.REPEAT_INFINITE
}
private func gIts()-> Double {
let fr =  Double(mDuration) / 1000 * Double(self.mFr)
let r = fr.truncatingRemainder(dividingBy: 1)
return r > 0 ? fr + (1 - r) : fr
}
private func gTI(_ iterations: Double)-> Double{
return  (Double(mDuration) / 1000) / iterations
}
private func gTFI(_ iterations:Double) -> Double {
return  1 / iterations
}
private func gIIFe() -> Double {
let v =  Double(self.mFr)
return v < 2 ? 2 : v
}
private func uTF(_ fi: Double){
self.mTF += fi
}
private func cD() -> Bool {
return self.mDuration > 0
}
private func cTF() -> Bool {
return self.mTF < 0.999
}
private func rvV(){
if mRdV {
idV()
mRdV = false
}else {
self.mSv = self.mRvSv
self.mEv = self.mRvEv
mRdV = true
}

}
private func idV(){
self.mSv = self.mRvEv
self.mEv = self.mRvSv
}
private func iRR()-> Bool{
return mRepeatMode == JJAnimator.RepeatMode.reverse
}
private func rstTF(){
self.mTF = 0
}
private func dcrRC(){
self.mRepeatCount < 0 ? (self.mRepeatCount = 0) : (self.mRepeatCount -= 1)
}
private func mkR(){
if self.iRR() {
self.rvV()
self.rstTF()
}else{
self.idV()
self.rstTF()
}
}
private func sEAnim(_ timeFraction: Double){
if self.mTF >= 0.999 {
if self.iIfe() {
self.mkR()
self.mListener?.onAnimationRepeat(self)
}else if self.mRepeatCount > 0{
self.dcrRC()
self.mkR()
self.mListener?.onAnimationRepeat(self)
}else {
self.end()
}
}else{
self.uTF(timeFraction)
}
}
private func cRC() -> Bool {
return mRptCH != 0
}
private func ntfyEUL(){
let fr = Double(self.mIn.getInterpolation(input: 1))
let value = self.mE.evaluate(fraction: Float(fr), startValue: self.mSv, endValue: self.mEv)
print("ending",self.mTF,value)
self.mUL?(value)
}
}
