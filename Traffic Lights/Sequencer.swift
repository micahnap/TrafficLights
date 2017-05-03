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
    private var timerIsSuspended: Bool = true
    private let timer: DispatchSourceTimer = {
        let queue = DispatchQueue(label: "com.traffic.app.timer", attributes: .concurrent, target: .main)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        return timer
    }()
    private var dispatchTask: DispatchWorkItem!
    init(trafficLights: [TrafficLight]) {
        self.trafficLights = trafficLights
        
        super.init()
        
    }
    
    public func start() {
        
        guard !trafficLights.isEmpty else {
            return
        }
        
        dispatchTask = DispatchWorkItem { self.updateTrafficLights() }
        timer.scheduleRepeating(deadline: .now() + .seconds(5), interval: 5)
        timer.setEventHandler(handler: dispatchTask)
        timer.resume()

    }
    
    public func stop() {
        dispatchTask.cancel()
        timer.suspend()
    }
    
    private func updateTrafficLights() {
        
        guard !dispatchTask.isCancelled else {
            return
        }
        let greenLights = trafficLights.filter( { $0.state == .green } )
        
        if !greenLights.isEmpty {

            timer.suspend()
            greenLights.forEach({ (light) in
                light.state = .amber
            })

            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(5)), execute: dispatchTask)
            
        } else {
            trafficLights.forEach({ (light) in
                light.state = light.state == .amber ? .red : .green
            })
            start()
        }
        
    }
}
