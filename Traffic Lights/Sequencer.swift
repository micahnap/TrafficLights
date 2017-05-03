//
//  Sequencer.swift
//  Traffic Lights
//
//  Created by Micah Napier on 2/5/17.
//
//

import Foundation

class Sequencer: NSObject {
    
    private var trafficLights: [TrafficLight] = []
    private var isStopped: Bool = true
    private var timer: Timer?
    
    init(trafficLights: [TrafficLight]) {
        self.trafficLights = trafficLights
        super.init()
    }
    
    public func start() {
        
        guard !trafficLights.isEmpty else {
            return
        }
        
        isStopped = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(5)), execute: { self.updateTrafficLights() } )

    }
    
    public func stop() {
        isStopped = true
    }
    
    @objc private func updateTrafficLights() {
        
        guard !isStopped else {
            return
        }
        
        let greenLights = trafficLights.filter( { $0.state == .green } )
        
        if !greenLights.isEmpty {

            greenLights.forEach({ (light) in
                light.state = .amber
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(5)), execute: { self.updateTrafficLights() } )
            
        } else {
            trafficLights.forEach({ (light) in
                light.state = light.state == .amber ? .red : .green
            })
            start()
        }
        
    }
}
