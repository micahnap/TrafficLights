//
//  SequencerTests.swift
//  Traffic Lights
//
//  Created by Micah Napier on 4/5/17.
//
//

import XCTest
@testable import Traffic_Lights

class SequencerTests: XCTestCase {
    
    private var northSouthLight = TrafficLight(direction: .northSouth)
    private var eastWestLight = TrafficLight(direction: .eastWest)
    private var sequencer : Sequencer?
    var northExp: XCTestExpectation!
    var eastExp: XCTestExpectation!
    override func setUp() {
        super.setUp()
        
        northSouthLight.state = .red
        eastWestLight.state = .green
        sequencer = Sequencer(trafficLights: [northSouthLight, eastWestLight], redGreenTime: 3, amberTime: 1)
        sequencer?.start()
        
        northExp = expectation(description:"Red light change to green light")
        eastExp = expectation(description:"Red light change to green light")
        
    }
    
    override func tearDown() {
        sequencer?.stop()
        super.tearDown()
    }
    
    func testStateTransitionToAmber() {
        
        queueTask(task: {
         self.northSouthLight.state == .red ? self.northExp.fulfill() : XCTFail("Red light should not change")
         self.eastWestLight.state == .amber ? self.eastExp.fulfill() : XCTFail("Green light did not change to amber")
        }, seconds: 3)

    }
    
    func testStopSequencerResetsLights() {
        northSouthLight.state = .green
        eastWestLight.state = .amber
        sequencer?.stop()
        
        if northSouthLight.state == .red && eastWestLight.state == .green {
            northExp.fulfill()
            eastExp.fulfill()
        }
        wait(for: [northExp, eastExp], timeout: TimeInterval(2))
    }
    
    func testTransitionFromRedToGreen() {
        
        queueTask(task: {
            self.northSouthLight.state == .green ? self.northExp.fulfill() : XCTFail("Green light did not change to amber")
            self.eastWestLight.state == .red ? self.eastExp.fulfill() : XCTFail("Amber light did not change to red")
        }, seconds: 4)
    }
    
    func queueTask(task: @escaping () -> Void, seconds: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            task()
        }
        
        wait(for: [northExp, eastExp], timeout: TimeInterval(10))
    }
}
