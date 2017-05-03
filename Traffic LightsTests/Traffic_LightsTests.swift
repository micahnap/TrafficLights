//
//  Traffic_LightsTests.swift
//  Traffic LightsTests
//

import XCTest
@testable import Traffic_Lights

class Traffic_LightsTests: XCTestCase {
    
    private var northSouthLight = TrafficLight(direction: .northSouth)
    private var eastWestLight = TrafficLight(direction: .eastWest)
    
    func testDefaultTrafficLightState() {
        
        northSouthLight.direction = .northSouth
        eastWestLight.direction = .eastWest
        
        XCTAssertEqual(.red, northSouthLight.state)
        XCTAssertEqual(.green, eastWestLight.state)
    }
    
    func testTrafficLightImagesReflectState() {
        northSouthLight.state = .red
        XCTAssertEqual(#imageLiteral(resourceName: "red"), northSouthLight.image)
        
        northSouthLight.state = .amber
        XCTAssertEqual(#imageLiteral(resourceName: "amber"), northSouthLight.image)
        
        northSouthLight.state = .green
        XCTAssertEqual(#imageLiteral(resourceName: "green"), northSouthLight.image)
    }
    
    func testResetToLightsoDefaultState() {
        northSouthLight.state = .amber
        eastWestLight.state = .red
        [northSouthLight, eastWestLight].forEach { (light) in
            light.reset()
        }
        
        XCTAssertEqual(.red, northSouthLight.state)
        XCTAssertEqual(.green, eastWestLight.state)
    }
    
    
}
