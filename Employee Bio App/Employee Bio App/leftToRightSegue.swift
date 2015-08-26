//
//  leftToRightSegue.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 21/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//


import UIKit
import QuartzCore

class leftToRightSegue: UIStoryboardSegue {
    
    override func perform() {
        var src: UIViewController = self.sourceViewController as! UIViewController
        var dst: UIViewController = self.destinationViewController as! UIViewController
        var transition: CATransition = CATransition()
        var timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.navigationController!.view.layer.addAnimation(transition, forKey: kCATransition)
        src.navigationController!.pushViewController(dst, animated: false)
    }
    
}