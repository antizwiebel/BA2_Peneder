//
//  OrientationUtility.swift
//  BA2_Peneder
//
//  Created by Mark Peneder on 01.03.18.
//  Copyright © 2018 Mark Peneder. All rights reserved.
//

import Foundation
import UIKit

///helper methods to lock orientation in a view
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    ///  Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
