# JJValueAnimator


[![Version](https://img.shields.io/cocoapods/v/JJValueAnimator.svg?style=flat)](https://cocoapods.org/pods/JJValueAnimator)
[![License](https://img.shields.io/cocoapods/l/JJValueAnimator.svg?style=flat)](https://cocoapods.org/pods/JJValueAnimator)
[![Platform](https://img.shields.io/cocoapods/p/JJValueAnimator.svg?style=flat)](https://cocoapods.org/pods/JJValueAnimator)


## Requirements

```
 ios platform 12
```

## Installation

JJValueAnimator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JJValueAnimator'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## What can u do?

![demo](assets/output.gif)


## Usage

ValueAnimator makes the transition from initial value to target.

Simple Linear Animation

````swift
import JJValueAnimator

let anim = JJValueAnimator.ofFloat(0, to: 100).addUpdateListener({
            [weak self ] (value) in
                // do something with value
            })
        .setDuration(400) // millis
       
anim.start()
````

## Thread 

JJValueAnimator uses the current thread.


## Interpolator
The time interpolator used in calculating the elapsed fraction of the animation. The default value is Linear.

Intepolators start with JJInterpolator.

```swift
import JJValueAnimator

let  anim = JJValueAnimator...
anim.setInterpolator(JJInterpolator(ease: .ANTICIPATEOVERSHOOT))

// or

anim.setInterpolator(JJInterpolatorCycle(cycles: 4))

```



## Custom Interpolator 

You need to implement the JJTimeInterpolator protocol

```swift

class MyInterpolator : JJTimeInterpolator{


    override func getInterpolation(input: Float) -> Float {
        //do the magic
    }

}

anim.setInterpolator(MyInterpolator())

```

## Listeners 

Estan JJAnimatorListener y JJAnimatorPauseListener 

```swift
 anim.addListener(OnAnimationListener(self))
 anim.addPauseListener(MyAnimatorPauseListener(self))

```
