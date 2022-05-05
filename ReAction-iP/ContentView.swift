//
//  ContentView.swift
//  ReAction-iP
//
//  Created by Sky on 2022/5/4.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    @State var tapped = false

    @State var currentErrorState = "nope"
    @State var x = "No updates yet"
    @State var y = "No updates yet"
    @State var z = "No updates yet"

    let motion = CMMotionManager()
    

    
    
    var body: some View {
        if tapped {
            VStack{
                Text("TAPPED")
                Text("Accel readings:")
                Text("X: \(x)")
                Text("Y: \(y)")
                Text("Z: \(z)")
                Divider()
                Spacer()
            }
            .background(Color.green)
            
        } else {
            VStack{
                Text(currentErrorState)
                Button("FUCK") {startDeviceMotion()}  //Bundle closure that can update XY&Z as well as tapped
                    .multilineTextAlignment(.center)
                Divider()
                Spacer()
            }
            .background(Color.red)
        }
        
        
      
    }
    
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            currentErrorState = "nope"
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            var timer : Timer?
            timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true, block: { (timer) in
                if let data = self.motion.deviceMotion {
                    x = String(format: "%.2f", data.userAcceleration.x)
                    y = String(format: "%.2f", data.userAcceleration.y)
                    z = String(format: "%.2f", data.userAcceleration.z)
                    
                    print("\(x), \(y), \(z)")
                    
                    if (data.userAcceleration.x > 0.1 || data.userAcceleration.y > 0.1 || data.userAcceleration.z > 0.1){
                        tapped = true
                    } else {
                        tapped = false
                    }
                }
                
            })
            
            RunLoop.current.self.add(timer!, forMode: RunLoop.Mode.default)
            
            
        } else {
            currentErrorState = "Whoopsies!\nLooks like we did a fucko boingo!"
        }
    }
    
    
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


