//
//  TrafficLight.swift
//  Traffic Lights
//
//  Created by Micah Napier on 2/5/17.
//
//

import UIKit

class TrafficLight: UIImageView {
    
    enum TrafficState {
        case red, amber, green
    }
    
    enum Direction {
        case northSouth, eastWest
    }
    
    init(direction: Direction) {
        super.init(image: nil)
        self.direction = direction
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }
        
    var direction: Direction = .northSouth {
        didSet {
            reset()
        }
    }
    
    var state: TrafficState = .red {
        
        didSet {
            switch state {
            case .red:
                image = UIImage(named: "red.png")
                break
            case .amber:
                image = UIImage(named: "amber.png")
                break
            case .green:
                image = UIImage(named: "green.png")
                break
            }
        }
    }
    
    public func reset() {
        state = direction == .northSouth ? .red : .green
    }
}
