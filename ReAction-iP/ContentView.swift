//
//  ContentView.swift
//  ReAction-iP
//
//  Created by Sky on 2022/5/4.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    var tapped = false

    @State var currentErrorState = "nope"
    @State var x = "No updates yet"
    @State var y = "No updates yet"
    @State var z = "No updates yet"

    let motion = CMMotionManager()
    

    
    
    var body: some View {
        if tapped {
            Text("TAPPED")
                .foregroundColor(.green)
        } else {
        Text(currentErrorState)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            
        }
        
        Text("Accel readings:")
        Text("X: \(x)")
        Text("Y: \(y)")
        Text("Z: \(z)")
       // Button("FUCK") {customMotion.startDeviceMotion(&currentErrorState)}  //Bundle closure that can update XY&Z as well as tapped
    }
    
    func startDeviceMotion(_ error: inout String) {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            var timer : Timer?
            timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true, block: { (timer) in
                if let data = self.motion.deviceMotion {
                    let x = data.userAcceleration.x
                    let y = data.userAcceleration.y
                    let z = data.userAcceleration.z
                    
                    print("\(x), \(y), \(z)")
                }
                
            })
            
            RunLoop.current.self.add(timer!, forMode: RunLoop.Mode.default)
            //QuickTest
            
        } else {
            error = "Whoopsies!\nLooks like we did a fucko boingo!"
        }
    }
    
    
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


