//
//  ViewController.swift
//  JJValueAnimator
//
//  Created by only-icesoul on 03/27/2020.
//  Copyright (c) 2020 only-icesoul. All rights reserved.
//

import UIKit
import JJValueAnimator

class ViewController: UIViewController {

    @IBOutlet weak var mLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        mLabel.isUserInteractionEnabled = true
        mLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        

        
        
    }
    
    private var mCurrentAnimator: JJValueAnimator?
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        mCurrentAnimator?.cancel()
        mCurrentAnimator = nil
        mCurrentAnimator = JJValueAnimator.ofFloat(0, to: 100).addUpdateListener({
            [weak self ] (value) in
                self?.mLabel.text = "\(Int(value))"
            })
        .setDuration(10000) // 10seg
        .setFramerate(20) // default 60
      //.setInterpolator(JJInterpolator(ease: .ANTICIPATEOVERSHOOT))
       .setInterpolator(JJInterpolatorCycle(cycles: 4))
        //    .setRepeatCount(10)
        mCurrentAnimator?.addListener(OnAnimationListener(self))
        mCurrentAnimator?.start()
       
    }

}




class OnAnimationListener : JJAnimatorListener {
    
    private weak var ins : ViewController?
    init(_ instance: ViewController) {
        ins = instance
    }
    
    func onAnimationStart(_ animation: JJAnimator) {
       print("onAnimationStart")
    }
    
    func onAnimationEnd(_ animation: JJAnimator) {
        print("onAnimationEnd")
        ins?.mLabel.text = " end: \(ins?.mLabel.text ?? " ") THANK YOU"
    }
    
    func onAnimationCancel(_ animation: JJAnimator) {
        print("onAnimationCancel")
    }
    
    func onAnimationRepeat(_ animation: JJAnimator) {
         print("onAnimationRepeat")
    }
    
}
