//
//  JJAnimator.swift
//
//  Created by Juan J LF on 3/26/20.
//  Copyright © 2020 Juan J LF. All rights reserved.
//

import Foundation

/**
   This is the superclass for classes which provide basic suppoert for animations which can be
   started, ended, and have JJAnimatorListener added to them.
 */
public class JJAnimator {
    
    var mPaused = false
    var mDuration : Int = 0
    var mListener : JJAnimatorListener?
    var mPauseListener : JJAnimatorPauseListener?
    var mStarted: Bool = false
    var mDelay : Int = 0
    var mIsRunning : Bool = false
    var mResumed : Bool = false
    var mRepeatMode: JJAnimator.RepeatMode = .restart
    var mRepeatCount : Int = 0
    
    /**
        The value used to indicate infinite duration (e.g. when Animators repeat infinitely).
     */
    public static let REPEAT_INFINITE : Int = -1
    
    public func start(){
        mStarted = true
        mListener?.onAnimationStart(self)
    }
    //animation repeat count complete
    public func end(){
        mListener?.onAnimationEnd(self)
    }
    //animation cancel but still tracks
    public func cancel(){
        mListener?.onAnimationCancel(self)
    }
    public func resume(){
        mPauseListener?.onAnimationResume(self)
    }

    public func pause(){
        if IsStarted() && !mPaused {
            mPaused = true
            mResumed = false
            mIsRunning = false
            mPauseListener?.onAnimationPause(self)
        }
        
    }
    
    func endAnimation(){
        self.mPaused = false
        self.mStarted = false
        self.mIsRunning = false
        self.mResumed = false
    }
    public func isPaused()-> Bool{
        return mPaused
    }
    public func getDuration()->Int{
        return mDuration
    }
    public func IsStarted() -> Bool {
        return mStarted
    }
    
    public func getDelay() -> Int{
        return mDelay
    }
    
   public func getTotalDuration()-> Int{
        let duration = getDuration()
        if mRepeatCount == JJAnimator.REPEAT_INFINITE {
            return -1
        }else{
            return getDelay() + duration
        }
    }
    
    public func addListener(_ listener: JJAnimatorListener){
        mListener = listener
    }
    
   public func removeListener(){
          mListener = nil
    }
    
    public func getListener() -> JJAnimatorListener? {
        return mListener
    }
    public func addPauseListener(_ listener:JJAnimatorPauseListener){
        mPauseListener = listener
    }
    public func removePauseListener(){
        mPauseListener = nil
    }
    public func getPauseListener() -> JJAnimatorPauseListener? {
        return mPauseListener
    }

    
    public enum RepeatMode {
        case reverse,
        restart
    }
    
    public func getRepeatMode() -> JJAnimator.RepeatMode{
        return mRepeatMode
    }
    
}
