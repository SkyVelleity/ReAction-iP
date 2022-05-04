//
//  ContentView.swift
//  ReAction-iP
//
//  Created by Sky on 2022/5/4.
//

import SwiftUI

struct ContentView: View {
    var tapped = false
    @State var currentErrorState = "nope"
    @State var x = "No updates yet"
    @State var y = "No updates yet"
    @State var z = "No updates yet"

    var customMotion = CustomMotionManager()

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
        Button("FUCK") {customMotion.startDeviceMotion(&currentErrorState)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
