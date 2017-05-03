//
//  Sequencer.swift
//  Traffic Lights
//
//  Created by Micah Napier on 3/5/17.
//
//

import Foundation

class Sequencer: NSObject {
    
    private var trafficLights: [TrafficLight] = []
    private var timer: Timer?
    private let redGreenTime: Int
    private let amberTime: Int
    
    init(trafficLights: [TrafficLight], redGreenTime: Int, amberTime: Int) {
        self.trafficLights = trafficLights
        self.redGreenTime = redGreenTime
        self.amberTime = amberTime
        super.init()
    }
    
    public func start() {
        
        guard !trafficLights.isEmpty else {
            return
        }
        updateLightsAfter(seconds: redGreenTime)
    }
    
    public func stop() {
        
        timer?.invalidate()
        
        trafficLights.forEach { (light) in
            light.reset()
        }
    }
    
    private func updateLightsAfter(seconds: Int) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(updateTrafficLights), userInfo: nil, repeats: false)
    }
    
    @objc private func updateTrafficLights() {
        
        let greenLights = trafficLights.filter( { $0.state == .green } )
        
        if !greenLights.isEmpty {

            greenLights.forEach({ (light) in
                light.state = .amber
            })

            updateLightsAfter(seconds: amberTime)
            
        } else {
            trafficLights.forEach({ (light) in
                light.state = light.state == .amber ? .red : .green
            })
            start()
        }
        
    }
}
