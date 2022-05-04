//
//  motionManager.swift
//  ReAction-iP
//
//  Created by Sky on 2022/5/4.
//

import Foundation
import CoreMotion


class CustomMotionManager {
    let motion = CMMotionManager()
    var timer : Timer?
    
    func startDeviceMotion(_ error: inout String) {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true, block: { (timer) in
                if let data = self.motion.deviceMotion {
                    let x = data.userAcceleration.x
                    let y = data.userAcceleration.y
                    let z = data.userAcceleration.z
                    
                    print("\(x), \(y), \(z)")
                }
                
            })
            
            RunLoop.current.self.add(self.timer!, forMode: RunLoop.Mode.default)
            
        } else {
            error = "Whoopsies!\nLooks like we did a fucko boingo!"
        }
    }
}
