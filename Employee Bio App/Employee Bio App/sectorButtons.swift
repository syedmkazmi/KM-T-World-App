//
//  sectorButtons.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 24/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import Foundation
import UIKit

class sectorButtons:UIButton{
    
    required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.layer.cornerRadius = 0.0;
    self.layer.borderColor = UIColor.blackColor().CGColor
    self.layer.borderWidth = 0.3
    self.backgroundColor = UIColor.whiteColor()
    self.tintColor = UIColor.blackColor()
    
    }

}