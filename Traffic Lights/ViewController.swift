//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var northLight: TrafficLight!
    @IBOutlet weak var southLight: TrafficLight!
    @IBOutlet weak var eastLight: TrafficLight!
    @IBOutlet weak var westLight: TrafficLight!
    
    private var sequencer: Sequencer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLights()
    }

    private func setupLights() {
        
        sequencer = Sequencer(trafficLights: [northLight, southLight, eastLight, westLight])
        resetLights()
    }
    
    private func resetLights() {
        
        [northLight, southLight].forEach { (trafficLight) in
            trafficLight!.direction = .northSouth
        }
        
        [eastLight, westLight].forEach { (trafficLight) in
            trafficLight!.direction = .eastWest
        }
        
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        guard sender.isSelected else {
            sequencer.stop()
            resetLights()
            return
        }
        
        sequencer.start()
    }
}

