//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var northSouthLights: [TrafficLight]!
    @IBOutlet var eastWestLights: [TrafficLight]!
    
    private var sequencer: Sequencer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLights()
    }

    private func setupLights() {
        
        sequencer = Sequencer(trafficLights: northSouthLights + eastWestLights, redGreenTime: 30, amberTime: 5)
        
        northSouthLights.forEach { (trafficLight) in
            trafficLight.direction = .northSouth
        }
        
        eastWestLights.forEach { (trafficLight) in
            trafficLight.direction = .eastWest
        }
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? sequencer.start() : sequencer.stop()
    }
}

